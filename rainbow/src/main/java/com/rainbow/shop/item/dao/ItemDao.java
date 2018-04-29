package com.rainbow.shop.item.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface ItemDao {

	public String getShopCategoryName(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getItemList(HashMap<String, Object> paramMap) throws SQLException;
	public int getItemListCount(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getItem(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getItemOptionList(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getItemOptionGroupList(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getItemCategoryList(HashMap<String, Object> paramMap) throws SQLException;
	public int insertItem(HashMap<String, Object> paramMap) throws SQLException;
	public int insertItemOption(List<HashMap<String, Object>> list) throws SQLException;
	public int deleteItemOption(HashMap<String, Object> paramMap) throws SQLException;
	public int insertItemQa(HashMap<String, Object> paramMap) throws SQLException;
	public int insertItemQaContent(HashMap<String, Object> paramMap) throws SQLException;
	public int updateItem(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getItemShopQaList(HashMap<String, Object> paramMap) throws SQLException;
	public int getItemShopQaListCount(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getShopItemQa(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getShopItemQaContentList(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopItemQaIsAnswer(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getMyItemList(HashMap<String, Object> paramMap) throws SQLException;
	public int getMyItemListCount(HashMap<String, Object> paramMap) throws SQLException;
	public int insertMyItem(HashMap<String, Object> paramMap) throws SQLException;
	public int deleteMyItem(HashMap<String, Object> paramMap) throws SQLException;
	public int insertShopCart(List<HashMap<String, Object>> list) throws SQLException;
	public ArrayList<HashMap<String, Object>> getShopCartList(HashMap<String, Object> paramMap) throws SQLException;
	public ArrayList<HashMap<String, Object>> getShopCartGroupList(HashMap<String, Object> paramMap) throws SQLException;
	public int deleteShopCart(HashMap<String, Object> paramMap) throws SQLException;
	public int deleteShopCartAll(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopCartQty(HashMap<String, Object> paramMap) throws SQLException;
	public int insertShopOrder(HashMap<String, Object> paramMap) throws SQLException;
	public int insertShopOrderInfo(List<HashMap<String, Object>> list) throws SQLException;
	public int updateShopOrderInfoState(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopCartState(HashMap<String, Object> paramMap) throws SQLException;
	public int updateMemberCashByOrder(HashMap<String, Object> paramMap) throws SQLException;
	public int insertCashLog(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> insertCashLogProcedure(HashMap<String, Object> paramMap) throws SQLException;
	public HashMap<String, Object> getOrderItemTotalPrice(HashMap<String, Object> paramMap) throws SQLException;
	public int insertShopOrderInfoLog(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopItemViewCnt(HashMap<String, Object> paramMap) throws SQLException;
	public int updateShopItemSellCnt(HashMap<String, Object> paramMap) throws SQLException;
}
