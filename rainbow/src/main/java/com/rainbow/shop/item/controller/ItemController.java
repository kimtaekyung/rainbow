package com.rainbow.shop.item.controller;

import java.util.HashMap;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rainbow.constant.Constant;
import com.rainbow.shop.item.service.ItemServiceImpl;

@Controller
public class ItemController {
	
	@Resource
    private ApplicationContext applicationContext;
	
	@Autowired
	private ItemServiceImpl itemService;
	
	/**
	 * 상품목록 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemList.do", method = RequestMethod.GET)
	public String itemList(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", itemService.itemList(req));
		
		return "/item/itemList";
	}
	
	/**
	 * 상품목록 검색 AJAX
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/getItemListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getItemListAjax(HttpServletRequest req) throws Exception{
		return itemService.getItemList(req);
	}
	
	/**
	 * 상품상세 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemView.do", method = RequestMethod.GET)
	public String itemView(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", itemService.itemView(req));
		
		return "/item/itemView";
	}
	
	/**
	 * 상품등록페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemForm.do", method = RequestMethod.GET)
	public String itemForm(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", itemService.itemForm(req));
		
		return "/item/itemForm";
	}
	
	/**
	 * 상품 등록 프로세스
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/insertItemAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertItemAjax(HttpServletRequest req) throws Exception{
		return itemService.insertItem(req);
	}
	
	/**
	 * 상품 수정 프로세스
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/updateItemAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateItemAjax(HttpServletRequest req) throws Exception{
		return itemService.updateItem(req);
	}
	
	/**
	 * 상품등록시 카테고리 팝업 페이지
	 * @param locale
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemCategoryPopup.do", method = RequestMethod.GET)
	public String itemCategoryPopup(Locale locale, Model model) throws Exception{
		return "/popup/itemCategoryPopup";
	}
	
	/**
	 * 상품 카테고리 목록 조회(Ajax)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemCategoryListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> itemCategoryListAjax(HttpServletRequest req) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("resultData", itemService.getItemCategoryList(req));
		
		return resultMap;
	}
	
	/**
	 * 상품문의 등록 프로세스
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/insertItemQaAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertItemQaAjax(HttpServletRequest req) throws Exception{
		return itemService.insertItemQa(req);
	}
	
	/**
	 * 상품문의 내용 등록 프로세스
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/insertItemQaContentAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertItemQaContentAjax(HttpServletRequest req) throws Exception{
		return itemService.insertItemQaContent(req);
	}
	
	/**
	 * 상품문의목록 조회Ajax(마스터)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/getItemShopQaListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getItemShopQaListAjax(HttpServletRequest req) throws Exception{
		return itemService.getItemShopQaList(req);
	}
	
	/**
	 * 상품문의 질문(답변)내역 조회Ajax Json
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/getShopItemQaContentListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getShopItemQaContentListAjax(HttpServletRequest req) throws Exception{
		return itemService.getShopItemQaContentList(req);
	}
	
	/**
	 * 상품문의 질문(답변)내역 조회Ajax Html
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/getShopItemQaContentListAjaxHtml.do", method = RequestMethod.POST)
	public String getShopItemQaContentListAjaxHtml(HttpServletRequest req) throws Exception{
		req.setAttribute("resultData", itemService.getShopItemQaContentList(req));
		
		return "/item/ajax/itemQaViewAjax";
	}
	
	/**
	 *  관심상품 등록/해제 프로세스
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/insertMyItemAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertMyItemAjax(HttpServletRequest req) throws Exception{
		return itemService.insertMyItem(req);
	}
	
	/**
	 *  관심상품 조회(한건)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/getMyItemAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getMyItemAjax(HttpServletRequest req) throws Exception{
		return itemService.getMyItem(req);
	}
	
	/**
	 * 상품옵션 조회Ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/getItemOptionListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getItemOptionListAjax(HttpServletRequest req) throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("resultData", itemService.getItemOptionList(req));
		
		return resultMap;
	}
	
	/**
	 *  상품 장바구니 등록 Ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/insertShopCartAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertShopCartAjax(HttpServletRequest req) throws Exception{
		return itemService.insertShopCart(req);
	}
	
	/**
	 * 장바구니 목록 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemCartList.do", method = RequestMethod.GET)
	public String itemCartList(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", itemService.itemCartList(req));
		
		return "/item/itemCartList";
	}
	
	/**
	 *  상품 장바구니 삭제 Ajax(그룹삭제 또는 옵션일부 삭제)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/deleteShopCartAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> deleteShopCartAjax(HttpServletRequest req) throws Exception{
		return itemService.deleteShopCart(req);
	}
	
	/**
	 *  상품 장바구니 선택삭제, 전체삭제 Ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/deleteShopCartAllAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> deleteShopCartAllAjax(HttpServletRequest req) throws Exception{
		return itemService.deleteShopCartAll(req);
	}
	
	/**
	 * 장바구니 주문수량 변경 Ajax
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/updateShopCartQtyAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateShopCartQtyAjax(HttpServletRequest req) throws Exception{
		return itemService.updateShopCartQty(req);
	}
	
	/**
	 * 옵션 레이에 팝업
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemOptionLayer.do", method = RequestMethod.POST)
	public String itemOptionLayer(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", itemService.itemOptionLayer(req));
		
		return "/item/itemOptionLayer";
	}
	
	/**
	 * 장바구니 목록 수정(하나의 상품그룹)
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/updateShopCartAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> updateShopCartAjax(HttpServletRequest req) throws Exception{
		return itemService.updateShopCart(req);
	}
	
	/**
	 * 주문 상품목록 상태값 확인
	 * 주문페이지 이전 실행
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/checkOrderItemStatusAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> checkOrderItemStatusAjax(HttpServletRequest req) throws Exception{
		return itemService.checkOrderItemStatus(req);
	}
	
	/**
	 * 상품 주문 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemOrderForm.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String itemOrderForm(HttpServletRequest req) throws Exception{
		
		req.setAttribute("resultDataMap", itemService.itemOrderForm(req));
		
		return "/item/itemOrderForm";
	}
	
	/**
	 * 상품 주문완료 페이지
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/itemOrderComplete.do", method = {RequestMethod.GET, RequestMethod.POST})
	public String itemOrderComplete(HttpServletRequest req) throws Exception{
		
//		req.setAttribute("resultDataMap", itemService.itemOrderForm(req));
		
		return "/item/itemOrderComplete";
	}
	
	/**
	 * 상품 주문정보 등록
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/item/insertShopOrderAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> insertShopOrderAjax(HttpServletRequest req) throws Exception{
		return itemService.insertShopOrder(req);
	}
}
