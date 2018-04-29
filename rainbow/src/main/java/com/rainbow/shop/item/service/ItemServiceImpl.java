package com.rainbow.shop.item.service;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.util.StringUtils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.rainbow.constant.Constant;
import com.rainbow.shop.buyer.dao.InterestItemDao;
import com.rainbow.shop.item.dao.ItemDao;
import com.rainbow.shop.main.dao.MainDao;
import com.rainbow.shop.member.dao.MemberAuthDao;
import com.rainbow.util.AES256SecureUtil;
import com.rainbow.util.FileUploadUtil;
import com.rainbow.util.QuerystringPageing;
import com.rainbow.util.RSASecureUtil;
import com.rainbow.util.SHA512SecureUtil;
import com.rainbow.util.StringTool;

@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private ItemDao dao;
	
	@Autowired
	private MemberAuthDao memberAuthDao;
	
	@Autowired
	private InterestItemDao interestItemDao;
	
	@Autowired
	private MainDao mainDao;
	
	@Resource
    private ApplicationContext applicationContext;
	
	/**
	 * 상품목록 조회
	 */
	@Override
	public HashMap<String, Object> getItemList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		if(!StringUtils.isEmpty(req.getParameter("p_cate_code1"))) {
			paramMap.put("p_cate_code1", req.getParameter("p_cate_code1"));
			resultMap.put("p_cate_code1", req.getParameter("p_cate_code1"));
		}
		if(!StringUtils.isEmpty(req.getParameter("p_cate_code1"))) {
			paramMap.put("p_cate_code2", req.getParameter("p_cate_code2"));
			resultMap.put("p_cate_code2", req.getParameter("p_cate_code2"));
		}
		if(!StringUtils.isEmpty(req.getParameter("p_start_price"))) {
			paramMap.put("p_start_price", req.getParameter("p_start_price"));
			resultMap.put("p_start_price", req.getParameter("p_start_price"));
		}
		if(!StringUtils.isEmpty(req.getParameter("p_end_price"))) {
			paramMap.put("p_end_price", req.getParameter("p_end_price"));
			resultMap.put("p_end_price", req.getParameter("p_end_price"));
		}
		if(!StringUtils.isEmpty(req.getParameter("p_search_text"))) {
			paramMap.put("p_search_type", req.getParameter("p_search_type"));
			paramMap.put("p_search_text", req.getParameter("p_search_text"));
			resultMap.put("p_search_type", req.getParameter("p_search_type"));
			resultMap.put("p_search_text", req.getParameter("p_search_text"));
		}
		paramMap.put("p_sch_order", req.getParameter("p_sch_order"));
		
		int total = dao.getItemListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("p_page")) ? req.getParameter("p_page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("p_pageSize")) ? req.getParameter("p_pageSize") : "12";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("p_page", (int) paging.getLimit().get("start"));
		paramMap.put("p_pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("itemList", dao.getItemList(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 상품목록 페이지 필요 데이터 조회
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> itemList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(req.getParameter("p_sch_order"))) {
			paramMap.put("p_sch_order", "1");
			resultMap.put("p_sch_order", "1");
		}else {
			paramMap.put("p_sch_order", req.getParameter("p_sch_order"));
			resultMap.put("p_sch_order", req.getParameter("p_sch_order"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("p_cate_code1"))) {
			paramMap.put("p_cate_code1", req.getParameter("p_cate_code1"));
			resultMap.put("p_cate_code1", req.getParameter("p_cate_code1"));
			
			paramMap.put("cate_code", req.getParameter("p_cate_code1"));
			resultMap.put("cate_code1_name", dao.getShopCategoryName(paramMap));	//카테고리명 조회
		}
		if(!StringUtils.isEmpty(req.getParameter("p_cate_code2"))) {
			paramMap.put("p_cate_code2", req.getParameter("p_cate_code2"));
			resultMap.put("p_cate_code2", req.getParameter("p_cate_code2"));
			
			paramMap.put("cate_code", req.getParameter("p_cate_code2"));
			resultMap.put("cate_code2_name", dao.getShopCategoryName(paramMap));	//카테고리명 조회
		}
		if(!StringUtils.isEmpty(req.getParameter("p_start_price"))) {
			paramMap.put("p_start_price", req.getParameter("p_start_price"));
			resultMap.put("p_start_price", req.getParameter("p_start_price"));
		}
		if(!StringUtils.isEmpty(req.getParameter("p_end_price"))) {
			paramMap.put("p_end_price", req.getParameter("p_end_price"));
			resultMap.put("p_end_price", req.getParameter("p_end_price"));
		}
		if(StringUtils.isEmpty(req.getParameter("p_price_idx"))) {
			resultMap.put("p_price_idx", "0");
		}else {
			resultMap.put("p_price_idx", req.getParameter("p_price_idx"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("p_search_text"))) {
			paramMap.put("p_search_type", req.getParameter("p_search_type"));
			paramMap.put("p_search_text", req.getParameter("p_search_text"));
			resultMap.put("p_search_type", req.getParameter("p_search_type"));
			resultMap.put("p_search_text", req.getParameter("p_search_text"));
		}
		
		int total = dao.getItemListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("p_page")) ? req.getParameter("p_page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("p_pageSize")) ? req.getParameter("p_pageSize") : "12";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("p_page", (int) paging.getLimit().get("start"));
		paramMap.put("p_pageSize", (int) paging.getLimit().get("end"));
		ArrayList<HashMap<String, Object>> itemList = dao.getItemList(paramMap);
		resultMap.put("itemList", itemList);
		resultMap.put("paging", paging.getScript("itemFrm"));
		resultMap.put("p_page", page);
		resultMap.put("p_pageSize", pageSize);
		resultMap.put("total", total);
		resultMap.put("p_total_page", paging.getLimit().get("total_page"));
		
		if(!StringUtils.isEmpty(itemList) && itemList.size() > 0){
			if(!StringUtils.isEmpty(req.getParameter("p_search_text"))) {
				//검색어가 있을경우 검색어 저장
				paramMap.put("rst_text", req.getParameter("p_search_text"));
				mainDao.insertSearchText(paramMap);
			}
		}
		
		return resultMap;
	}
	
	/**
	 * 상품 뷰페이지 필요 데이터 조회
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> itemView(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultDataMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("item_seq", req.getParameter("item_seq"));
		if(memberMap != null) {
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		}
		
		//상품 뷰 카운트 업데이트
		dao.updateShopItemViewCnt(paramMap);
		
		resultDataMap.put("item", dao.getItem(paramMap));
		resultDataMap.put("itemOption", dao.getItemOptionList(paramMap));
		resultDataMap.put("itemOptionGroup", dao.getItemOptionGroupList(paramMap));
		
		return resultDataMap;
	}
	
	/**
	 * 상품 등록페이지 필요 데이터 조회
	 */
	@Override
	public HashMap<String, Object> itemForm(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultDataMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		resultDataMap.put("item", dao.getItem(paramMap));
		resultDataMap.put("itemOption", dao.getItemOptionList(paramMap));
		resultDataMap.put("itemOptionGroup", dao.getItemOptionGroupList(paramMap));
		
		return resultDataMap;
	}
	
	/**
	 * 상품상세조회
	 */
	@Override
	public HashMap<String, Object> getItem(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		if(memberMap != null) {
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		}
		
		return dao.getItem(paramMap);
	}
	
	/**
	 * 상품 옵션목록 조회
	 */
	@Override
	public ArrayList<HashMap<String, Object>> getItemOptionList(HttpServletRequest req) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		if(!StringUtils.isEmpty(req.getParameter("io_name"))) {
			paramMap.put("io_name", req.getParameter("io_name"));
		}
		
		return dao.getItemOptionList(paramMap);
	}
	
	/**
	 * 상품옵션 첫번째 그룹명 조회
	 */
	@Override
	public ArrayList<HashMap<String, Object>> getItemOptionGroupList(HttpServletRequest req) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		return dao.getItemOptionGroupList(paramMap);
	}
	
	/**
	 * 상품 카테고리 목록 조회
	 */
	@Override
	public ArrayList<HashMap<String, Object>> getItemCategoryList(HttpServletRequest req) throws Exception{
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		return dao.getItemCategoryList(paramMap);
	}
	
	/**
	 * 상품등록
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> insertItem(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> optionMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);	
		HashMap<String, Object> validMap = checkItemValidate(req);
		
		if(!memberMap.get("MB_TYPE").equals("2")) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "판매자로 등록해 주세요.");
		}else if(validMap.get("valid_result").toString().equals("-1")) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", validMap.get("valid_message"));
		}else {
			HashMap<String, Object> fileMap = FileUploadUtil.fileUpload(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),req, "product/item");
			
			if(fileMap == null) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "상품대표이미지는 필수입니다.");
			}else {
				
				if(StringUtils.isEmpty(fileMap.get("item_represent_image"))) {
					returnMap.put("result", Constant.AJAX_RESULT_FAIL);
					returnMap.put("message", "상품대표이미지는 필수입니다.");
				}else {
					paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
					
					//파라미터 추가
					Enumeration<String> params = req.getParameterNames();
					while (params.hasMoreElements()){
					    String name = (String)params.nextElement();
					    paramMap.put(name, req.getParameter(name));
					}
					
					//첨부파일 추가
					Iterator<String> iterator = fileMap.keySet().iterator();
					while (iterator.hasNext()) {
						String key = (String) iterator.next();
						paramMap.put(key, fileMap.get(key));
					}
					
					//상품할인율 계산
					float itemCustPrice = Float.parseFloat(paramMap.get("item_cust_price").toString());
					float itemLastPrice = Float.parseFloat(paramMap.get("item_last_price").toString());
					int itemSaleRate = Math.round((itemCustPrice - itemLastPrice) / itemCustPrice * 100);
					paramMap.put("item_sale_rate", itemSaleRate);
					
//					//상품등록
					dao.insertItem(paramMap);
					int item_seq = (int)paramMap.get("item_seq");
					
					//상품옵션시작
//					String[] arr_io_group = req.getParameterValues("io_group");
					String[] arr_io_name = req.getParameterValues("io_name");
					String[] arr_io_type = req.getParameterValues("io_type");
					String[] arr_io_price = req.getParameterValues("io_price");
					String[] arr_io_stock_qty = req.getParameterValues("io_stock_qty");
					String[] arr_io_noti_qty = req.getParameterValues("io_noti_qty");
					String[] arr_io_use = req.getParameterValues("io_use");
					
					if(arr_io_name != null && arr_io_name.length > 0) {
						for(int i=0; i<arr_io_name.length; i++) {
							optionMap = new HashMap<String, Object>();
							optionMap.put("item_seq", item_seq);
//							optionMap.put("io_group", arr_io_group[i]);
							optionMap.put("io_name", arr_io_name[i]);
							optionMap.put("io_type", arr_io_type[i]);
							optionMap.put("io_price", arr_io_price[i]);
							optionMap.put("io_stock_qty", arr_io_stock_qty[i]);
							optionMap.put("io_noti_qty", arr_io_noti_qty[i]);
							optionMap.put("io_use", arr_io_use[i]);
							optionMap.put("mb_seq", memberMap.get("MB_SEQ"));
							
							list.add(optionMap);
						}
						
						//상품옵션등록
						dao.insertItemOption(list);
					}
					
					returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
					returnMap.put("message", "상품이 등록되었습니다.");
				}
			}
		}
		
		return returnMap;
	}
	
	/**
	 * 상품 수정
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateItem(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> optionMap = new HashMap<String, Object>();
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);	
		HashMap<String, Object> validMap = checkItemValidate(req);
		
		if(StringUtils.isEmpty(req.getParameter("item_seq"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다[상품번호 없음].");
		}else if(validMap.get("valid_result").toString().equals("-1")) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", validMap.get("valid_message"));
		}else {
			HashMap<String, Object> fileMap = FileUploadUtil.fileUpload(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),req, "product/item");
				
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			
			//파라미터 추가
			Enumeration<String> params = req.getParameterNames();
			while (params.hasMoreElements()){
			    String name = (String)params.nextElement();
			    paramMap.put(name, req.getParameter(name));
			}
			
			//첨부파일 추가
			Iterator<String> iterator = fileMap.keySet().iterator();
			while (iterator.hasNext()) {
				String key = (String) iterator.next();
				paramMap.put(key, fileMap.get(key));
			}
			
//			//상품수정
			int result_cnt = dao.updateItem(paramMap);
			int item_seq = Integer.parseInt(req.getParameter("item_seq"));
			
			//상품옵션시작
			//등록전 기존옵션 삭제
			dao.deleteItemOption(paramMap);
			
			String[] arr_io_name = req.getParameterValues("io_name");
			String[] arr_io_type = req.getParameterValues("io_type");
			String[] arr_io_price = req.getParameterValues("io_price");
			String[] arr_io_stock_qty = req.getParameterValues("io_stock_qty");
			String[] arr_io_noti_qty = req.getParameterValues("io_noti_qty");
			String[] arr_io_use = req.getParameterValues("io_use");
			
			if(arr_io_name != null && arr_io_name.length > 0) {
				for(int i=0; i<arr_io_name.length; i++) {
					optionMap = new HashMap<String, Object>();
					optionMap.put("item_seq", item_seq);
					optionMap.put("io_name", arr_io_name[i]);
					optionMap.put("io_type", arr_io_type[i]);
					optionMap.put("io_price", arr_io_price[i]);
					optionMap.put("io_stock_qty", arr_io_stock_qty[i]);
					optionMap.put("io_noti_qty", arr_io_noti_qty[i]);
					optionMap.put("io_use", arr_io_use[i]);
					optionMap.put("mb_seq", memberMap.get("MB_SEQ"));
					
					list.add(optionMap);
				}
				
				//상품옵션등록
				dao.insertItemOption(list);
			}
			
			returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			returnMap.put("message", "상품이 저장되었습니다.");
		}
		
		return returnMap;
	}
	
	/**
	 * 상품 Validate Check
	 * @param req
	 * @return
	 * @throws Exception
	 */
	public HashMap<String, Object> checkItemValidate(HttpServletRequest req) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("valid_result", "1");
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("cate_code1"), Constant.ITEM_CATEGORY1_EXPRESSION)){
			map.put("valid_result", "-1");
			map.put("valid_message", "카테고리가 유효하지 않습니다.");
			return map;
		}
		if(!Constant.getRegexMatchResultOfString(req.getParameter("cate_code2"), Constant.ITEM_CATEGORY2_EXPRESSION)){
			map.put("valid_result", "-1");
			map.put("valid_message", "카테고리가 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_title"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "상품제목이 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_name"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "상품명이 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_keyword"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "키워드가 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_origin"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "원산지가 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_maker"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "제조사가 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_content"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "상품상세내용이 유효하지 않습니다.");
			return map;
		}
		if(!Constant.getRegexMatchResultOfString(req.getParameter("item_price"), Constant.PRICE_EXPRESSION)){
			map.put("valid_result", "-1");
			map.put("valid_message", "상품가격이 유효하지 않습니다.");
			return map;
		}
		if(!StringUtils.isEmpty(req.getParameter("item_cust_price"))) {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("item_cust_price"), Constant.PRICE_EXPRESSION)){
				map.put("valid_result", "-1");
				map.put("valid_message", "시중가격이 유효하지 않습니다.");
				return map;
			}
		}
		if(!StringUtils.isEmpty(req.getParameter("item_coupon_price"))) {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("item_coupon_price"), Constant.PRICE_EXPRESSION)){
				map.put("valid_result", "-1");
				map.put("valid_message", "쿠폰할인금액이 유효하지 않습니다.");
				return map;
			}
		}
		if(!Constant.getRegexMatchResultOfString(req.getParameter("item_last_price"), Constant.PRICE_EXPRESSION)){
			map.put("valid_result", "-1");
			map.put("valid_message", "최종판매가격이 유효하지 않습니다.");
			return map;
		}
		if(Integer.parseInt(req.getParameter("item_last_price")) <= 0) {
			map.put("valid_result", "-1");
			map.put("valid_message", "최종판매가격은 0보다 작거나 같을 수 없습니다.");
			return map;
		}
		
		if(!Constant.getRegexMatchResultOfString(req.getParameter("item_qty"), Constant.PRICE_EXPRESSION)){
			map.put("valid_result", "-1");
			map.put("valid_message", "재고수량이 유효하지 않습니다.");
			return map;
		}
		if(!Constant.getRegexMatchResultOfString(req.getParameter("item_sell_period_from"), Constant.DATE_EXPRESSION)){
			map.put("valid_result", "-1");
			map.put("valid_message", "상품판매일자 시작일이 유효하지 않습니다.");
			return map;
		}
		if(!Constant.getRegexMatchResultOfString(req.getParameter("item_sell_period_to"), Constant.DATE_EXPRESSION)){
			map.put("valid_result", "-1");
			map.put("valid_message", "상품판매일자 종료일이 유효하지 않습니다.");
			return map;
		}
		if(req.getParameter("item_sell_period_from").compareTo(req.getParameter("item_sell_period_to")) > 0) {
			map.put("valid_result", "-1");
			map.put("valid_message", "상품판매 시작일은 종료일보다 클 수 없습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_tag"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "상품태그가 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_tag_sub"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "상품태그가 유효하지 않습니다.");
			return map;
		}
		if(StringUtils.isEmpty(req.getParameter("item_delivery_charge_type"))) {
			map.put("valid_result", "-1");
			map.put("valid_message", "배송비유형이 유효하지 않습니다.");
			return map;
		}
		
		
		return map;
	}
	
	/**
	 * 상품문의 등록
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> insertItemQa(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		//로그인체크
		if(memberMap == null) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "로그인이 필요합니다.");
		}else {
			if(StringUtils.isEmpty(req.getParameter("item_seq"))) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "상품번호가 유효하지 않습니다.");
				return returnMap;
			}
			if(StringUtils.isEmpty(req.getParameter("iqa_subject"))) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "질문제목이 유효하지 않습니다.");
				return returnMap;
			}
			if(StringUtils.isEmpty(req.getParameter("content"))) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "질문내용이 유효하지 않습니다.");
				return returnMap;
			}
				
			paramMap.put("item_seq", req.getParameter("item_seq"));
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			paramMap.put("iqa_subject", req.getParameter("iqa_subject"));
			paramMap.put("iqa_open", req.getParameter("iqa_open"));
			
			//질문 마스터 등록
			dao.insertItemQa(paramMap);		//등록후 키값 리턴됨. 질문내용 등록시 사용됨
			
			//첨부이미지 있을경우 이미지 업로드
			HashMap<String, Object> fileMap = FileUploadUtil.fileUpload(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),req, "product/qa");
			if(fileMap != null) {
				//첨부파일 추가
				Iterator<String> iterator = fileMap.keySet().iterator();
				while (iterator.hasNext()) {
					String key = (String) iterator.next();
					paramMap.put(key, fileMap.get(key));
				}
			}
			
			//질문내용 등록
			paramMap.put("content", req.getParameter("content"));
			paramMap.put("content_type", "0");	//0:질문 1:답변
			paramMap.put("content_order", 1);	//내용 순번(처음은 1)
			
			dao.insertItemQaContent(paramMap);
			
			returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			returnMap.put("message", "등록하였습니다.");
		}
		
		return returnMap;
	}
	
	/**
	 * 상품문의 내용(질문 또는 답변) 등록
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> insertItemQaContent(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("iqa_seq"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.[질문번호 오류]");
			return returnMap;
		}
		if(StringUtils.isEmpty(req.getParameter("content"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "내용을 입력해 주세요.");
			return returnMap;
		}
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		paramMap.put("iqa_seq", req.getParameter("iqa_seq"));
		paramMap.put("content", req.getParameter("content"));
		paramMap.put("content_type", req.getParameter("content_type"));
		paramMap.put("content_order", req.getParameter("content_order"));
		
		//첨부이미지 있을경우 이미지 업로드
		HashMap<String, Object> fileMap = FileUploadUtil.fileUpload(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),req, "product/qa");
		if(fileMap != null) {
			//첨부파일 추가
			Iterator<String> iterator = fileMap.keySet().iterator();
			while (iterator.hasNext()) {
				String key = (String) iterator.next();
				paramMap.put(key, fileMap.get(key));
			}
		}
		
		//질문(답변) 등록
		dao.insertItemQaContent(paramMap);
		
		//질문에 대한 답변여부 상태값 변경
		paramMap.put("iqa_is_answer", req.getParameter("content_type"));
		dao.updateShopItemQaIsAnswer(paramMap);
		
		
		returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		returnMap.put("message", "등록하였습니다.");
		
		return returnMap;
	}
	
	/**
	 * 상품문의 목록 조회
	 */
	@Override
	public HashMap<String, Object> getItemShopQaList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		int total = dao.getItemShopQaListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "5";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("qaList", dao.getItemShopQaList(paramMap));
		resultMap.put("paging", paging.getScript("lSupportWriteFrm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		resultMap.put("sessionMember", StringTool.getSessionMap(req));
		
		return resultMap;
	}
	
	/**
	 * 상품문의 질문(답변)내역 조회
	 */
	@Override
	public HashMap<String, Object> getShopItemQaContentList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("iqa_seq", req.getParameter("iqa_seq"));
		
		resultMap.put("itemQa", dao.getShopItemQa(paramMap));
		
		ArrayList<HashMap<String, Object>> data = dao.getShopItemQaContentList(paramMap);
		if(data != null) {
			for(int i=0; i<data.size(); i++) {
				data.get(i).put("CONTENT", StringTool.getLineCharacterReplace((String)data.get(i).get("CONTENT")));
			}
		}
		resultMap.put("contentList", data);
		
		return resultMap;
	}
	
	/**
	 * 관심상품 목록조회
	 */
	@Override
	public ArrayList<HashMap<String, Object>> getMyItemList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(memberMap != null) {
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			
			return dao.getMyItemList(paramMap);
		}else {
			return null;
		}
	}
	
	/**
	 * 관심상품 등록/해제
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> insertMyItem(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		
		memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("item_seq"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "선택된 상품이 없습니다.");
			return returnMap;
		}
		if(StringUtils.isEmpty(req.getParameter("action_type"))){
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "등록/해제 구분이 유효하지 않습니다.");
			return returnMap;
		}
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		String actionType = req.getParameter("action_type");
		if(actionType.equals("C")) {
			
			HashMap<String, Object> itemMap = dao.getItem(paramMap);
			
			if(itemMap.get("ITEM_DISPLAY").equals("1")) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "해당 상품은 판매자가 삭제한 상품입니다.");
				return returnMap;
			}else {
				if(!itemMap.get("ITEM_STATUS").equals("2")) {
					String message = "";
					if(itemMap.get("ITEM_STATUS").equals("3")) {
						message = message + itemMap.get("ITEM_NAME") + "는(은) 품절된 상품입니다.<br/>";
					}else if(itemMap.get("ITEM_STATUS").equals("4")) {
						message = message + itemMap.get("ITEM_NAME") + "는(은) 판매가 종료된 상품입니다.<br/>";
					}else if(itemMap.get("ITEM_STATUS").equals("5")) {
						message = message + itemMap.get("ITEM_NAME") + "는(은) 판매기간이 만료된 상품입니다.<br/>";
					} 
					
					returnMap.put("result", Constant.AJAX_RESULT_FAIL);
					returnMap.put("message", message);
					return returnMap;
				}
			}
			
			//중복체크
			HashMap<String, Object> myItem = interestItemDao.getMyInterestItem(paramMap);
			if(!StringUtils.isEmpty(myItem)) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "이미 등록되어 있는 상품입니다.");
				return returnMap;
			}
			
			dao.insertMyItem(paramMap);
			returnMap.put("message", "관심상품으로 등록되었습니다.");
		}else if(actionType.equals("D")) {
			int result = dao.deleteMyItem(paramMap);
			if(result == 0) {
				returnMap.put("message", "이미 삭제된 상품입니다.");
			}else {
				returnMap.put("message", "관심상품이 삭제되었습니다.");
			}
		}
		returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		
		return returnMap;
	}
	
	/**
	 * 관심상품 조회
	 */
	@Override
	public HashMap<String, Object> getMyItem(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("item_seq"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			return resultMap;
		}
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("myItem", interestItemDao.getMyInterestItem(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 장바구니 등록
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> insertShopCart(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		memberMap = StringTool.getSessionMap(req);
		
		String jsonStr = req.getParameter("jsonStr");
		
		if(StringUtils.isEmpty(jsonStr) || StringUtils.isEmpty(req.getParameter("item_seq"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
		}else {
			paramMap.put("item_seq", req.getParameter("item_seq"));
			HashMap<String, Object> itemMap = dao.getItem(paramMap);
			
			if(itemMap == null) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "잘못된 요청입니다.");
				return returnMap;
			}
			
			if(!itemMap.get("ITEM_STATUS").equals("2")) {
				if(itemMap.get("ITEM_STATUS").equals("3")) {
					returnMap.put("message", "품절된 상품입니다.");
				}else if(itemMap.get("ITEM_STATUS").equals("4")) {
					returnMap.put("message", "판매가 종료된 상품입니다.");
				}else if(itemMap.get("ITEM_STATUS").equals("5")) {
					returnMap.put("message", "판매기간이 만료된 상품입니다.");
				}
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				return returnMap;
			}
			
			if(itemMap.get("ITEM_DISPLAY").equals("1")) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "판매자가 삭제한 상품입니다.");
				return returnMap;
			}
			
			Gson gson = new Gson();
			List<HashMap<String,Object>> list = gson.fromJson(jsonStr, new TypeToken<List<HashMap<String,Object>>>(){}.getType());
			
			String orderNo = StringTool.getNowDate("yyyyMMddHHmmssSSS");
			String cartIp = StringTool.getClientIp(req);
			for(int i=0;i < list.size();i++) {
				list.get(i).put("order_no",  orderNo);
				list.get(i).put("mb_seq",  memberMap.get("MB_SEQ"));
				list.get(i).put("cart_ip",  cartIp);
			}
			dao.insertShopCart(list);
			
			returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			returnMap.put("message", "장바구니에 등록되었습니다.");
			returnMap.put("order_no", orderNo);
		}
		
		return returnMap;
	}
	
	/**
	 * 장바구니 목록 조회
	 */
	@Override
	public ArrayList<HashMap<String, Object>> getShopCartList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		
		memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		return dao.getShopCartList(paramMap);
	}
	
	/**
	 * 장바구니 그룹 목록
	 */
	@Override
	public ArrayList<HashMap<String, Object>> getShopCartGroupList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		
		memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		return dao.getShopCartGroupList(paramMap);
	}
	
	/**
	 * 장바구니 목록 페이지 데이터 검색
	 */
	@Override
	public HashMap<String, Object> itemCartList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultDataMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		
		memberMap = StringTool.getSessionMap(req);
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		resultDataMap.put("cartList", dao.getShopCartList(paramMap));
		resultDataMap.put("cartGroupList", dao.getShopCartGroupList(paramMap));
		
		return resultDataMap;
	}
	
	/**
	 * 장바구니 삭제(그룹삭제 또는 옵션일부 삭제)
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> deleteShopCart(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("order_no", req.getParameter("order_no"));
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		if(!StringUtils.isEmpty(req.getParameter("cart_seq"))) {
			paramMap.put("cart_seq", req.getParameter("cart_seq"));
		}
		
		if(StringUtils.isEmpty(req.getParameter("order_no"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
		}else {
			int result = dao.deleteShopCart(paramMap);
			if(result > 0) {
				returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
				returnMap.put("message", "삭제하였습니다.");
			}else {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "삭제에 실패했습니다.");
			}
		}
		
		return returnMap;
	}
	
	/**
	 * 상품 장바구니 선택삭제, 전체삭제
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> deleteShopCartAll(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("order_no_str", req.getParameter("order_no_str"));
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		int result = dao.deleteShopCartAll(paramMap);
		if(result > 0) {
			returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			returnMap.put("message", "삭제하였습니다.");
		}else {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "삭제에 실패했습니다.");
		}
		
		return returnMap;
	}
	
	/**
	 * 장바구니 주문수량 변경
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateShopCartQty(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("cart_seq"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
		}else {
			paramMap.put("order_no", req.getParameter("order_no"));
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			paramMap.put("cart_seq", req.getParameter("cart_seq"));
			paramMap.put("cart_qty", req.getParameter("cart_qty"));
			
			int result = dao.updateShopCartQty(paramMap);
			if(result > 0) {
				returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
				returnMap.put("message", "변경하였습니다.");
			}else {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "변경에 실패했습니다.");
			}
		}
		
		return returnMap;
	}
	
	/**
	 * 상품옵션 레이어 페이지 데이터 조회
	 */
	@Override
	public HashMap<String, Object> itemOptionLayer(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultDataMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("order_no", req.getParameter("order_no"));
		paramMap.put("item_seq", req.getParameter("item_seq"));
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		resultDataMap.put("item", dao.getItem(paramMap));
		resultDataMap.put("itemOption", dao.getItemOptionList(paramMap));
		resultDataMap.put("itemOptionGroup", dao.getItemOptionGroupList(paramMap));
		resultDataMap.put("cartList", dao.getShopCartList(paramMap));
		
		return resultDataMap;
	}
	
	/**
	 * 장바구니 목록 수정(하나의 상품그룹)
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateShopCart(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		memberMap = StringTool.getSessionMap(req);
		
		String itemSeq = req.getParameter("item_seq");
		String orderNo = req.getParameter("order_no");	//기존주문번호 고유하기위해 받음
		String jsonStr = req.getParameter("jsonStr");
		
		if(StringUtils.isEmpty(itemSeq) || StringUtils.isEmpty(orderNo)) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
		}else {
			
			//기존장바구니 내역 삭제
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			paramMap.put("item_seq", itemSeq);
			paramMap.put("order_no", orderNo);
			
			//기존 장바구니 삭제
			dao.deleteShopCart(paramMap);
			
			if(!StringUtils.isEmpty(jsonStr)) {
				Gson gson = new Gson();
				List<HashMap<String,Object>> list = gson.fromJson(jsonStr, new TypeToken<List<HashMap<String,Object>>>(){}.getType());
				
				String cartIp = StringTool.getClientIp(req);
				paramMap = new HashMap<String, Object>();
				for(int i=0;i < list.size();i++) {
					list.get(i).put("order_no", orderNo);
					list.get(i).put("mb_seq", memberMap.get("MB_SEQ"));
					list.get(i).put("cart_ip", cartIp);
					
					StringTool.HashMapConsoleViewer(list.get(i));
				}
				dao.insertShopCart(list);
			}
			
			returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			returnMap.put("message", "장바구니가 수정되었습니다.");
		}
		
		return returnMap;
	}
	
	/**
	 * 주문 상품목록 상태값 확인
	 */
	@Override
	public HashMap<String, Object> checkOrderItemStatus(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(req.getParameter("order_list"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
			return returnMap;
		}
		
		Gson gson = new Gson();
		ArrayList<HashMap<String, Object>> list = gson.fromJson(req.getParameter("order_list"), new TypeToken<ArrayList<HashMap<String, Object>>>(){}.getType());
		
		HashMap<String, Object> itemMap = new HashMap<String, Object>();
		String message = "";
		String orderNo= "";
		String result = Constant.AJAX_RESULT_SUCCESS;
		Loop : for(int i=0; i<list.size(); i++) {
			
			paramMap.put("item_seq", list.get(i).get("item_seq"));
			itemMap = dao.getItem(paramMap);
			
			if(itemMap == null) {
				result = Constant.AJAX_RESULT_FAIL;
				message = "잘못된 요청입니다.";
				break Loop;
			}else {
				if(itemMap.get("ITEM_DISPLAY").equals("1")) {
					result = Constant.AJAX_RESULT_FAIL;
					message = message + itemMap.get("ITEM_NAME") + "는(은) 판매자가 삭제한 상품입니다.<br/>";
					
					if(StringUtils.isEmpty(orderNo)) {
						orderNo = list.get(i).get("order_no").toString();
					}else {
						orderNo = orderNo + "|" + list.get(i).get("order_no").toString();
					}
				}else {
					if(!itemMap.get("ITEM_STATUS").equals("2")) {
						result = Constant.AJAX_RESULT_FAIL;
						if(itemMap.get("ITEM_STATUS").equals("3")) {
							message = message + itemMap.get("ITEM_NAME") + "는(은) 품절된 상품입니다.<br/>";
						}else if(itemMap.get("ITEM_STATUS").equals("4")) {
							message = message + itemMap.get("ITEM_NAME") + "는(은) 판매가 종료된 상품입니다.<br/>";
						}else if(itemMap.get("ITEM_STATUS").equals("5")) {
							message = message + itemMap.get("ITEM_NAME") + "는(은) 판매기간이 만료된 상품입니다.<br/>";
						} 
						
						if(StringUtils.isEmpty(orderNo)) {
							orderNo = list.get(i).get("order_no").toString();
						}else {
							orderNo = orderNo + "|" + list.get(i).get("order_no").toString();
						}
					}
				}
			}
		}
		
		returnMap.put("result", result);
		returnMap.put("message", message);
		returnMap.put("orderNo", orderNo);
		
		return returnMap;
	}
	
	/**
	 * 상품주문 페이지 데이터 조회
	 */
	@Override
	public HashMap<String, Object> itemOrderForm(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultDataMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		
		memberMap = StringTool.getSessionMap(req);
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		paramMap.put("order_no", req.getParameter("order_no"));
		
		resultDataMap.put("cartList", dao.getShopCartList(paramMap));
		resultDataMap.put("cartGroupList", dao.getShopCartGroupList(paramMap));
		
		return resultDataMap;
	}
	
	/**
	 * 상품주문정보 등록
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> insertShopOrder(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = new HashMap<String, Object>();
		memberMap = StringTool.getSessionMap(req);
		
		String orderStr = req.getParameter("orderStr");
		String payType = req.getParameter("pay_type");
		
		if(StringUtils.isEmpty(orderStr) || StringUtils.isEmpty(payType) || orderStr.equals("[]")) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
			return returnMap;
		}else {
			
			if(payType.equals("1") || payType.equals("2")) {
				if(StringUtils.isEmpty(req.getParameter("confirm_password"))) {
					returnMap.put("result", Constant.AJAX_RESULT_FAIL);
					returnMap.put("message", "비밀번호를 입력해 주세요.");
					return returnMap;
				}else {
					String confirmPassword = req.getParameter("confirm_password");
					//원본 비밀번호
					String decRsaMemberPassword = RSASecureUtil.decryptRsa(req, confirmPassword);
					if(!Constant.getRegexMatchResultOfString(decRsaMemberPassword,Constant.PW_REGULAR_EXPRESSTION)){
						returnMap.put("result", Constant.AJAX_RESULT_FAIL);
						returnMap.put("message","비밀번호가 유효하지 않습니다.");
						return returnMap;
					}else {
						//회원정보 검색
						paramMap.put("mb_id", memberMap.get("MB_ID"));
						HashMap<String,Object> map = memberAuthDao.getMemberPassword(paramMap);
						
						//현재 입력 받은 비밀번호를 이전에 사용되었던 salt 를 이용해서 암호화한다.
						String comparePassword =  SHA512SecureUtil.incryptSha512(decRsaMemberPassword, (String)map.get("MB_SESSION_ID"));
						if(!comparePassword.equals((String)map.get("MB_PASSWORD"))) {
							returnMap.put("result", Constant.AJAX_RESULT_FAIL);
							returnMap.put("message","비밀번호를 잘못입력하셨습니다.");
							return returnMap;
						}
					}
				}
			}
			
			Gson gson = new Gson();
			List<HashMap<String,Object>> list = gson.fromJson(orderStr, new TypeToken<List<HashMap<String,Object>>>(){}.getType());
			
			String strOrderNo = "";
			for(int i=0;i < list.size();i++) {
				if(StringUtils.isEmpty(strOrderNo)) {
					strOrderNo = "'" + list.get(i).get("order_no") + "'";
				}else {
					strOrderNo = strOrderNo + ",'" + list.get(i).get("order_no") + "'";
				}
				AES256SecureUtil aes = new AES256SecureUtil();
				list.get(i).put("recv_hp", aes.aesEncode((String)list.get(i).get("recv_hp")));
			}
			
			//주문한 상품의 총 금액 조회
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			paramMap.put("order_no", strOrderNo);
			HashMap<String, Object> amountMap = dao.getOrderItemTotalPrice(paramMap);
			int itemAmount = Integer.parseInt(amountMap.get("ITEM_AMOUNT").toString());
			int deliveryAmount = Integer.parseInt(amountMap.get("DELIVERY_AMOUNT").toString());
			int totalPrice = Integer.parseInt(amountMap.get("TOTAL_AMOUNT").toString());
			
			//주문마스터 등록
			paramMap.put("order_price", itemAmount);
			paramMap.put("delivery_price", deliveryAmount);
			paramMap.put("pay_type", payType);	//1:현금성e-money 2:카드성e-money 3:무통장입금 4:카드결제 
			
			dao.insertShopOrder(paramMap);
			long orderSeq = (long)paramMap.get("order_seq");
			
			//주문정보 등록
			String orderIp = StringTool.getClientIp(req);
			for(int i=0;i < list.size();i++) {
				list.get(i).put("order_seq", orderSeq);
				list.get(i).put("mb_seq", memberMap.get("MB_SEQ"));
				list.get(i).put("order_ip", orderIp);
			}
			dao.insertShopOrderInfo(list);
			
			//e-money 차감
			HashMap<String, Object> paramMap2 = new HashMap<String, Object>();
			paramMap2.put("mb_seq", memberMap.get("MB_SEQ"));
			if(payType.equals("1") || payType.equals("2")) {
				
				paramMap2.put("cash_amount", totalPrice);
//				paramMap2.put("cl_title", "상품구매");
				paramMap2.put("cl_type", payType.equals("1")?"5":"6");
				paramMap2.put("order_seq", orderSeq);
				
				//캐쉬로그 등록, 회원캐쉬 적용
				HashMap<String, Object> resultMap = dao.insertCashLogProcedure(paramMap2);
				//캐쉬로그 프로시저 내 트랜잭션 없음
				//캐쉬로그 등록후 결과값 확인후 결과가 1이 아닌경우 강제롤백 실행
				if((int)resultMap.get("return_query") != 1) {
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//강제롤백구문
					returnMap.put("result", Constant.AJAX_RESULT_FAIL);
					returnMap.put("message", resultMap.get("return_result_text"));
					
					return returnMap;
				}
				
				paramMap2.put("order_state", "2");			//결제대기 --> 결제완료
				dao.updateShopOrderInfoState(paramMap2);	//주문내역 결제완료로 변경
			}
			
			//장바구니상태변경(쇼핑 --> 주문)
			paramMap2.put("order_no", strOrderNo);
			dao.updateShopCartState(paramMap2);
			
			//주문내역에 대한 모든 건에 대한 로그등록
			//로그 등록시 파라미터로 주문마스터 등록후 리턴받은 order_seq 사용
			dao.insertShopOrderInfoLog(paramMap);
			
			//상품판매수 업데이트
			paramMap2 = new HashMap<String, Object>();
			for(int i=0;i < list.size();i++) {
				paramMap2.put("item_seq", list.get(i).get("item_seq"));
				paramMap2.put("order_no", list.get(i).get("order_no"));
				
				dao.updateShopItemSellCnt(paramMap2);
			}
			
			returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			returnMap.put("message", "주문이 완료되었습니다.");
		}
		
		return returnMap;
	}
	
	
}
