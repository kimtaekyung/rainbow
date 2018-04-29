package com.rainbow.shop.seller.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public interface SellerDao {
	
	public HashMap<String, Object> getShopItemStatusGroupCount(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopOrderInfoStateGroupCount(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getSellRegistItemList(HashMap<String, Object> paramMap) throws SQLException;
	public int getSellRegistItemListCount(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopItemDisplay(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopItemStatus(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getSellItemList(HashMap<String, Object> paramMap) throws SQLException;
	public int getSellItemListCount(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopOrderInfoOne(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getOrderInfoOption(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getItemQaList(HashMap<String, Object> paramMap) throws SQLException;
	public int getItemQaListCount(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getShopItemQaContentList(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopItemBackExchange(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopItemBackExchangeAnswer(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopOrderState(HashMap<String, Object> paramMap) throws SQLException;
	public int insertShopOrderInfoLog(HashMap<String, Object> paramMap) throws SQLException;
	public int updateDeliveryInfo(HashMap<String, Object> paramMap) throws SQLException;
}
