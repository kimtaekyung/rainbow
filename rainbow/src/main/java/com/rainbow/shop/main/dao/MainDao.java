package com.rainbow.shop.main.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public interface MainDao {
	public ArrayList<HashMap<String, Object>> getCategoryList() throws SQLException;
	public ArrayList<HashMap<String, Object>> getQuestionAndAnswerList(HashMap<String,Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getQuestionAndAnswerTypeList() throws SQLException;
	public ArrayList<HashMap<String, Object>> getSearchTextRankList() throws SQLException;
	public int insertSearchText(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getAdvertiseList(HashMap<String,Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getNewItemList(HashMap<String,Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getPopularItemList(HashMap<String,Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getSpecialPriceItemList(HashMap<String,Object> paramMap) throws SQLException;
}
