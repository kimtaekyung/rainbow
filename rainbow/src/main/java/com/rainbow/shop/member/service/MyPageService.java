package com.rainbow.shop.member.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface MyPageService {
	public HashMap<String, Object> updateMemberInfo(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateMemberBizInfo(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> memberLeave(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getMemberSetting(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateMemberSetting(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getMemberLoginSettingListByType(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> deleteMemberSession(HttpServletRequest req) throws Exception;
	public int getMemberSessionStoreCount(HttpServletRequest req)throws Exception;
	public HashMap<String,Object> insertMemberBlockIp(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> deleteMemberBlockIp(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getSupportTypeList() throws Exception;
	public HashMap<String,Object> insertInquiry(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getInquiryList(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getInquiry(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> insertCashCharge(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getEmoneyChargeList(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> insertCashOut(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getEmoneyCashOutList(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> updateCashOutCancel(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getEmoneyUseList(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getLetterList(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> getLetter(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> updateLetterList(HttpServletRequest req) throws Exception;
	public HashMap<String,Object> cashChargeCancelAjax(HttpServletRequest req) throws Exception;
	
}
