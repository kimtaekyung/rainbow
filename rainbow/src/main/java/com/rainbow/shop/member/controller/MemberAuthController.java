package com.rainbow.shop.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;

import com.rainbow.shop.member.service.MemberAuthServiceImpl;

@Controller
public class MemberAuthController {
	
	@Autowired
	MemberAuthServiceImpl memberAuthService;
	
	/**
	 * 회원 가입 동의 페이지 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/agreement.do", method = RequestMethod.GET)
	public String agreement(HttpServletRequest req, Model model) throws Exception{
		if(req.getSession().getAttribute("rb_member") != null) {
			return "/main/main";
		}else{
			/*String returnUrl = req.getHeader("referer").split("localhost:8080")[1];
			if(returnUrl.length() > 0)model.addAttribute("returnUrl", returnUrl);*/
			return "/auth/agreement";
		}
	}
	
	/**
	 * 회원 가입 입력 페이지 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/join.do", method = RequestMethod.GET)
	public String join(HttpServletRequest req, Model model) throws Exception{
		if(req.getSession().getAttribute("rb_member") != null) {
			return "/main/main";
		}else {
			//if(!StringUtils.isEmpty(req.getParameter("returnUrl")))model.addAttribute("returnUrl", req.getParameter("returnUrl"));
			return "/auth/join";
		}
	}
	
	/**
	 * 회원 아이디 중복체크
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/checkMemberIdAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> checkMemberIdAjax(HttpServletRequest req) throws Exception{
		HashMap<String,Object> resultMap = (HashMap<String,Object>)memberAuthService.checkMemberId(req);
		return resultMap;
	}
	
	/**
	 * 회원 닉네임 중복 체크
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/checkMemberNickNameAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> checkMemberNickNameAjax(HttpServletRequest req) throws Exception{
		HashMap<String,Object> resultMap = (HashMap<String,Object>)memberAuthService.checkMemberNickName(req);
		return resultMap;
	}
	
	/**
	 * rsa 공개키 가져오기 및 개인키 생성후 세션 저장
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/getRsaPublicKey.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> getRsaPublicKey(HttpServletRequest req) throws Exception{
		return memberAuthService.getRsaPublicKey(req);
	}
	
	
	/**
	 * 회원가입
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/memberJoinAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> memberJoinAjax(HttpServletRequest req) throws Exception{
		return memberAuthService.memberJoin(req);
	}
	
	/**
	 * 회원 로그인 페이지로 이동
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/login.do", method = RequestMethod.GET)
	public String memberLoginPage(HttpServletRequest req, Model model) throws Exception{
		if(!StringUtils.isEmpty(req.getQueryString())){
			if(req.getQueryString().indexOf("/auth/login.do") > 0 || req.getQueryString().indexOf("/auth/agreement.do") > 0) {
				model.addAttribute("returnUrl", "/main.do");
			}else {
				model.addAttribute("returnUrl", req.getQueryString());
			}
		}
		return "/auth/login";
	}
	
	/**
	 * 회원 로그인
	 * @param req
	 * @param memberVo
	 * @param bindingResult
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/memberLoginAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> memberLogin(HttpServletRequest req) throws Exception{
		return memberAuthService.memberLogin(req);
	}
	/**
	 * 주소 팝업 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestScope
	@RequestMapping(value = "/common/addrSearchPopup.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String addrSeachPopup(HttpServletRequest req) throws Exception{
		//String cate = req.getParameter("cate");
		//System.out.println(cate);
		//model.addAttribute("cate", cate);
		return "/common/addrSearchPopup";
	}
	
	/**
	 * 주소 팝업 테스트 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/common/addrSearchSamplePopup.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String jusoSamplePopup(HttpServletRequest req) throws Exception{
		return "/common/addrSearchSamplePopup";
	}
	
	/**
	 * 회원 로그아웃
	 * @param req
	 * @param memberVo
	 * @param bindingResult
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/logout.do", method = RequestMethod.GET)
	public String logout(HttpServletRequest req) throws Exception{
		memberAuthService.memberLogout(req);
		return "redirect:/main.do";
	}
	
	/**
	 * 계정 찾기 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/findAccountInfo.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String findAccountInfo(HttpServletRequest req) throws Exception{
		return "/auth/findAccountInfo";
	}
	
	/**
	 * 비밀번호 찾기 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auth/findPasswordInfo.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String findPasswordInfo(HttpServletRequest req) throws Exception{
		return "/auth/findPasswordInfo";
	}
	
	/**
	 * 계정 연동 비밀번호 설정 페이지
	 */
	@RequestMapping(value = "/auth/linkage.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String linkage(HttpServletRequest req) throws Exception{
		return "/auth/linkage";
	}
}
