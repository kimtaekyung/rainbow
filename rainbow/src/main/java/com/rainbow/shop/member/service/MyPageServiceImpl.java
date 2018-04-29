package com.rainbow.shop.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.rainbow.constant.Constant;
import com.rainbow.shop.item.dao.ItemDao;
import com.rainbow.shop.member.dao.MemberAuthDao;
import com.rainbow.shop.member.dao.MyPageDao;
import com.rainbow.util.AES256SecureUtil;
import com.rainbow.util.FileUploadUtil;
import com.rainbow.util.QuerystringPageing;
import com.rainbow.util.RSASecureUtil;
import com.rainbow.util.SHA512SecureUtil;
import com.rainbow.util.StringTool;
@Service
public class MyPageServiceImpl implements MyPageService{
	@Autowired
	MyPageDao myPageDao;
	
	@Autowired
	MemberAuthDao memberAuthDao;
	
	@Autowired
	ItemDao itemDao;
	
	@Resource
    private ApplicationContext applicationContext;
	/**
	 * 회원정보변경
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> updateMemberInfo(HttpServletRequest req) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HttpSession session = req.getSession();
		
		HashMap<String,Object> member = (HashMap<String,Object>)session.getAttribute("rb_member");
		
		
		if(!StringUtils.isEmpty(member.get("MB_SEQ"))){
			
			paramMap.put("mb_seq", member.get("MB_SEQ"));
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_id"),Constant.ID_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","1");		//아이디 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_id", req.getParameter("mb_id"));
				int result = memberAuthDao.checkMemberId(paramMap);
				if(result == 0) {
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","2");		//없는 아이디
					return resultMap;
				}else{
					if(StringUtils.isEmpty(req.getParameter("mb_password"))){
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data","3");		//비밀번호 값이 없음
						return resultMap;
					}else{
						
						String memberPassword = req.getParameter("mb_password");
						//원본 비밀번호
						String decRsaMemberPassword = RSASecureUtil.decryptRsa(req, memberPassword);
						
						
						if(!Constant.getRegexMatchResultOfString(decRsaMemberPassword,Constant.PW_REGULAR_EXPRESSTION)){
							resultMap.put("result", Constant.AJAX_RESULT_FAIL);
							resultMap.put("data","4");		//비밀번호 유효성 검사 실패
							return resultMap;
						}else{
							HashMap<String,Object> map = memberAuthDao.getMemberPassword(paramMap);
							
							//현재 입력 받은 비밀번호를 이전에 사용되었던 salt 를 이용해서 암호화한다.
							String comparePassword =  SHA512SecureUtil.incryptSha512(decRsaMemberPassword, (String)map.get("MB_SESSION_ID"));
							//패스워드 가 다름
							if(!comparePassword.equals((String)map.get("MB_PASSWORD"))) {
								resultMap.put("result", Constant.AJAX_RESULT_FAIL);
								resultMap.put("data","5");		//패스워드가 일치하지 않음.
								return resultMap;
								//비밀번호 일치
							}else{
								
								//비밀번호와 비밀번호 확인이 입력 되었을때만 체크
								if(!StringUtils.isEmpty(req.getParameter("new_mb_password")) && !StringUtils.isEmpty(req.getParameter("new_mb_password_confirm"))) {
									
									String newMbPassword = RSASecureUtil.decryptRsa(req, req.getParameter("new_mb_password"));
									String newMbPasswordConfirm = RSASecureUtil.decryptRsa(req, req.getParameter("new_mb_password_confirm"));
									
									
									if(!Constant.getRegexMatchResultOfString(newMbPassword,Constant.PW_REGULAR_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","6");		//새로운 비밀번호 유효성 검사 실패
										return resultMap;
									}else{
										if(!newMbPassword.equals(newMbPasswordConfirm)){
											resultMap.put("result", Constant.AJAX_RESULT_FAIL);
											resultMap.put("data","7");		//새로운 비밀번호와 새로운 비밀번호 확인 불일치
											return resultMap;
										}
									}
									
									newMbPassword =  SHA512SecureUtil.incryptSha512(newMbPassword, (String)map.get("MB_SESSION_ID"));
									paramMap.put("mb_password", newMbPassword);
								}
								
								//닉네임
								if(!StringUtils.isEmpty(req.getParameter("mb_nickname"))){
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_nickname"),Constant.NICKNAME_REGULAR_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","8");		//닉네임 유효성 검사 실패
										return resultMap;
									}else{
										//기존 닉네임 값과 다를 경우만 중복 체크
										if(!member.get("MB_NICKNAME").equals(req.getParameter("mb_nickname"))) {
											paramMap.put("mb_nickname", req.getParameter("mb_nickname"));
											int result2 = memberAuthDao.checkMemberNickName(paramMap);
											if(result2 != 0){
												resultMap.put("result", Constant.AJAX_RESULT_FAIL);
												resultMap.put("data","9");		//이미 존재 하는 닉네임
												return resultMap;
											}
										}
									}
								}else{
									resultMap.put("result", Constant.AJAX_RESULT_FAIL);
									resultMap.put("data","10");		//닉네임 값이 없음
									return resultMap;
								}
								
								//이메일
								if(StringUtils.isEmpty(req.getParameter("mb_email"))) {
									resultMap.put("result", Constant.AJAX_RESULT_FAIL);
									resultMap.put("data","11");		//이메일 입력이 되지않았음
									return resultMap;
								}else{
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_email"),Constant.EMAIL_REGULAR_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","12");		//이메일 유효성 검사 실패
										return resultMap;
									}else{
										paramMap.put("mb_email", req.getParameter("mb_email"));
										if(!member.get("MB_EMAIL").equals(req.getParameter("mb_email"))) {
											int result2 = memberAuthDao.checkMemberEmail(paramMap);
											if(result2 != 0){
												resultMap.put("result", Constant.AJAX_RESULT_FAIL);
												resultMap.put("data","25");		//이미 존재 하는 이메일
												return resultMap;
											}
										}
									}
								}
								
								//이벤트 수신여부
								if(StringUtils.isEmpty(req.getParameter("mb_event_receive"))){
									paramMap.put("mb_event_receive", "0");
								}else{
									paramMap.put("mb_event_receive", req.getParameter("mb_event_receive"));
								}
								
								//주소 값이 모두 입력 되었을때만 파라미터에 데이터를 셋팅한다.
								if(!StringUtils.isEmpty(req.getParameter("mb_zip_code")) 
										&& !StringUtils.isEmpty(req.getParameter("mb_address")) 
										&& !StringUtils.isEmpty(req.getParameter("mb_address_detail"))){
									
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_zip_code"),Constant.ZIPCODE_REGULAR_EXPRESSTION) || 
											!Constant.getRegexMatchResultOfString(req.getParameter("mb_address"),Constant.ADDRESS_REGULAR_EXPRESSTION) ||
											!Constant.getRegexMatchResultOfString(req.getParameter("mb_address_detail"),Constant.ADDRESS_DETAIL_REGULAR_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","13");		//주소 입력시 우편번호 유효성 검사 실패
										return resultMap;
									}else{
										paramMap.put("mb_zip_code", req.getParameter("mb_zip_code"));
										paramMap.put("mb_address", req.getParameter("mb_address"));
										paramMap.put("mb_address_detail", req.getParameter("mb_address_detail"));
									}
								}
								
								//전화번호
								if(!StringUtils.isEmpty(req.getParameter("mb_tel"))) {
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_tel"),Constant.TEL_REGULAR_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","14");		//전화번호 유효성 검사 실패
										return resultMap;
									}else{
										paramMap.put("mb_tel", req.getParameter("mb_tel"));
									}
								}
								
								//휴대폰번호
								if(StringUtils.isEmpty(req.getParameter("mb_hp"))) {
									resultMap.put("result", Constant.AJAX_RESULT_FAIL);
									resultMap.put("data","15");		//휴대폰 값이 없음
									return resultMap;
								}else{
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_hp"),Constant.HP_REGULAR_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","16");		//휴대폰 번호 유효성 검사 실패
										return resultMap;
									}else{
										AES256SecureUtil aes256 = new AES256SecureUtil();
										paramMap.put("mb_hp", aes256.aesEncode(req.getParameter("mb_hp")));
										if(!member.get("MB_HP").equals(req.getParameter("mb_hp"))) {
											int result2 = memberAuthDao.checkMemberHp(paramMap);
											if(result2 != 0){
												resultMap.put("result", Constant.AJAX_RESULT_FAIL);
												resultMap.put("data","26");		//이미 존재 하는 휴대폰 번호
												return resultMap;
											}
										}
										
									}
								}
								//예금주 
								if(!StringUtils.isEmpty(req.getParameter("mb_bank_owner"))) {
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_bank_owner"),Constant.BANK_OWNER_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","17");		//예금주 유효성 검사 실패
										return resultMap;
									}else{
										paramMap.put("mb_bank_owner", req.getParameter("mb_bank_owner"));
									}
								}
								
								//은행명
								if(!StringUtils.isEmpty(req.getParameter("mb_bank_name"))) {
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_bank_name"),Constant.BANK_NAME_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","18");		//예금주 유효성 검사 실패
										return resultMap;
									}else{
										paramMap.put("mb_bank_name", req.getParameter("mb_bank_name"));
									}
								}
								
								//계좌번호
								if(!StringUtils.isEmpty(req.getParameter("mb_bank_no"))) {
									if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_bank_no"),Constant.BANK_NO_EXPRESSTION)){
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","19");		//계좌번호 유효성 검사 실패
										return resultMap;
									}else{
										paramMap.put("mb_bank_no", req.getParameter("mb_bank_no"));
									}
								}
								
								if(StringUtils.isEmpty(req.getParameter("mb_type"))){
									throw new Exception();
								}else {
									
									//구매자 회원
									if(req.getParameter("mb_type").equals("1")){
										//입력이 되었을때만 체크
										if(!StringUtils.isEmpty(req.getParameter("mb_biz_tel"))){
											if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_tel"),Constant.BIZTELNO_REGULAR_EXPRESSTION)){
												resultMap.put("result", Constant.AJAX_RESULT_FAIL);
												resultMap.put("data","20");		//사업장 전화 유효성 검사 실패
												return resultMap;
											}else{
												paramMap.put("mb_biz_tel",req.getParameter("mb_biz_tel"));
											}
										}	
										
										//판매자 회원
									}else{
										//사업장 전화
										if(StringUtils.isEmpty(req.getParameter("mb_biz_tel"))){
											resultMap.put("result", Constant.AJAX_RESULT_FAIL);
											resultMap.put("data","21");		//사업장 번호 입력 안됨
											return resultMap;
										}else{
											if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_tel"),Constant.BIZTELNO_REGULAR_EXPRESSTION)){
												resultMap.put("result", Constant.AJAX_RESULT_FAIL);
												resultMap.put("data","22");		//사업장 전화 유효성 검사 실패
												return resultMap;
											}else{
												paramMap.put("mb_biz_tel",req.getParameter("mb_biz_tel"));
											}
										}
									}
									
								}
								
								int result3 = myPageDao.updateMemberInfo(paramMap);
								if(result3 == 1) {
									resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
									return resultMap;
								}else {
									resultMap.put("result", Constant.AJAX_RESULT_FAIL);
									resultMap.put("data","23");		//사업장 전화 유효성 검사 실패
									return resultMap;
								}
							}
						}
					}
				}
			}
		//세션정보 없음
		}else{
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","24");		//회원 시퀀스가 없음
			return resultMap;
		}
	}
	
	/**
	 * 사업자 정보 신청/변경
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> updateMemberBizInfo(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HttpSession session = req.getSession();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
//		StringTool.requestConsoleViewer(req);
		
		HashMap<String,Object> member = (HashMap<String,Object>)session.getAttribute("rb_member");
		
		if(!StringUtils.isEmpty(member.get("MB_SEQ"))){
			
			paramMap.put("mb_seq", member.get("MB_SEQ"));
			paramMap.put("mb_id", member.get("MB_ID"));
			paramMap.put("mb_nickname", member.get("MB_NICKNAME"));
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_name"),Constant.BIZNAME_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","1");//상호 입력 형식이 잘못됨
				return resultMap;
			}else{
				paramMap.put("mb_biz_name",req.getParameter("mb_biz_name"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_type"),Constant.BIZ_TYPE_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","2");//사업자 유형 바르지 않음
				return resultMap;
			}else{
				paramMap.put("mb_biz_type",req.getParameter("mb_biz_type"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_ceo_name"),Constant.BIZCEONAME_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","3");//대표자 이름 입력 형식이 바르지 않음
				return resultMap;
			}else{
				paramMap.put("mb_biz_ceo_name",req.getParameter("mb_biz_ceo_name"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_no"),Constant.BIZNO_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","4");//사업자번호 입력 형식이 바르지 않음
				return resultMap;
			}else{
				paramMap.put("mb_biz_no",req.getParameter("mb_biz_no"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_condition"),Constant.BIZ_CONDITION_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","5");//업태 입력 양식이 바르지 않음
				return resultMap;
			}else{
				paramMap.put("mb_biz_condition",req.getParameter("mb_biz_condition"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_category"),Constant.BIZ_CATEGORY_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","6");//업종 입력 양식이 바르지 않음
				return resultMap;
			}else{
				paramMap.put("mb_biz_category",req.getParameter("mb_biz_category"));
			}
			
			
			if(StringUtils.isEmpty(req.getParameter("mb_biz_zip_code")) 
					|| StringUtils.isEmpty(req.getParameter("mb_biz_address")) 
					|| StringUtils.isEmpty(req.getParameter("mb_biz_address_detail"))) {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","7");//주소입력이  완료되지 않음
				return resultMap;
			}else{
				
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_zip_code"),Constant.ZIPCODE_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","8");//우편번호 형식이 맞지 않음
					return resultMap;
				}else{
					paramMap.put("mb_biz_zip_code",req.getParameter("mb_biz_zip_code"));
				}
				
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_address"),Constant.ADDRESS_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","9");//기본주소 입력 형식이 맞지 않음
					return resultMap;
				}else{
					paramMap.put("mb_biz_address",req.getParameter("mb_biz_address"));
				}
				
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_address_detail"),Constant.ADDRESS_DETAIL_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","10");//상세주소 입력 형식이 맞지 않음
					return resultMap;
				}else{
					paramMap.put("mb_biz_address_detail",req.getParameter("mb_biz_address_detail"));
				}
			}
			
			if(StringUtils.isEmpty(req.getParameter("mb_biz_tel"))){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","11");//사업장 전화 입력이 안됨
				return resultMap;
			}else{
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_tel"),Constant.BIZTELNO_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","12");//사업장전화  입력 형식이 맞지 않음
					return resultMap;
				}else{
					paramMap.put("mb_biz_tel",req.getParameter("mb_biz_tel"));
				}
			}
			
			HashMap<String, Object> fileMap = FileUploadUtil.fileUpload(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),req, "biz");
			
			if(!StringUtils.isEmpty(fileMap.get("result"))) {
				if(fileMap.get("result").equals("fail")) {
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","13");//사업자 등록사본이 잘못되었습니다.
					return resultMap;
				}else {
					
					paramMap.put("mb_biz_img_path", fileMap.get("mb_biz_img_path"));
					//0:신청 대기, 1:신청인증 완료, 2:변경대기, 3:변경인증완료, 4:신청취소(관리자), 5:변경취로(관리자)
					paramMap.put("mb_biz_cert_state", '0');
					
					//관리자 변경이 아니기때문에 빈 값으로 셋팅
					paramMap.put("admin_mb_seq", null);
					paramMap.put("admin_mb_id", null);
					resultMap = myPageDao.updateBizMemberInfoProcess(paramMap);
					
					if((int)resultMap.get("return_query") == 1){
						resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
						return resultMap;
					}else{
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data","14");//디비 오류
						return resultMap;
					}
				}
			}else {
				
				paramMap.put("mb_biz_img_path", member.get("MB_BIZ_IMG_PATH"));
				paramMap.put("mb_biz_cert_state", '0');
				
				//관리자 변경이 아니기때문에 빈 값으로 셋팅
				paramMap.put("admin_mb_seq", null);
				paramMap.put("admin_mb_id", null);
				resultMap = myPageDao.updateBizMemberInfoProcess(paramMap);
				
				if((int)resultMap.get("return_query") == 1){
					resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
					return resultMap;
				}else{
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","14");//디비 오류
					return resultMap;
				}
			}
		}else{
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","15");//세션정보 없음
			return resultMap;
		}
	}
	
	/**
	 * 회원탈퇴
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> memberLeave(HttpServletRequest req) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		
		
		HttpSession session =  req.getSession();
		
		HashMap<String,Object> member = (HashMap<String,Object>)session.getAttribute("rb_member");
		
		if(!StringUtils.isEmpty(member)) {
			if(!Constant.getRegexMatchResultOfString(member.get("MB_ID"),Constant.ID_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","1");		//아이디 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_id", member.get("MB_ID"));
				paramMap.put("mb_seq",  member.get("MB_SEQ"));
				int result = memberAuthDao.checkMemberId(paramMap);
				if(result == 0) {
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","2");		//없는 아이디
					return resultMap;
				}else{
					if(StringUtils.isEmpty(req.getParameter("mb_password"))){
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data","3");		//비밀번호 값이 없음
						return resultMap;
					}else{
						
						String memberPassword = req.getParameter("mb_password");
						
						//원본 비밀번호
						String decRsaMemberPassword = RSASecureUtil.decryptRsa(req, memberPassword);
						
						
						if(!Constant.getRegexMatchResultOfString(decRsaMemberPassword,Constant.PW_REGULAR_EXPRESSTION)){
							resultMap.put("result", Constant.AJAX_RESULT_FAIL);
							resultMap.put("data","4");		//비밀번호 유효성 검사 실패
							return resultMap;
						}else{
							HashMap<String,Object> map = memberAuthDao.getMemberPassword(paramMap);
							
							//현재 입력 받은 비밀번호를 이전에 사용되었던 salt 를 이용해서 암호화한다.
							String comparePassword =  SHA512SecureUtil.incryptSha512(decRsaMemberPassword, (String)map.get("MB_SESSION_ID"));
							//패스워드 일치(로그인 성공)
							if(comparePassword.equals((String)map.get("MB_PASSWORD"))) {
								
								if(!StringUtils.isEmpty(req.getParameter("mb_leave_reason"))) {
									paramMap.put("mb_leave_reason", req.getParameter("mb_leave_reason"));
								}
								int result2 = myPageDao.memberLeave(paramMap);
								
								
								//탈퇴성공
								if(result2 == 1) {
									resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
									if(!StringUtils.isEmpty(member)){
										member.put("LO_TYPE", "2");
									}
									session.setAttribute("rb_member", member);
									//세션을 파기 한다.
									session.invalidate();
									return resultMap;
								}else {
									resultMap.put("result", Constant.AJAX_RESULT_FAIL);
									resultMap.put("data","5");		//회원정보 업데이트 실패
									return resultMap;
								}
							//패스워드가 다름
							}else{
								resultMap.put("result", Constant.AJAX_RESULT_FAIL);
								resultMap.put("data","6");		//패스워드가 일치하지 않음.
								return resultMap;
							}
						}
					}
				}
				
			}
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","7");		//세션정보 없음
			return resultMap;
		}
		
		
	}
	
	/**
	 * 환경설 정보를 가져온다.
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getMemberSetting(HttpServletRequest req) throws Exception {
		HashMap<String,Object> memberMap = StringTool.getSessionMap(req);
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		HashMap<String,Object> resultMap = myPageDao.getMemberSetting(paramMap);
		return resultMap;
	}
	
	/**
	 * 회원의 환경설정 정보를 업데이트 한다
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> updateMemberSetting(HttpServletRequest req) throws Exception {
		
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		//소비자 회원
		if(member.get("MB_TYPE").equals("1")) {
			
			paramMap.put("use_payment_email", !StringUtils.isEmpty(req.getParameter("use_payment_email")) ? req.getParameter("use_payment_email") : '0');
			paramMap.put("use_payment_mms", !StringUtils.isEmpty(req.getParameter("use_payment_mms")) ? req.getParameter("use_payment_mms") : '0');
			paramMap.put("use_delivery_start_email", !StringUtils.isEmpty(req.getParameter("use_delivery_start_email")) ? req.getParameter("use_delivery_start_email") : '0');
			paramMap.put("use_delivery_start_mms", !StringUtils.isEmpty(req.getParameter("use_delivery_start_mms")) ? req.getParameter("use_delivery_start_mms") : '0');
			paramMap.put("use_seller_cancel_email", !StringUtils.isEmpty(req.getParameter("use_seller_cancel_email")) ? req.getParameter("use_seller_cancel_email") : '0');
			paramMap.put("use_seller_cancel_mms", !StringUtils.isEmpty(req.getParameter("use_seller_cancel_mms")) ? req.getParameter("use_seller_cancel_mms") : '0');
			paramMap.put("use_self_cancel_email", !StringUtils.isEmpty(req.getParameter("use_self_cancel_email")) ? req.getParameter("use_self_cancel_email") : '0');
			paramMap.put("use_self_cancel_mms", !StringUtils.isEmpty(req.getParameter("use_self_cancel_mms")) ? req.getParameter("use_self_cancel_mms") : '0');
			paramMap.put("use_return_approve_email", !StringUtils.isEmpty(req.getParameter("use_return_approve_email")) ? req.getParameter("use_return_approve_email") : '0');
			paramMap.put("use_return_approve_mms", !StringUtils.isEmpty(req.getParameter("use_return_approve_mms")) ? req.getParameter("use_return_approve_mms") : '0');
			paramMap.put("use_exchange_approve_email", !StringUtils.isEmpty(req.getParameter("use_exchange_approve_email")) ? req.getParameter("use_exchange_approve_email") : '0');
			paramMap.put("use_exchange_approve_mms", !StringUtils.isEmpty(req.getParameter("use_exchange_approve_mms")) ? req.getParameter("use_exchange_approve_mms") : '0');
			paramMap.put("use_return_success_email", !StringUtils.isEmpty(req.getParameter("use_return_success_email")) ? req.getParameter("use_return_success_email") : '0');
			paramMap.put("use_return_success_mms", !StringUtils.isEmpty(req.getParameter("use_return_success_mms")) ? req.getParameter("use_return_success_mms") : '0');
			paramMap.put("use_exchange_success_email", !StringUtils.isEmpty(req.getParameter("use_exchange_success_email")) ? req.getParameter("use_exchange_success_email") : '0');
			paramMap.put("use_exchange_success_mms", !StringUtils.isEmpty(req.getParameter("use_exchange_success_mms")) ? req.getParameter("use_exchange_success_mms") : '0');
			
			
		//판매자 회원
		}else {
			paramMap.put("use_tel", !StringUtils.isEmpty(req.getParameter("use_tel")) ? req.getParameter("use_tel") : '0');
			paramMap.put("use_hp", !StringUtils.isEmpty(req.getParameter("use_hp")) ? req.getParameter("use_hp") : '0');
			paramMap.put("use_biz_tel", !StringUtils.isEmpty(req.getParameter("use_biz_tel")) ? req.getParameter("use_biz_tel") : '0');
		
			if(!StringUtils.isEmpty(req.getParameter("default_delivery_company"))) {
				paramMap.put("default_delivery_company", req.getParameter("default_delivery_company"));
			}
			paramMap.put("use_deposit_success_email", !StringUtils.isEmpty(req.getParameter("use_deposit_success_email")) ? req.getParameter("use_deposit_success_email") : '0');
			paramMap.put("use_deposit_success_mms", !StringUtils.isEmpty(req.getParameter("use_deposit_success_mms")) ? req.getParameter("use_deposit_success_mms") : '0');
			paramMap.put("use_buyer_cancel_email", !StringUtils.isEmpty(req.getParameter("use_buyer_cancel_email")) ? req.getParameter("use_buyer_cancel_email") : '0');
			paramMap.put("use_exchange_success_mms", !StringUtils.isEmpty(req.getParameter("use_exchange_success_mms")) ? req.getParameter("use_exchange_success_mms") : '0');
			paramMap.put("use_buyer_cancel_mms", !StringUtils.isEmpty(req.getParameter("use_buyer_cancel_mms")) ? req.getParameter("use_buyer_cancel_mms") : '0');
			paramMap.put("use_return_request_email", !StringUtils.isEmpty(req.getParameter("use_return_request_email")) ? req.getParameter("use_return_request_email") : '0');
			paramMap.put("use_return_request_mms", !StringUtils.isEmpty(req.getParameter("use_return_request_mms")) ? req.getParameter("use_return_request_mms") : '0');
			paramMap.put("use_exchange_request_email", !StringUtils.isEmpty(req.getParameter("use_exchange_request_email")) ? req.getParameter("use_exchange_request_email") : '0');
			paramMap.put("use_exchange_request_mms", !StringUtils.isEmpty(req.getParameter("use_exchange_request_mms")) ? req.getParameter("use_exchange_request_mms") : '0');
			
		}
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		int result = myPageDao.updateMemberSetting(paramMap);
		if(result == 1) {
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 로그인 설정 관련 리스트 가져오기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getMemberLoginSettingListByType(HttpServletRequest req) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		//기본값 셋팅
		String menuType = !StringUtils.isEmpty(req.getParameter("menuType")) ? req.getParameter("menuType") : "1";
		
		resultMap.put("menuType", menuType);
		
		//현재 나의 계정으로 접속중인 리스트
		if(menuType.equals("1")) {
			
			paramMap.put("mb_seq", member.get("MB_SEQ"));
			paramMap.put("mb_real_login_state", '1');
			paramMap.put("lo_type", '1');
			
			int total = myPageDao.getLoginSessionListCount(paramMap);
			String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
			String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
			QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
			paramMap.put("page", (int) paging.getLimit().get("start"));
			paramMap.put("pageSize", (int) paging.getLimit().get("end"));
			resultMap.put("loginSessionList", (ArrayList<HashMap<String,Object>>)myPageDao.getLoginSessionList(paramMap));
			
			HttpSession MySession = req.getSession();
			resultMap.put("mySessionId", MySession.getId());
			resultMap.put("paging", paging.getScript("loginSettingForm"));
			resultMap.put("page", page);
			resultMap.put("pageSize", pageSize);
			resultMap.put("total", total);
			
		}else if(menuType.equals("2")) {
			paramMap.put("mb_seq", member.get("MB_SEQ"));
			int total =  myPageDao.getLoginLogListCount(paramMap);
			String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
			String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
			QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
			paramMap.put("page", (int) paging.getLimit().get("start"));
			paramMap.put("pageSize", (int) paging.getLimit().get("end"));
			resultMap.put("loginLogList", (ArrayList<HashMap<String,Object>>)myPageDao.getLoginLogList(paramMap));
			
			resultMap.put("paging", paging.getScript("loginSettingForm"));
			resultMap.put("page", page);
			resultMap.put("pageSize", pageSize);
			resultMap.put("total", total);
			
		}else if(menuType.equals("3")) {
			paramMap.put("mb_seq", member.get("MB_SEQ"));
			int total =  myPageDao.getBlockIpListCount(paramMap);
			String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
			String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
			QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
			paramMap.put("page", (int) paging.getLimit().get("start"));
			paramMap.put("pageSize", (int) paging.getLimit().get("end"));
			resultMap.put("blockIpList", (ArrayList<HashMap<String,Object>>)myPageDao.getBlockIpList(paramMap));
			
			resultMap.put("paging", paging.getScript("loginSettingForm"));
			resultMap.put("page", page);
			resultMap.put("pageSize", pageSize);
			resultMap.put("total", total);
			resultMap.put("nowIp", StringTool.getClientIp(req));
		}else if(menuType.equals("4")) {
			
		}else {
			throw new Exception();
		}
			
		return resultMap;
	}
	
	/**
	 * 세션 스토어 정보를 삭제한다.
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> deleteMemberSession(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		if(!StringUtils.isEmpty(req.getParameter("mb_session_id"))) {
			paramMap.put("mb_seq", member.get("MB_SEQ"));
			paramMap.put("mb_session_id", req.getParameter("mb_session_id"));
			int result = myPageDao.deleteMemberSession(paramMap);
			
			if(result == 1) {
				resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			}else {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			}
			
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 디비 세션 스토어에서 현재 브라우저로 접속한 계정에대한 스토어 개수를 가져온다.
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public int getMemberSessionStoreCount(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member =  StringTool.getSessionMap(req);
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		paramMap.put("mb_session_id", req.getSession().getId());
		return myPageDao.getMemberSessionStoreCount(paramMap);
	}
	
	/**
	 * 아이피 차단하기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> insertMemberBlockIp(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		paramMap.put("mb_seq", StringTool.getSessionMap(req).get("MB_SEQ"));
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_ip"),Constant.IP_REASON_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//전달받은 아이피 입력이 올바르지 않음.
		}else{
			paramMap.put("mb_ip", req.getParameter("mb_ip"));
			
			ArrayList<HashMap<String,Object>> blockIpList = myPageDao.getBlockIpList(paramMap);
			
			if(StringUtils.isEmpty(blockIpList)) {
				
				int result = myPageDao.insertBlockIpList(paramMap);
				if(result > 0) {
					resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
				}else {
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data", "2");//인서트 오류
				}
			}else {
				boolean exists = false;
				endpoint :for(HashMap<String,Object> map : blockIpList) {
					if(map.get("MB_IP").equals(req.getParameter("mb_ip"))) {
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data", "3");//이미 차단된 아이피
						exists = true;
						break endpoint;
					}
				}
				
				if(!exists) {
					int result = myPageDao.insertBlockIpList(paramMap);
					
					if(result > 0) {
						resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
					}else {
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data", "2");//인서트 오류
					}
				}
			}
		}
		return resultMap;
	}
	
	/**
	 * 아이피 차단내역 삭제하기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> deleteMemberBlockIp(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		if(StringUtils.isEmpty(req.getParameter("mbi_seq"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//전달받은 아이피 입력이 올바르지 않음.
		}else {
			
			paramMap.put("mbi_seq", req.getParameter("mbi_seq"));
			int result = myPageDao.deleteMemberBlockIp(paramMap);
			
			if(result == 1) {
				resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			}else{
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "2");//전달받은 아이피 입력이 올바르지 않음.
			}
		}
		
		return resultMap;
	}
	
	/**
	 * 1:1 문의 유형 리스트 가져오기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getSupportTypeList() throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("inquiryTypeList", myPageDao.getInquiryTypeList());
		return resultMap;
	}
	
	/**
	 * 1:1문의 등록
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> insertInquiry(HttpServletRequest req) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		if(StringUtils.isEmpty(req.getParameter("ri_subject"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//제목 없음
			return resultMap;
		}
		
		if(StringUtils.isEmpty(req.getParameter("ri_content"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "2");//내용 없음
			return resultMap;
		}
		
		if(StringUtils.isEmpty(req.getParameter("rit_seq"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "3");//문의 타입 잘못됨.
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("rit_seq"),Constant.SUPPORT_TYPE_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","4");		//문의 타입 잘못됨.
				return resultMap;
			}
		}
		
			
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		paramMap.put("rit_seq", req.getParameter("rit_seq"));
		paramMap.put("ri_subject", req.getParameter("ri_subject"));
		paramMap.put("ri_content", req.getParameter("ri_content"));
		paramMap.put("ri_recv_email", member.get("MB_EMAIL"));
		
		
		
		HashMap<String, Object> fileMap = FileUploadUtil.fileUpload(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),req, "inquiry");
		
		//파일경로를 저장
		if(!StringUtils.isEmpty(fileMap)) {
			for(String key : fileMap.keySet()){
				paramMap.put(key, fileMap.get(key));
	        }
		}
		
		int result = myPageDao.insertInquiry(paramMap);
		
		if(result > 0) {
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","5");		//인서트실패
		}
		
		
		return resultMap;
	}
	
	/**
	 * 1:1문의 리스트 가져오기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getInquiryList(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		//삭제되지 않은 건만 0 : 미삭제 , 1 : 삭제
		paramMap.put("ri_delete", '0');
		//0 : 미답변, 1 : 답변
		//paramMap.put("su_is_answer", '0')
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
	        resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("search_word"))) {
			paramMap.put("search_word", req.getParameter("search_word"));
			paramMap.put("search_type", req.getParameter("search_type"));
			resultMap.put("search_word", req.getParameter("search_word"));
			resultMap.put("search_type", req.getParameter("search_type"));
		}
		
		int total = myPageDao.getInquiryListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("inquiryList", (ArrayList<HashMap<String,Object>>)myPageDao.getInquiryList(paramMap));
		
		resultMap.put("paging", paging.getScript("inquiryListForm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		resultMap.put("quick", !StringUtils.isEmpty(req.getParameter("quick")) ? req.getParameter("quick") : "");
		return resultMap;
	}
	
	/**
	 * 1:1 문의 가져오기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getInquiry(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		if(StringUtils.isEmpty(req.getParameter("ri_seq"))) {
			throw new Exception();
		}else {
			paramMap.put("ri_seq", req.getParameter("ri_seq"));
			
			HashMap<String,Object> inquiry = myPageDao.getInquiry(paramMap);
			
			if(!StringUtils.isEmpty(inquiry.get("RI_CONTENT"))) {
				inquiry.put("RI_CONTENT", StringTool.getLineCharacterReplace((String)inquiry.get("RI_CONTENT")));
			}
			
			if(!StringUtils.isEmpty(inquiry.get("RI_ANSWER"))) {
				inquiry.put("RI_ANSWER", StringTool.getLineCharacterReplace((String)inquiry.get("RI_ANSWER")));
			}
			
			resultMap.put("inquiry", inquiry);
			return resultMap;
		}
	}
	
	/**
	 * 이머니 충전(무통장 입금신청, 카드결제 성공후시 호출)
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> insertCashCharge(HttpServletRequest req) throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		
		if(!StringUtils.isEmpty(req.getParameter("cc_pay_name"))) {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("cc_pay_name"),Constant.NAME_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","1");		//무통장입금자 입력 오류
				return resultMap;
			}else {
				paramMap.put("cc_pay_name", req.getParameter("cc_pay_name"));
			}
		}
		
		if(!StringUtils.isEmpty(req.getParameter("cc_pay_no"))){
			paramMap.put("cc_pay_no", req.getParameter("cc_pay_no"));
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("cc_amount"),Constant.EMONEY_CHARGE_AMOUNT_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","2");		//충전금액 입력 오류
			return resultMap;
		}else {
			paramMap.put("cc_amount", req.getParameter("cc_amount"));
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("cc_pay_type"),Constant.ONE_NUMBER_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","3");		//충전타입 입력 오류
			return resultMap;
		}else {
			paramMap.put("cc_pay_type", req.getParameter("cc_pay_type"));
			
			if(req.getParameter("cc_pay_type").equals("1")) {
				//무통장입금은 입금대기 고정
				paramMap.put("cc_state", 1);
			}else {
				paramMap.put("cc_state", req.getParameter("cc_pay_type"));
				if(!StringUtils.isEmpty(req.getParameter("cc_pay_bank"))) {
					paramMap.put("cc_pay_bank",req.getParameter("cc_pay_bank"));
				}
			}
		}
		
		if(!StringUtils.isEmpty(req.getParameter("cc_bigo"))) {
			paramMap.put("cc_bigo", req.getParameter("cc_bigo"));
		}
		
		int result = myPageDao.insertCashCharge(paramMap); 
		
		if(result > 0) {
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","4");		//인서트 실패
			
		}
		return resultMap;
	}
	
	/**
	 * 이머니 충전내역 
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getEmoneyChargeList(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
	        resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		
		int total = myPageDao.getEmoneyChargeListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("emoneyChargeList", (ArrayList<HashMap<String,Object>>)myPageDao.getEmoneyChargeList(paramMap));
		resultMap.put("paging", paging.getScript("emoneyChargeListForm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		resultMap.put("quick", !StringUtils.isEmpty(req.getParameter("quick")) ? req.getParameter("quick") : "");
		return resultMap;
	}
	
	/**
	 * 현금성이머니 출금 요청
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> insertCashOut(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("co_amount"),Constant.EMONEY_CHARGE_AMOUNT_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","1");		//출금 금액 입력 오류
			return resultMap;
		}else {
			paramMap.put("co_amount", req.getParameter("co_amount"));
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("co_bank"),Constant.BANK_NAME_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","2");		//출금은행명 입력 오류
			return resultMap;
		}else {
			paramMap.put("co_bank", req.getParameter("co_bank"));
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("co_account"),Constant.BANK_NO_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","3");		//출금계좌번호 입력 오류
			return resultMap;
		}else {
			paramMap.put("co_account", req.getParameter("co_account"));
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("co_account_name"),Constant.BANK_OWNER_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","4");		//출금계좌 예금주 입력 오류
			return resultMap;
		}else {
			paramMap.put("co_account_name", req.getParameter("co_account_name"));
		}
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		paramMap.put("co_state", '1');
		paramMap.put("co_pay_type",'1');
		
		
		int result = myPageDao.insertCashOut(paramMap);
		
		if(result > 0) {

			paramMap.put("cash_amount", req.getParameter("co_amount"));
			paramMap.put("cl_type", 3);
			paramMap.put("order_seq", null);
			HashMap<String,Object> map =  itemDao.insertCashLogProcedure(paramMap);
			
			if((int)map.get("return_query") != 1) {
				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//강제롤백구문
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("message", resultMap.get("return_result_text"));
			}else{
				resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			}
			
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","5");		//데이터 베이스 오류
		}
		
		// TODO Auto-generated method stub
		return resultMap;
	}
	
	/**
	 * 이머니 출금 내역 리스트
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getEmoneyCashOutList(HttpServletRequest req) throws Exception {
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
	        resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		
		int total = myPageDao.getEmoneyCashOutListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("emoneyCashOutList", (ArrayList<HashMap<String,Object>>)myPageDao.getEmoneyCashOutList(paramMap));
		resultMap.put("paging", paging.getScript("emoneyCashOutListForm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		resultMap.put("quick", !StringUtils.isEmpty(req.getParameter("quick")) ? req.getParameter("quick") : "");
		return resultMap;
	}
	
	/**
	 * 현금성 이머니 출금 취소하기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> updateCashOutCancel(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		if(StringUtils.isEmpty(req.getParameter("co_seq"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");// 시퀀스 오류 잘못된 요청
			return resultMap;
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("co_seq"),Constant.NUMBER_EXPRESSION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","2");		//시퀀스 오류 잘못된 요청
			return resultMap;
		}else {
			paramMap.put("co_seq", req.getParameter("co_seq"));
			
			HashMap<String,Object> cashOut = myPageDao.getCashOutInfo(paramMap); 
			//출금 대기 일 경우만 
			if(cashOut.get("CO_STATE").equals("1")) {
				
				paramMap.put("cash_amount", cashOut.get("CO_AMOUNT"));
				paramMap.put("cl_type", 4);
				paramMap.put("order_seq", null);
				HashMap<String,Object> map =  itemDao.insertCashLogProcedure(paramMap);
				
				if((int)map.get("return_query") != 1) {
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//강제롤백구문
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","3");//데이터 오류
					resultMap.put("message", resultMap.get("return_result_text"));
				}else{
					
					HashMap<String,Object> paramMap2 = new HashMap<String,Object>();
					//변경하고자하는 데이터만 셋팅
					paramMap2.put("co_seq", req.getParameter("co_seq"));
					paramMap2.put("co_state", '3');
					int result = myPageDao.updateCashOutInfo(paramMap2);
							
					if(result > 0) {
						resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
					}else {
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data","4");//이미 출금신청된 내역임.	
					}
					
					
				}
				return resultMap;
			}else {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","5");//이미 출금신청된 내역임.	
				return resultMap;
			}
		}
	}
	
	/**
	 * 이머니 사용내역
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getEmoneyUseList(HttpServletRequest req) throws Exception {
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
	        resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("quick"))) {
			paramMap.put("quick", req.getParameter("quick"));
			resultMap.put("quick", req.getParameter("quick"));
		}
		
		int total = myPageDao.getEmoneyUseListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("emoneyUseList", (ArrayList<HashMap<String,Object>>)myPageDao.getEmoneyUseList(paramMap));
		resultMap.put("paging", paging.getScript("emoneyUseListForm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	/**
	 * 쪽지 리스트
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getLetterList(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("rl_receiver_seq", member.get("MB_SEQ"));
		//삭제되지 않은 건만 0 : 미삭제 , 1 : 삭제
		paramMap.put("rl_state", '1');
		//0 : 미답변, 1 : 답변
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
	        resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("search_word"))) {
			paramMap.put("search_word", req.getParameter("search_word"));
			paramMap.put("search_type", req.getParameter("search_type"));
			resultMap.put("search_word", req.getParameter("search_word"));
			resultMap.put("search_type", req.getParameter("search_type"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("rl_view_state"))) {
			
			if(!req.getParameter("rl_view_state").equals("0")) {
				paramMap.put("rl_view_state", req.getParameter("rl_view_state"));
			}
			resultMap.put("rl_view_state", req.getParameter("rl_view_state"));
		}else {
			resultMap.put("rl_view_state", "0");
		}
		
		int total = myPageDao.getLetterListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("letterList", (ArrayList<HashMap<String,Object>>)myPageDao.getLetterList(paramMap));
		
		resultMap.put("paging", paging.getScript("letterListForm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		resultMap.put("quick", !StringUtils.isEmpty(req.getParameter("quick")) ? req.getParameter("quick") : "");
		return resultMap;
	}
	
	/**
	 * 쪽지 보기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getLetter(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		
		if(StringUtils.isEmpty(req.getParameter("rl_seq"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//시퀀스 오류 잘못된 요청
			return resultMap;
		}else {
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("rl_seq"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","2");		//시퀀스 오류 잘못된 요청
				return resultMap;
			}else {
				paramMap.put("rl_seq", req.getParameter("rl_seq"));
				
				HashMap<String,Object> letter = myPageDao.getLetter(paramMap);
				
				if(!StringUtils.isEmpty(letter)) {
					
					//미확인일 경우만....
					if(letter.get("RL_VIEW_STATE").equals("1")) {
						//쪽지 읽음처리
						myPageDao.updateLetter(paramMap);
					}
					
					resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
					resultMap.put("letter",myPageDao.getLetter(paramMap));
					
					if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
						resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
					}
					
					if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
						resultMap.put("sch_edate", req.getParameter("sch_edate"));
					}
					
					if(!StringUtils.isEmpty(req.getParameter("search_word"))) {
						resultMap.put("search_word", req.getParameter("search_word"));
						resultMap.put("search_type", req.getParameter("search_type"));
					}
					
					if(!StringUtils.isEmpty(req.getParameter("rl_view_state"))) {
						resultMap.put("rl_view_state", req.getParameter("rl_view_state"));
					}else {
						resultMap.put("rl_view_state", "0");
					}
					
					resultMap.put("page", !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1");
					resultMap.put("pageSize", !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10");
					resultMap.put("quick", !StringUtils.isEmpty(req.getParameter("quick")) ? req.getParameter("quick") : "");
					
				}else{
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","3");		//시퀀스 오류 잘못된 요청
				}
				return resultMap;
			}
		}
	}
	/**
	 * 쪽지 상태 변경하기 (type=delete 삭제처리 , type=update 읽음처리)
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> updateLetterList(HttpServletRequest req) throws Exception {
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		int letterListSize = 0;
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		
		if(!StringUtils.isEmpty(req.getParameter("type"))) {
			paramMap.put("type", req.getParameter("type"));
		}else{
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//타입값이 잘못됨.
			return resultMap;
		}
		
		if(!StringUtils.isEmpty(req.getParameter("letterSeqList"))){
			Gson gson = new Gson();
			ArrayList<Long> letterSeqList = gson.fromJson(req.getParameter("letterSeqList"), new TypeToken<ArrayList<Long>>(){}.getType());
			letterListSize = letterSeqList.size();
			paramMap.put("letterSeqList", letterSeqList);
		}else{
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "2");//선택된 쪽지 없음
			return resultMap;
		}
		
		int result = myPageDao.updateLetterList(paramMap);
		//모두 변경 완료.
		if(result == letterListSize) {
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			return resultMap;
		}else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//강제롤백구문
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "3");//부분 실패
			return resultMap;
		}
	}
	
	/**
	 * 무통장 이머니 입금 대기 취소
	 */
	@Override
	public HashMap<String, Object> cashChargeCancelAjax(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		
		if(!StringUtils.isEmpty(req.getParameter("cc_seq"))) {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("cc_seq"), Constant.NUMBER_EXPRESSION)) {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "2");//잘못된 파라미터
				return resultMap;
			}else {
				paramMap.put("cc_seq", req.getParameter("cc_seq"));
				HashMap<String,Object> cashChargeInfo = myPageDao.getCashChargeInfo(paramMap);
				//입금대기 상태일때만
				if(cashChargeInfo.get("CC_STATE").equals("1")) {
					paramMap.put("cc_state", '3');
					int result = myPageDao.updateCashCharge(paramMap);
					if(result == 1) {
						resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
						return resultMap;
					}else {
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data", "3");//업데이트 실패
						return resultMap;
					}
				}else {
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data", "4");//입금 대기 중이 아님.
					return resultMap;
				}
			}
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//시퀀스 없음
			return resultMap;
		}
	}
}
