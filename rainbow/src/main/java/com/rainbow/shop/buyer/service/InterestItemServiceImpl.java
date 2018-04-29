package com.rainbow.shop.buyer.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.rainbow.constant.Constant;
import com.rainbow.shop.buyer.dao.InterestItemDao;
import com.rainbow.shop.item.dao.ItemDao;
import com.rainbow.util.StringTool;

@Service
public class InterestItemServiceImpl implements InterestItemService {

	@Autowired
	InterestItemDao interestItemDao;
	
	@Autowired
	ItemDao itemDao;
	/**
	 * 관심상품 리스트 가져오기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getMyInterestItemList(HttpServletRequest req) throws Exception {
		
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		if(!member.get("MB_TYPE").equals("1")) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//구매자 회원이 아님
			return resultMap;
		}
		
		if(StringUtils.isEmpty(req.getParameter("page"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "2");//잘못된 요청(페이지값)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("page"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "2");//잘못된 요청(페이지값)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("pageSize"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "3");//잘못된 요청(페이지값)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("pageSize"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "3");//잘못된 요청(페이지값)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("type"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "4");//잘못된 요청(타입)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("type"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "4");//잘못된 요청(타입)
				return resultMap;
			}
		}
		
		int page = !StringUtils.isEmpty(req.getParameter("page")) ? Integer.parseInt(req.getParameter("page")) : 1;
		int pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? Integer.parseInt(req.getParameter("pageSize")) : 15;
		paramMap.put("mb_seq",  member.get("MB_SEQ"));
		
		paramMap.put("page", (page-1) * pageSize);
		paramMap.put("pageSize", pageSize);
		paramMap.put("type", req.getParameter("type"));
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		ArrayList<HashMap<String,Object>> myInterestItemList = interestItemDao.getMyInterestItemList(paramMap);
		int myInterestItemListCount = interestItemDao.getMyInterestItemListCount(paramMap);
		resultMap.put("page", page);
		//몇개의 페이지를 가져야 하는지 구한다.
		int totalPage = (int)Math.ceil((double)myInterestItemListCount / (double)pageSize);
		resultMap.put("totalPage", totalPage);
		resultMap.put("myInterestItemList", myInterestItemList);
		resultMap.put("type", req.getParameter("type"));
		// TODO Auto-generated method stub
		return resultMap;
	}

	
	
	/**
	 * 관심상품 삭제하기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> deleteMyInterestItem(HttpServletRequest req) throws Exception {
		
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		if(!member.get("MB_TYPE").equals("1")) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//구매자 회원이 아님
			return resultMap;
		}
		
		if(StringUtils.isEmpty(req.getParameter("page"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "2");//잘못된 요청(페이지값)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("page"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "2");//잘못된 요청(페이지값)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("pageSize"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "3");//잘못된 요청(페이지값)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("pageSize"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "3");//잘못된 요청(페이지값)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("type"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "4");//잘못된 요청(타입)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("type"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "4");//잘못된 요청(타입)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("item_seq"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "5");//잘못된 요청
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("item_seq"), Constant.NUMBER_EXPRESSION)) {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "5");//잘못된 요청
				return resultMap;
			}
		}
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		int result = interestItemDao.deleteMyInterestItem(paramMap);
		
		if(result > 0) {
			int page = !StringUtils.isEmpty(req.getParameter("page")) ? Integer.parseInt(req.getParameter("page")) : 1;
			int pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? Integer.parseInt(req.getParameter("pageSize")) : 15;
			
			int myInterestItemListCount = interestItemDao.getMyInterestItemListCount(paramMap);
			
			int totalPage = (int)Math.ceil((double)myInterestItemListCount / (double)pageSize);
			
			if(myInterestItemListCount == 0){
				page = 1;
			}else {
				if(page > totalPage) {
					page = totalPage;
				}
			}
			
			paramMap.put("page", (page-1) * pageSize);
			paramMap.put("pageSize", pageSize);
			paramMap.put("type", req.getParameter("type"));
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			ArrayList<HashMap<String,Object>> myInterestItemList = interestItemDao.getMyInterestItemList(paramMap);
			resultMap.put("page", page);
			resultMap.put("totalPage", totalPage);
			resultMap.put("myInterestItemList", myInterestItemList);
			resultMap.put("type", req.getParameter("type"));
			return resultMap;
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "6");//이미 삭제된 관심상품 아이템.
			return resultMap;
		}
		
	}

	/**
	 * 관심상품 추가하기
	 */
	@Override
	public HashMap<String, Object> insertMyInterestItem(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		
		if(!member.get("MB_TYPE").equals("1")) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "1");//구매자 회원이 아님
			return resultMap;
		}
		
		if(StringUtils.isEmpty(req.getParameter("page"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "2");//잘못된 요청(페이지값)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("page"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "2");//잘못된 요청(페이지값)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("pageSize"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "3");//잘못된 요청(페이지값)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("pageSize"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "3");//잘못된 요청(페이지값)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("type"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "4");//잘못된 요청(타입)
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("type"),Constant.NUMBER_EXPRESSION)){
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "4");//잘못된 요청(타입)
				return resultMap;
			}
		}
		
		if(StringUtils.isEmpty(req.getParameter("item_seq"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "5");//잘못된 요청
			return resultMap;
		}else {
			if(!Constant.getRegexMatchResultOfString(req.getParameter("item_seq"), Constant.NUMBER_EXPRESSION)) {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "5");//잘못된 요청
				return resultMap;
			}
		}
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		paramMap.put("item_seq", req.getParameter("item_seq"));
		
		HashMap<String,Object> item = interestItemDao.getMyInterestItem(paramMap);
		
		//이미 존재하는 관심상품일 경우
		if(!StringUtils.isEmpty(item)) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "6");//이미 추가된 상품
			return resultMap;
		}
		
		item = itemDao.getItem(paramMap);
		
		if(StringUtils.isEmpty(item)) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "8");//없는상품 
			return resultMap;
		}else {
			if(!item.get("ITEM_STATUS").equals("2")) {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "9");//판매종료된 상품
				return resultMap;
			}
			
			if(item.get("ITEM_DISPLAY").equals("1")) {
				resultMap.put("result", Constant.AJAX_RESULT_FAIL);
				resultMap.put("data", "10");//판매종료된 상품
				return resultMap;
			}
		}
		
		int result = interestItemDao.insertMyInterestItem(paramMap);
		
		if(result > 0) {
			
			int page = !StringUtils.isEmpty(req.getParameter("page")) ? Integer.parseInt(req.getParameter("page")) : 1;
			int pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? Integer.parseInt(req.getParameter("pageSize")) : 15;
			paramMap.put("mb_seq",  member.get("MB_SEQ"));
			
			paramMap.put("page", (page-1) * pageSize);
			paramMap.put("pageSize", pageSize);
			paramMap.put("type", req.getParameter("type"));
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			ArrayList<HashMap<String,Object>> myInterestItemList = interestItemDao.getMyInterestItemList(paramMap);
			int myInterestItemListCount = interestItemDao.getMyInterestItemListCount(paramMap);
			resultMap.put("page", page);
			//몇개의 페이지를 가져야 하는지 구한다.
			int totalPage = (int)Math.ceil((double)myInterestItemListCount / (double)pageSize);
			resultMap.put("totalPage", totalPage);
			resultMap.put("myInterestItemList", myInterestItemList);
			resultMap.put("type", req.getParameter("type"));
			return resultMap;
		}else {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("data", "7");//추가 실패 관리자 문의
			return resultMap;
		}
		
	}
}
