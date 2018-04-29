package com.rainbow.shop.seller.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rainbow.shop.seller.service.SellerServiceImpl;

@Controller
public class SellerController {
	
	@Autowired
	private SellerServiceImpl sellerService;
	
	/**
	 * 판매관리 레프트 메뉴 데이터 카운트 조회 Ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/getSellLeftMenuDataCountAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getSellLeftMenuDataCountAjax(HttpServletRequest req) throws Exception{
		return sellerService.getSellLeftMenuDataCount(req);
	}

	/**
	 * 판매관리 메인
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/sellMain.do", method = RequestMethod.GET)
	public String sellMain(HttpServletRequest req) throws Exception{
		return "/seller/sellMain";
	}
	
	/**
	 * 상품대량등록 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/itemExcelRegist.do", method = RequestMethod.GET)
	public String itemExcelRegist(HttpServletRequest req) throws Exception{
		req.setAttribute("currUri", "/seller/itemExcelRegist.do");
		return "/seller/itemExcelRegist";
	}
	
	/**
	 * 상품대량(엑셀)등록 프로세스
	 * 파일을 읽어 내용을 화면으로 리턴
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/itemExcelReadAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> itemExcelReadAjax(HttpServletRequest req) throws Exception{
		return sellerService.itemExcelRead(req);
	}
	
	/**
	 * 엑셀로 읽어온 상품내용을 저장한다.
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/insertExcelItemListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertExcelItemListAjax(HttpServletRequest req) throws Exception{
		return sellerService.insertExcelItemList(req);
	}
	
	/**
	 * 판매등록상품 목록화면
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/sellRegistItemList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String sellRegistItemList(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", sellerService.sellRegistItemList(req));
		req.setAttribute("currUri", "/seller/sellRegistItemList.do");
		
		return "/seller/sellRegistItemList";
	}
	
	/**
	 * 판매자 상품 진열여부 수정
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/updateShopItemDisplayAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateShopItemDisplayAjax(HttpServletRequest req) throws Exception{
		return sellerService.updateShopItemDisplay(req);
	}
	
	/**
	 * 판매자 상품 상태변경
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/updateShopItemStatusAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateShopItemStatusAjax(HttpServletRequest req) throws Exception{
		return sellerService.updateShopItemStatus(req);
	}
	
	/**
	 * 판매관리 - 판매된 상품목록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/sellList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String sellList(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", sellerService.sellList(req));
		req.setAttribute("currUri", "/seller/sellList.do");
		
		return "/seller/sellList";
	}
	
	/**
	 * 판매관리 - 판매된 상품 주문상세내용
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/sellView.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String sellView(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", sellerService.sellView(req));
		req.setAttribute("currUri", "/seller/sellList.do");
		
		return "/seller/sellView";
	}
	
	/**
	 * 주문내역 한건에 대한 옵션 조회
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/getOrderInfoOptionAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getOrderInfoOptionAjax(HttpServletRequest req) throws Exception{
		return sellerService.getOrderInfoOption(req);
	}
	
	/**
	 * 판매관리 - 상품문의목록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/itemQaList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String itemQaList(HttpServletRequest req) throws Exception{
		req.setAttribute("currUri", "/seller/itemQaList.do");
		req.setAttribute("resultDataMap", sellerService.itemQaList(req));
		
		return "/seller/itemQaList";
	}
	
	/**
	 * 상품문의 질문(답변) 목록 조회
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/getShopItemQaContentListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getShopItemQaContentListAjax(HttpServletRequest req) throws Exception{
		return sellerService.getShopItemQaContentList(req);
	}
	
	/**
	 * 판매관리 - 반품/교환요청 답변등록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/updateShopItemBackExchangeAnswerAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateShopItemBackExchangeAnswerAjax(HttpServletRequest req) throws Exception{
		return sellerService.updateShopItemBackExchangeAnswer(req);
	}
	
	/**
	 * 판매관리 - 주문상태 변경
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/updateShopOrderStateAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateShopOrderStateAjax(HttpServletRequest req) throws Exception{
		return sellerService.updateShopOrderState(req);
	}
	
	/**
	 * 판매관리 - 상품문의목록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/calculateList.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String calculateList(HttpServletRequest req) throws Exception{
		
//		req.setAttribute("resultDataMap", sellerService.sellList(req));
		req.setAttribute("currUri", "/seller/calculateList.do");
		
		return "/seller/calculateList";
	}
	
	/**
	 * 판매관리 - 배송정보 저장
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/seller/updateDeliveryInfoAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateDeliveryInfoAjax(HttpServletRequest req) throws Exception{
		return sellerService.updateDeliveryInfo(req);
	}
	
}
