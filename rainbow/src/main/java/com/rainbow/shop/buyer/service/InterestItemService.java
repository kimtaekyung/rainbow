package com.rainbow.shop.buyer.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface InterestItemService {
	public HashMap<String, Object> getMyInterestItemList(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> deleteMyInterestItem(HttpServletRequest req) throws Exception;
	public HashMap<String, Object> insertMyInterestItem(HttpServletRequest req) throws Exception;
	
}
