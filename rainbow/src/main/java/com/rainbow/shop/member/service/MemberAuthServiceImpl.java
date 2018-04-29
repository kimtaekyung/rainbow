package com.rainbow.shop.member.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.rainbow.constant.Constant;
import com.rainbow.shop.member.dao.MemberAuthDao;
import com.rainbow.shop.member.dao.MyPageDao;
import com.rainbow.util.AES256SecureUtil;
import com.rainbow.util.RSASecureUtil;
import com.rainbow.util.SHA512SecureUtil;
import com.rainbow.util.StringTool;

@Service
public class MemberAuthServiceImpl implements MemberAuthService{

	@Autowired
	MemberAuthDao memberAuthDao;
	
	@Autowired
	MyPageDao myPageDao;

	/**
	 * 아이디 중복 체크 및 유효성 검사
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> checkMemberId(HttpServletRequest req) throws Exception{
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		if(Constant.getRegexMatchResultOfString(req.getParameter("mb_id"),Constant.ID_REGULAR_EXPRESSTION)){
			HashMap<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("mb_id", req.getParameter("mb_id"));
			int result = memberAuthDao.checkMemberId(paramMap);
			if(result == 0){
				resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			}else{
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			}
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
		}

		return resultMap;
	}
	
	/**
	 * 닉네임 중복체크 및 유효성 검사
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> checkMemberNickName(HttpServletRequest req)throws Exception{
		
		System.out.println("checkMemberNickName();;;");
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		if(Constant.getRegexMatchResultOfString(req.getParameter("mb_nickname"),Constant.NICKNAME_REGULAR_EXPRESSTION)){
			HashMap<String,Object> paramMap = new HashMap<String,Object>();
			paramMap.put("mb_nickname", req.getParameter("mb_nickname"));
			int result = (int)memberAuthDao.checkMemberNickName(paramMap);
			if(result == 0){
				resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			}else{
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			}
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
		}

		return resultMap;
	}
	
	/**
	 * rsa 공개키 받기
	 */
	@Override
	public HashMap<String, Object> getRsaPublicKey(HttpServletRequest req) throws Exception{
		RSASecureUtil.destroyRsa(req);
		HashMap<String,Object> resultMap = RSASecureUtil.initRsa(req);
		return resultMap;
	}
	
