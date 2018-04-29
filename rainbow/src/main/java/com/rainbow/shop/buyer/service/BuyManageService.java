package com.rainbow.shop.buyer.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface BuyManageService {

	public HashMap<String, Object> getBuyLeftMenuDataCount(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> buyList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> buyView(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getOrderInfoOption(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemQaList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> getShopItemQaContentList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> itemBackExchangeWrite(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertItemBackExchange(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> cancelOrder(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> cancelBackExchange(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> interestItemList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> deleteInterestItem(HttpServletRequest req) throws Exception;
}
