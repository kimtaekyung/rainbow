package com.rainbow.shop.buyer.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public interface BuyManageDao {

	public HashMap<String, Object> getShopOrderInfoStateGroupCount(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopOrderOne(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getBuyList(HashMap<String, Object> paramMap) throws SQLException;
	public int getBuyListCount(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopOrderInfoOne(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getOrderInfoOption(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getItemQaList(HashMap<String, Object> paramMap) throws SQLException;
	public int getItemQaListCount(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getShopItemQaContentList(HashMap<String, Object> paramMap) throws SQLException;
	public int insertItemBackExchange(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopOrderInfoState(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopItemBackExchange(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopOrderInfoLogOne(HashMap<String, Object> paramMap) throws SQLException;
	public int insertShopOrderInfoLog(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopItemSellCnt(HashMap<String, Object> paramMap) throws SQLException;
	public int deleteMyItem(HashMap<String, Object> paramMap) throws SQLException;
}
