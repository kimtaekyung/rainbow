package com.rainbow.shop.buyer.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public interface InterestItemDao {
	public ArrayList<HashMap<String,Object>> getMyInterestItemList(HashMap<String, Object> paramMap) throws SQLException;
	public int getMyInterestItemListCount(HashMap<String, Object> paramMap) throws SQLException;
	public int deleteMyInterestItem(HashMap<String, Object> paramMap) throws SQLException;
	public int insertMyInterestItem(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String,Object> getMyInterestItem(HashMap<String, Object> paramMap) throws SQLException;
}
