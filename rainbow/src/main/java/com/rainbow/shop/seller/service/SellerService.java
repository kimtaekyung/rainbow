package com.rainbow.shop.seller.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface SellerService {

	public HashMap<String, Object> getSellLeftMenuDataCount(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getShopItemStatusGroupCount(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getShopOrderInfoStateGroupCount(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemExcelRead(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> sellRegistItemList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateShopItemDisplay(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateShopItemStatus(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> sellList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> sellView(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getOrderInfoOption(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemQaList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getShopItemQaContentList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateShopItemBackExchangeAnswer(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateShopOrderState(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> updateDeliveryInfo(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertExcelItemList(HttpServletRequest req) throws Exception;
}
