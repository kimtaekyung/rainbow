package com.rainbow.shop.member.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import com.rainbow.shop.member.vo.MemberVo;

public interface MemberAuthService {
	public HashMap<String, Object> checkMemberId(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> checkMemberNickName(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getRsaPublicKey(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> memberJoin(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> memberLogin(HttpServletRequest req) throws Exception;
	public void memberLogout(HttpServletRequest req) throws Exception;
	public void memberLogoutProcess(HashMap<String,Object> paramMap) throws Exception;
	public void initMemberSessionInfo(HttpServletRequest req) throws Exception;
}
	