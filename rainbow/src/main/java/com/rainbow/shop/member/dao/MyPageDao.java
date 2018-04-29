package com.rainbow.shop.member.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public interface MyPageDao {
	
	public int updateMemberInfo(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> updateBizMemberInfoProcess(HashMap<String, Object> resultMap)throws SQLException;
	public int memberLeave(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getMemberSetting(HashMap<String, Object> resultMap)throws SQLException;
	public int updateMemberSetting(HashMap<String, Object> paramMap)throws SQLException; 
	public int getLoginSessionListCount(HashMap<String, Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getLoginSessionList(HashMap<String, Object> paramMap)throws SQLException;
	public int deleteMemberSession(HashMap<String, Object> paramMap)throws SQLException;
	public int getMemberSessionStoreCount(HashMap<String, Object> paramMap)throws SQLException;
	public int getLoginLogListCount(HashMap<String, Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getLoginLogList(HashMap<String, Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getBlockIpList(HashMap<String, Object> paramMap)throws SQLException;
	public int insertBlockIpList(HashMap<String, Object> paramMap)throws SQLException;
	public int getBlockIpListCount(HashMap<String, Object> paramMap)throws SQLException;
	public int deleteMemberBlockIp(HashMap<String, Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getInquiryTypeList()throws SQLException;
	public int insertInquiry(HashMap<String,Object> paramMap)throws SQLException;
	public int getInquiryListCount(HashMap<String,Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getInquiryList(HashMap<String,Object> paramMap)throws SQLException;
	public HashMap<String,Object> getInquiry(HashMap<String,Object> paramMap)throws SQLException;
	public int insertCashCharge(HashMap<String,Object> paramMap)throws SQLException;
	public int getEmoneyChargeListCount(HashMap<String,Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getEmoneyChargeList(HashMap<String,Object> paramMap)throws SQLException;
	public int insertCashOut(HashMap<String,Object> paramMap)throws SQLException;
	public int getEmoneyCashOutListCount(HashMap<String,Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getEmoneyCashOutList(HashMap<String,Object> paramMap)throws SQLException;
	public HashMap<String,Object> getCashOutInfo(HashMap<String,Object> paramMap)throws SQLException;
	public int updateCashOutInfo(HashMap<String,Object> paramMap)throws SQLException;
	public int getEmoneyUseListCount(HashMap<String,Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getEmoneyUseList(HashMap<String,Object> paramMap)throws SQLException;
	public int getLetterListCount(HashMap<String,Object> paramMap)throws SQLException;
	public ArrayList<HashMap<String,Object>> getLetterList(HashMap<String,Object> paramMap)throws SQLException;
	public HashMap<String,Object> getLetter(HashMap<String,Object> paramMap)throws SQLException;
	public int updateLetterList(HashMap<String,Object> paramMap)throws SQLException;
	public int updateLetter(HashMap<String,Object> paramMap)throws SQLException;
	public int updateCashCharge(HashMap<String,Object> paramMap)throws SQLException;
	public HashMap<String,Object>getCashChargeInfo(HashMap<String,Object> paramMap)throws SQLException;
}
