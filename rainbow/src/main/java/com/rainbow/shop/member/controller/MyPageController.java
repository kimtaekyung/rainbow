package com.rainbow.shop.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rainbow.shop.member.service.MemberAuthServiceImpl;
import com.rainbow.shop.member.service.MyPageServiceImpl;

@Controller
public class MyPageController {
	
	@Autowired
	MyPageServiceImpl myPageService;
	
	@Autowired
	MemberAuthServiceImpl memberAuthService;
	
	
	/**
	 * 마이페이지 메인
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/myPageMain.do", method = RequestMethod.GET)
	public String myPageMain(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/myPageMain.do");
		return "/myPage/myPageMain";
	}
	
	//이머니 관련
	/**
	 * 이머니 사용 내역 리스트로 이동
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/emoneyUseList.do", method = RequestMethod.GET)
	public String emomeyUseList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getEmoneyUseList(req));
		model.addAttribute("selectMenuUrl", "/myPage/emoneyUseList.do");
		return "/myPage/emoneyUseList";
	}
	
	/**
	 * 이머니 충전 페이지로 이동
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/emoneyCharge.do", method = RequestMethod.GET)
	public String emoneyCharge(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/emoneyCharge.do");
		return "/myPage/emoneyCharge";
	}
	
	/**
	 * 이머니 충전하기 ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/insertCashChargeAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> insertCashChargeAjax(HttpServletRequest req) throws Exception{
		return myPageService.insertCashCharge(req);
	}
	
	/**
	 * 이머니 충전 내역 리스트로 이동
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/emoneyChargeList.do", method = RequestMethod.GET)
	public String emoneyChargeList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getEmoneyChargeList(req));
		model.addAttribute("selectMenuUrl", "/myPage/emoneyChargeList.do");
		return "/myPage/emoneyChargeList";
	}
	
	/**
	 * 이머니 충전 취소(무통장 입금대기 일경우)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/cashChargeCancelAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> cashChargeCancelAjax(HttpServletRequest req) throws Exception{
		return myPageService.cashChargeCancelAjax(req);
	}
	
	/**
	 * 이머니 출금 페이지로 이동
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/emoneyCashOut.do", method = RequestMethod.GET)
	public String emoneyCashOut(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/emoneyCashOut.do");
		return "/myPage/emoneyCashOut";
	}
	
	/**
	 * 현금성 이머니 출금하기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/insertCashOutAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> insertCashOut(HttpServletRequest req) throws Exception{
		return myPageService.insertCashOut(req);
	}
	
	
	/**
	 * 이머니 출금 내역 리스트로 이동
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/emoneyCashOutList.do", method = RequestMethod.GET)
	public String emoneyCashOutList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getEmoneyCashOutList(req));
		model.addAttribute("selectMenuUrl", "/myPage/emoneyCashOutList.do");
		return "/myPage/emoneyCashOutList";
	}
	
	
	
	/**
	 * 현금성 이머니 출금하기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/updateCashOutCancelAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> updateCashOutCancel(HttpServletRequest req) throws Exception{
		return myPageService.updateCashOutCancel(req);
	}
	
	
	
	//-- 이머니 관련 끝
	
	//세금 계산서 관려
	/**
	 * 세금 계산서 발급 내역으로 이동
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/taxCalculationList.do", method = RequestMethod.GET)
	public String taxCalculationList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/taxCalculationList.do");
		return "/myPage/taxCalculationList";
	}
	//-- 세금 계산서 관련끝
	
	
	//회원정보 관련
	/**
	 * 회원 정보 변경 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/memberInfoUpdate.do", method = RequestMethod.GET)
	public String memberInfoUpdate(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/memberInfoUpdate.do");
		return "/myPage/memberInfoUpdate";
	}
	
	
	/**
	 * 회원 정보 변경
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/updateMemberInfoAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> updateMemberInfo(HttpServletRequest req) throws Exception{
		HashMap<String,Object> resultMap = myPageService.updateMemberInfo(req);
		return resultMap;
	}
	
	/**
	 * 회원 사업자 등록 정보 변경
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/updateMemberBizInfoAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> updateMemberBizInfoAjax(HttpServletRequest req) throws Exception{
		HashMap<String,Object> resultMap = myPageService.updateMemberBizInfo(req);
		return resultMap;
	}
	
	
	/**
	 * 회원 환경 설정 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/memberSetting.do", method = RequestMethod.GET)
	public String memberSetting(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("memberSetting", myPageService.getMemberSetting(req));
		model.addAttribute("selectMenuUrl", "/myPage/memberSetting.do");
		return "/myPage/memberSetting";
	}
	
	/**
	 * 회원 환경설정 업데이트
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/updateMemberSettingAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> updateMemberSetting(HttpServletRequest req) throws Exception{
		return myPageService.updateMemberSetting(req);
	}
	
	
	/**
	 * 회원 로그인 설정 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/memberLoginSetting.do", method = RequestMethod.GET)
	public String memberLoginSetting(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getMemberLoginSettingListByType(req));
		model.addAttribute("selectMenuUrl", "/myPage/memberLoginSetting.do");
		return "/myPage/memberLoginSetting";
	}
	
	/**
	 * 해당 세션의 세션 스토어정보를 삭제한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/deleteMemberSessionAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> deleteMemberSession(HttpServletRequest req) throws Exception{
		return myPageService.deleteMemberSession(req);
	}
	
	/**
	 * 아이피 차단하기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/insertMemberBlockIpAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> insertMemberBlockIp(HttpServletRequest req) throws Exception{
		return myPageService.insertMemberBlockIp(req);
	}
	
	/**
	 * 아이피 차단내역 삭제하기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/deleteMemberBlockIpAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> deleteMemberBlockIp(HttpServletRequest req) throws Exception{
		return myPageService.deleteMemberBlockIp(req);
	}
	
	
	/**
	 * 회원 등급 조회 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/memberGradeSearch.do", method = RequestMethod.GET)
	public String memberGradeSearch(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/memberGradeSearch.do");
		return "/myPage/memberGradeSearch";
	}
	
	/**
	 * 회원 인증 관리
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/memberCertificationManagement.do", method = RequestMethod.GET)
	public String memberCertificationManagement(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/memberCertificationManagement.do");
		return "/myPage/memberCertificationManagement";
	}
		
	/**
	 * 회원 인증 관리
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/licenseeManagement.do", method = RequestMethod.GET)
	public String licenseeManagement(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/licenseeManagement.do");
		return "/myPage/licenseeManagement";
	}	
		
		
		
	/**
	 * 회원 탈퇴 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/memberLeave.do", method = RequestMethod.GET)
	public String memberLeave(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/memberLeave.do");
		return "/myPage/memberLeave";
	}
	
	/**
	 * 회원 탈퇴 ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/memberLeaveReqeustAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> memberLeaveReqeust(HttpServletRequest req) throws Exception{
		System.out.println("memberLeaveReqeust..");
		return myPageService.memberLeave(req);
	}
	
	//-- 회원 정보 관련 끝
	
	//포인트 관련
	/**
	 * 포인트 사용 내역 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/pointUseList.do", method = RequestMethod.GET)
	public String pointUseList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("selectMenuUrl", "/myPage/pointUseList.do");
		return "/myPage/pointUseList";
	}
	//-- 포인트 관련 끝
	
	/**
	 * 1:1문의 리스트로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/inquiryList.do", method = RequestMethod.GET)
	public String inquiryList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getInquiryList(req));
		model.addAttribute("selectMenuUrl", "/myPage/inquiryList.do");
		return "/myPage/inquiryList";
	}
	
	/**
	 * 1:1문의 하기 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/inquiryWrite.do", method = RequestMethod.GET)
	public String inquiryWrite(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getSupportTypeList());
		model.addAttribute("selectMenuUrl", "/myPage/inquiryWrite.do");
		return "/myPage/inquiryWrite";
	}
	
	/**
	 * 1:1 문의 등록 하기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/insertInquiryAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> insertInquiry(HttpServletRequest req) throws Exception{
		return myPageService.insertInquiry(req);
	}
	
	/**
	 * 1:1문의 하기 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/inquiryView.do", method = RequestMethod.GET)
	public String inquiryView(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getInquiry(req));
		model.addAttribute("selectMenuUrl", "/myPage/inquiryWrite.do");
		return "/myPage/inquiryView";
	}
	
	/**
	 * 쪽지 리스트 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/letterList.do", method = RequestMethod.GET)
	public String letterList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getLetterList(req));
		model.addAttribute("selectMenuUrl", "/myPage/letterList.do");
		return "/myPage/letterList";
	}
	
	/**
	 * 쪽지 뷰 페이지 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/letterView.do", method = RequestMethod.GET)
	public String letterView(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap", myPageService.getLetter(req));
		model.addAttribute("selectMenuUrl", "/myPage/letterView.do");
		return "/myPage/letterView";
	}
	
	
	/**
	 * 쪽지 리스트 상태 변경하기(삭제, 모두 확인)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/myPage/updateLetterListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> updateLetterList(HttpServletRequest req) throws Exception{
		return myPageService.updateLetterList(req);
	}
}
