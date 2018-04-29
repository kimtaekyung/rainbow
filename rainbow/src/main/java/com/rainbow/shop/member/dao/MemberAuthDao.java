package com.rainbow.shop.member.dao;

import java.sql.SQLException;
import java.util.HashMap;

import com.rainbow.shop.member.vo.MemberVo;

public interface MemberAuthDao {	
	public String memberSignUp(MemberVo memberVo) throws SQLException;
	public int checkMemberId(HashMap<String, Object> paramMap) throws SQLException;
	public int checkMemberLoginId(HashMap<String, Object> paramMap) throws SQLException;
	public int checkMemberNickName(HashMap<String, Object> paramMap) throws SQLException;
	public int checkMemberHp(HashMap<String, Object> paramMap) throws SQLException;
	public int checkMemberEmail(HashMap<String, Object> paramMap) throws SQLException;
	public int memberJoin(HashMap<String, Object> paramMap)throws SQLException;
	public int searchRecommId(HashMap<String, Object> paramMap)throws SQLException;
	public HashMap<String,Object> getMemberPassword(HashMap<String, Object> resultMap)throws SQLException;
	public HashMap<String, Object> loginSuccess(HashMap<String, Object> resultMap)throws SQLException;
	public HashMap<String, Object> getMemberInfo(HashMap<String, Object> paramMap)throws SQLException;
	public HashMap<String, Object> memberLogoutProcess(HashMap<String, Object> paramMap);
	public int insertMemberSetting(int mbSeq)throws SQLException;
}

