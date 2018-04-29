package com.rainbow.shop.buyer.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rainbow.shop.buyer.service.BuyManageServiceImpl;

@Controller
public class BuyManageController {
	
	@Autowired
	private BuyManageServiceImpl buyManageService;
	
	/**
	 * 구매관리 레프트 메뉴 데이터 카운트 조회 Ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/getBuyLeftMenuDataCountAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getSellLeftMenuDataCountAjax(HttpServletRequest req) throws Exception{
		return buyManageService.getBuyLeftMenuDataCount(req);
	}
	
	/**
	 * 구매관리 - 메인
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/buyMain.do", method = RequestMethod.GET)
	public String buyMain(HttpServletRequest req) throws Exception{
		
		return "/buyer/buyMain";
	}
	
	/**
	 * 구매관리 - 상품구매리스트 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/buyList.do", method = RequestMethod.GET)
	public String buyList(HttpServletRequest req) throws Exception{
		req.setAttribute("resultDataMap", buyManageService.buyList(req));
		req.setAttribute("currUri", "/buyer/buyList.do");
		return "/buyer/buyList";
	}
	
	/**
	 * 구매관리 - 상품주문 상세 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/buyView.do", method = RequestMethod.GET)
	public String buyView(HttpServletRequest req) throws Exception{
		req.setAttribute("resultDataMap", buyManageService.buyView(req));
		req.setAttribute("currUri", "/buyer/buyList.do");
		return "/buyer/buyView";
	}
	
	/**
	 * 주문내역 한건에 대한 옵션 조회
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/getOrderInfoOptionAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getOrderInfoOptionAjax(HttpServletRequest req) throws Exception{
		return buyManageService.getOrderInfoOption(req);
	}
	
	/**
	 * 구매관리 - 상품문의목록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/itemQaList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String itemQaList(HttpServletRequest req) throws Exception{
		req.setAttribute("resultDataMap", buyManageService.itemQaList(req));
		return "/buyer/itemQaList";
	}
	
	/**
	 * 구매관리- 상품문의 질문(답변) 목록 조회
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/getShopItemQaContentListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getShopItemQaContentListAjax(HttpServletRequest req) throws Exception{
		return buyManageService.getShopItemQaContentList(req);
	}
	
	/**
	 * 구매관리 - 상품 반품/교환요청 화면
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/itemBackExchangeWrite.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String itemBackExchangeWrite(HttpServletRequest req) throws Exception{
		req.setAttribute("resultDataMap", buyManageService.itemBackExchangeWrite(req));
		return "/buyer/itemBackExchangeWrite";
	}
	
	/**
	 * 구매관리- 상품교환/요청 문의 등록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/insertItemBackExchangeAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertItemBackExchangeAjax(HttpServletRequest req) throws Exception{
		return buyManageService.insertItemBackExchange(req);
	}
	
	/**
	 * 구매관리- 주문 취소처리 프로세스
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/cancelOrderAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> cancelOrderAjax(HttpServletRequest req) throws Exception{
		return buyManageService.cancelOrder(req);
	}
	
	/**
	 * 구매관리- 상품교환/요청 취소처리 프로세스
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/cancelBackExchangeAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> cancelBackExchangeAjax(HttpServletRequest req) throws Exception{
		return buyManageService.cancelBackExchange(req);
	}
	
	/**
	 * 구매관리 - 관심상품목록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/interestItemList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String interestItemList(HttpServletRequest req) throws Exception{
		req.setAttribute("resultDataMap", buyManageService.interestItemList(req));
		req.setAttribute("currUri", "/buyer/interestItemList.do");
		return "/buyer/interestItemList";
	}
	
	/**
	 * 구매관리 - 관심상품 삭제하기(한건삭제, 모두삭제)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/buyer/deleteInterestItemAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> deleteInterestItemAjax(HttpServletRequest req) throws Exception{
		return buyManageService.deleteInterestItem(req);
	}
}
