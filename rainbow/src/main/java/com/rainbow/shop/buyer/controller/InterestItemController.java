package com.rainbow.shop.buyer.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rainbow.shop.buyer.service.InterestItemServiceImpl;

@Controller
public class InterestItemController {
	
	@Autowired
	InterestItemServiceImpl interestItemService;
	
	/**
	 * 관심상품 리스트 가져오기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/getMyInterestItemListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> getMyInterestItemList(HttpServletRequest req) throws Exception{
		HashMap<String,Object> resultMap = (HashMap<String,Object>)interestItemService.getMyInterestItemList(req);
		return resultMap;
	}
	
	/**
	 * 관심상품 삭제하기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/deleteMyInterestItemAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> deleteMyInterestItem(HttpServletRequest req) throws Exception{
		HashMap<String,Object> resultMap = (HashMap<String,Object>)interestItemService.deleteMyInterestItem(req);
		return resultMap;
	}
	
	/**
	 * 관심상품 추가하기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/insertMyInterestItemAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> insertMyInterestItem(HttpServletRequest req) throws Exception{
		HashMap<String,Object> resultMap = (HashMap<String,Object>)interestItemService.insertMyInterestItem(req);
		return resultMap;
	}
	
}