	/**
	 * 회원가입
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> memberJoin(HttpServletRequest req) throws Exception {
		String mb_type;
		
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		if(StringUtils.isEmpty(req.getParameter("mb_type"))){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","1");		//회원 타입 값이 없음
			return resultMap;
		}else{
			mb_type = req.getParameter("mb_type");
			paramMap.put("mb_type", req.getParameter("mb_type"));
		}
		
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_id"),Constant.ID_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","2");		//아이디 유효성 검사 실패
			return resultMap;
		}else {
			paramMap.put("mb_id", req.getParameter("mb_id"));
			int result = memberAuthDao.checkMemberId(paramMap);
			//이미존재하는 회원
			if(result != 0){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","3");	//이미 존재하는 아이디
				return resultMap;
			}else{
				paramMap.put("mb_id", req.getParameter("mb_id"));
				paramMap.put("mb_state", "1");
			}
		}
		
		String memberPassword = req.getParameter("mb_password");
		String decRsaMemberPassword = RSASecureUtil.decryptRsa(req, memberPassword);
		
		if(!Constant.getRegexMatchResultOfString(decRsaMemberPassword,Constant.PW_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","4");		//비밀번호 유효성 검사 실패
			return resultMap;
		}else{
			String incSha512MemberPassword = SHA512SecureUtil.incryptSha512(decRsaMemberPassword, req.getSession().getId());
			paramMap.put("mb_password", incSha512MemberPassword);
			paramMap.put("mb_session_id", req.getSession().getId());
		}
		
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_name"),Constant.NAME_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","5");		//이름 유효성 검사 실패
			return resultMap;
		}else{
			paramMap.put("mb_name", req.getParameter("mb_name"));
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_nickname"),Constant.NICKNAME_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","6");		//닉네임 유효성 검사 실패
			return resultMap;
		}else{
			
			paramMap.put("mb_nickname", req.getParameter("mb_nickname"));
			int result = memberAuthDao.checkMemberNickName(paramMap);
			if(result != 0){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","7");		//이미 존재 하는 닉네임
				return resultMap;
			}
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_birthday"),Constant.BIRTH_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","8");		//생년월일 유효성 검사 실패
			return resultMap;
		}else{
			paramMap.put("mb_birthday", req.getParameter("mb_birthday"));
		}
		
		
		if(StringUtils.isEmpty(req.getParameter("mb_birthday_type"))){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","9");		//생년월일 입력값이 없음 
			return resultMap;
		}else{
			paramMap.put("mb_birthday_type", req.getParameter("mb_birthday_type"));
		}
		
		
		if(!StringUtils.isEmpty(req.getParameter("mb_tel"))) {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_tel"),Constant.TEL_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","10");		//전화번호 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_tel", req.getParameter("mb_tel"));
			}
		}
		
		
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_hp"),Constant.HP_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","11");		//휴대폰 번호 유효성 검사 실패
			return resultMap;
		}else{
			AES256SecureUtil aes256 = new AES256SecureUtil();
			paramMap.put("mb_hp", aes256.aesEncode(req.getParameter("mb_hp")));
			
			int result = memberAuthDao.checkMemberHp(paramMap);
			if(result != 0){
				
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","26");		//이미 존재 하는 휴대폰 번호
				return resultMap;
			}
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_email"),Constant.EMAIL_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","12");		//이메일 번호 유효성 검사 실패
			return resultMap;
		}else{
			paramMap.put("mb_email", req.getParameter("mb_email"));
			int result = memberAuthDao.checkMemberEmail(paramMap);
			if(result != 0){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","27");		//이미 존재 하는 이메일
				return resultMap;
			}
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
		
		if(mb_type.equals("2")){

			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_name"),Constant.BIZNAME_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","14");		//상호 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_biz_name",req.getParameter("mb_biz_name"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_ceo_name"),Constant.BIZCEONAME_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","15");		//대표자명 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_biz_ceo_name",req.getParameter("mb_biz_ceo_name"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_no"),Constant.BIZNO_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","16");		//사업자 등록번호 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_biz_no",req.getParameter("mb_biz_no"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_tel"),Constant.BIZTELNO_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","17");		//사업장 전화 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_biz_tel",req.getParameter("mb_biz_tel"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_zip_code"),Constant.ZIPCODE_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","18");		//사업장 우편번호 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_biz_zip_code",req.getParameter("mb_biz_zip_code"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_address"),Constant.ADDRESS_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","19");		//사업장 기본주소 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_biz_address", req.getParameter("mb_biz_address"));
			}
			
			if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_address_detail"),Constant.ADDRESS_DETAIL_REGULAR_EXPRESSTION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data","20");		//사업장 상세주소 유효성 검사 실패
				return resultMap;
			}else{
				paramMap.put("mb_biz_address_detail", req.getParameter("mb_biz_address_detail"));
			}
			
		}
		
		//소비자 일 경우에만 체크
		if(mb_type.equals("1")){
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_type_1"))){
				paramMap.put("mb_biz_type_1", req.getParameter("mb_biz_type_1"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_type_2"))){
				paramMap.put("mb_biz_type_2", req.getParameter("mb_biz_type_2"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_type_3"))){
				paramMap.put("mb_biz_type_3", req.getParameter("mb_biz_type_3"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_type_4"))){
				paramMap.put("mb_biz_type_4", req.getParameter("mb_biz_type_4"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_type_5"))){
				paramMap.put("mb_biz_type_5", req.getParameter("mb_biz_type_5"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_info_open"))){
				paramMap.put("mb_info_open", req.getParameter("mb_info_open"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_code"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_code"),Constant.SELLCODE_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","22");		//P코드, 대리점코드 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_code", req.getParameter("mb_biz_code"));
				}
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_info_recv_mail"))){
				paramMap.put("mb_info_recv_mail", req.getParameter("mb_info_recv_mail"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_info_recv_post"))){
				paramMap.put("mb_info_recv_post", req.getParameter("mb_info_recv_post"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_info_recv_sms"))){
				paramMap.put("mb_info_recv_sms", req.getParameter("mb_info_recv_sms"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_info_recv_hp"))){
				paramMap.put("mb_info_recv_hp", req.getParameter("mb_info_recv_hp"));
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_recomm_id"))){
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_recomm_id"),Constant.ID_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","23");		//추천인아이디 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_recomm_id", req.getParameter("mb_recomm_id"));
					int result = memberAuthDao.searchRecommId(paramMap);
					
					if(req.getParameter("mb_id").equals(req.getParameter("mb_recomm_id")) || result == 0) {
						resultMap.put("result", Constant.AJAX_RESULT_FAIL);
						resultMap.put("data","23");		//추천인아이디 유효성 검사 실패
						return resultMap;
					}
				}
			}
			
			//소비자는 입력값이 있을때만 체크
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_name"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_name"),Constant.BIZNAME_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","14");		//상호 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_name",req.getParameter("mb_biz_name"));
				}
			}
			
			//소비자는 입력값이 있을때만 체크
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_ceo_name"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_ceo_name"),Constant.BIZCEONAME_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","15");		//대표자명 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_ceo_name",req.getParameter("mb_biz_ceo_name"));
				}
			}
			
			//소비자는 입력값이 있을때만 체크
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_no"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_no"),Constant.BIZNO_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","16");		//사업자 등록번호 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_no",req.getParameter("mb_biz_no"));
				}
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_tel"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_tel"),Constant.BIZTELNO_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","17");		//사업장 전화 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_tel",req.getParameter("mb_biz_tel"));
				}
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_zip_code"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_zip_code"),Constant.ZIPCODE_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","18");		//사업장 우편번호 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_zip_code",req.getParameter("mb_biz_zip_code"));
				}
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_address"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_address"),Constant.ADDRESS_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","19");		//사업장 기본주소 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_address", req.getParameter("mb_biz_address"));
				}
			}
			
			if(!StringUtils.isEmpty(req.getParameter("mb_biz_address_detail"))) {
				if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_biz_address_detail"),Constant.ADDRESS_DETAIL_REGULAR_EXPRESSTION)){
					resultMap.put("result", Constant.AJAX_RESULT_FAIL);
					resultMap.put("data","20");		//사업장 상세주소 유효성 검사 실패
					return resultMap;
				}else{
					paramMap.put("mb_biz_address_detail", req.getParameter("mb_biz_address_detail"));
				}
			}
			
		}
		
		paramMap.put("mb_join_ip", StringTool.getClientIp(req));
		
		HttpSession session = req.getSession();
		
		if(!StringUtils.isEmpty(session)){
			String mb_join_url = (String)session.getAttribute("jonctionUrl"); 
			if(!StringUtils.isEmpty(mb_join_url)){
				paramMap.put("mb_join_url", mb_join_url);
			}
		}
		//세션에서 rsa 개인키 파기
		RSASecureUtil.destroyRsa(req);
		
		int mb_seq = memberAuthDao.memberJoin(paramMap);
		if(mb_seq > 0){
			
			
			int rms_seq = memberAuthDao.insertMemberSetting((int)paramMap.get("mb_seq"));
			if(rms_seq > 0) {
				resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			}else {
				resultMap.put("data","25");
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			}
			
		}else {
			resultMap.put("data","24");
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
		}
		return resultMap;
	}
	
	/**
	 * 로그인
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> memberLogin(HttpServletRequest req) throws Exception{
		
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("mb_id"),Constant.ID_REGULAR_EXPRESSTION)){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data","1");		//아이디 유효성 검사 실패
			return resultMap;
		}else{
			paramMap.put("mb_id", req.getParameter("mb_id"));
			int result = memberAuthDao.checkMemberLoginId(paramMap);
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
						
						if(map.get("MB_ALLOW_IP_USE_YN").equals("Y")){
							if(!StringTool.getClientIp(req).equals(map.get("mb_allow_ip"))){
								resultMap.put("result", Constant.AJAX_RESULT_FAIL);
								resultMap.put("data","7");	//로그인 회원 허용 아이피가 아님.
								return resultMap;
							}
						}
						//현재 입력 받은 비밀번호를 이전에 사용되었던 salt 를 이용해서 암호화한다.
						String comparePassword =  SHA512SecureUtil.incryptSha512(decRsaMemberPassword, (String)map.get("MB_SESSION_ID"));
						//패스워드 일치(로그인 성공)
						if(comparePassword.equals((String)map.get("MB_PASSWORD"))) {
							
							paramMap.put("mb_seq", map.get("MB_SEQ"));
							ArrayList<HashMap<String,Object>> blockIpList = myPageDao.getBlockIpList(paramMap);
							if(!StringUtils.isEmpty(blockIpList)){
								String myIp = StringTool.getClientIp(req);
								for(HashMap<String,Object> blockIpMap : blockIpList) {
									if(myIp.trim().equals(((String)blockIpMap.get("MB_IP")).trim())) {
										resultMap.put("result", Constant.AJAX_RESULT_FAIL);
										resultMap.put("data","7");		//블록아이피
										return resultMap;
									}
								}
							}
							
							HttpSession session = req.getSession();
							
							String mb_session_id = session.getId();
							//현재 세션 아이디로 다시 암호화 한다.
							decRsaMemberPassword = SHA512SecureUtil.incryptSha512(decRsaMemberPassword, mb_session_id);
							
							//로그인 성공 프로시저를 호출 하기위한 데이터를 준비한다.
							paramMap.put("mb_password", decRsaMemberPassword);
							paramMap.put("mb_session_id", mb_session_id);
							paramMap.put("lo_type", '1');
							char lo_device_type = StringTool.detectDevice(req);
							if(lo_device_type != '4') {
								paramMap.put("lo_device_type",lo_device_type);
								paramMap.put("lo_device_env",req.getHeader("User-Agent"));
							}else{
								throw new Exception();
							}
							
							
							if(!StringUtils.isEmpty(session )){
								if(!StringUtils.isEmpty(session.getAttribute("jonctionUrl"))){
									paramMap.put("lo_url", session.getAttribute("jonctionUrl"));
								}else {
									paramMap.put("lo_url", "");
								}
							}
							
							paramMap.put("lo_ip", StringTool.getClientIp(req));
							
							//회원 로그인 로그를 쌓고 상태및 세션아이디를 업데이트 한다.
							resultMap = memberAuthDao.loginSuccess(paramMap);
							//로그및 회원 상태 업데이트 성공
							
							if((int)resultMap.get("return_query") == 1){
								
								
								
								paramMap.put("mb_seq", resultMap.get("return_mb_seq"));
								HashMap<String,Object> memberMap = memberAuthDao.getMemberInfo(paramMap);
								
								String mb_hp = (String)memberMap.get("MB_HP");
								//휴대폰번호는 통신법상 암호화로 저장하지만 세션에는 원레 값으로 셋팅한다.
								AES256SecureUtil aes256 = new AES256SecureUtil();
								memberMap.put("MB_HP", aes256.aesDecode(mb_hp));
								session.setAttribute("rb_member", memberMap);
								resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
								return resultMap;
							}else{
								resultMap.put("result", Constant.AJAX_RESULT_FAIL);
								resultMap.put("data","5");//디비 오류
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
	}
	
	/**
	 * 로그 아웃
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public void memberLogout(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HttpSession session = req.getSession();
		HashMap<String,Object> member = (HashMap<String,Object>)session.getAttribute("rb_member");
		if(!StringUtils.isEmpty(member)){
			
			if(!StringUtils.isEmpty(req.getAttribute("compulsion"))) {
				if((boolean)req.getAttribute("compulsion")) {
					member.put("LO_TYPE", "4");
				}else {
					member.put("LO_TYPE", "2");
				}
			}else {
				member.put("LO_TYPE", "2");
			}
		}
		member.put("LO_DEVICE_ENV", req.getHeader("User-Agent"));
		//세션에 전달할 파라미터를 다시 셋팅한다.
		session.setAttribute("rb_member", member);
		//System.out.println("session.invalidate");
		//세션을 파기 한다. 세션리스너에서 memberLogoutProcess() 호출한다.
		session.invalidate();
		// TODO Auto-generated method stub
	}
	
	/**
	 * 로그 아웃 리스너 에서 호출 하는 함수.
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public void memberLogoutProcess(HashMap<String,Object> member) throws Exception{
		System.out.println("memberLogoutProcess()");
		
		//세션타임아웃은 LO_TYPE 값이 없기때문에 넣어준다.
		if(StringUtils.isEmpty(member.get("LO_TYPE"))){
			member.put("LO_TYPE", "3");
		}
		
		//로그아웃 프로시저 용 파라미터 셋팅.
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		paramMap.put("lo_type", member.get("LO_TYPE"));
		paramMap.put("lo_device_type", member.get("MB_LOGIN_DEVICE_TYPE"));
		paramMap.put("lo_ip", member.get("MB_LOGIN_IP"));
		paramMap.put("lo_url", member.get("MB_JOIN_URL"));
		paramMap.put("mb_session_id", member.get("mb_logout_session_id"));
		paramMap.put("lo_device_env", member.get("LO_DEVICE_ENV"));
		/*for( String key : paramMap.keySet() ){
            System.out.println( String.format("키 : %s, 값 : %s", key, paramMap.get(key)) );
        }
		System.out.println("memberLogoutProcess()...");*/
		HashMap<String,Object> resultMap = memberAuthDao.memberLogoutProcess(paramMap); 
		StringTool.HashMapConsoleViewer(resultMap);
		
	}
	
	/**
	 * 세션정보를 새로 갱신한다.(휴대폰번호는 복호화 해서 세션에 저장)
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public void initMemberSessionInfo(HttpServletRequest req) throws Exception {
		System.out.println("initMemberSessionInfo...");
		HttpSession session = req.getSession();
		//세션이 값이 존재 할경우.
		if(!StringUtils.isEmpty(session.getAttribute("rb_member"))) {
			@SuppressWarnings("unchecked")
			HashMap<String,Object> paramMap = (HashMap<String,Object>) session.getAttribute("rb_member");
			paramMap.put("mb_seq", paramMap.get("MB_SEQ"));
			HashMap<String,Object> memberMap = memberAuthDao.getMemberInfo(paramMap);
			AES256SecureUtil aes256 = new AES256SecureUtil();
			memberMap.put("MB_HP", aes256.aesDecode((String)memberMap.get("MB_HP")));
			session.setAttribute("rb_member", memberMap);
		}
	}
}


