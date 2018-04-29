package com.rainbow.shop.item.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface ItemService {

	public HashMap<String, Object> getItemList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getItem(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemView(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemForm(HttpServletRequest req) throws Exception;
	public ArrayList<HashMap<String, Object>> getItemOptionList(HttpServletRequest req) throws Exception;
	public ArrayList<HashMap<String, Object>> getItemOptionGroupList(HttpServletRequest req) throws Exception;
	public ArrayList<HashMap<String, Object>> getItemCategoryList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertItem(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateItem(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertItemQa(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertItemQaContent(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getItemShopQaList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getShopItemQaContentList(HttpServletRequest req) throws Exception;
	public ArrayList<HashMap<String, Object>> getMyItemList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertMyItem(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getMyItem(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertShopCart(HttpServletRequest req) throws Exception;
	public ArrayList<HashMap<String, Object>> getShopCartList(HttpServletRequest req) throws Exception;
	public ArrayList<HashMap<String, Object>> getShopCartGroupList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemCartList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> deleteShopCart(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> deleteShopCartAll(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateShopCartQty(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemOptionLayer(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateShopCart(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> checkOrderItemStatus(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemOrderForm(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertShopOrder(HttpServletRequest req) throws Exception;
}
