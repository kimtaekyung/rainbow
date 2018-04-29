package com.rainbow.shop.buyer.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
import com.rainbow.shop.buyer.dao.BuyManageDao;
import com.rainbow.shop.item.dao.ItemDao;
import com.rainbow.util.AES256SecureUtil;
import com.rainbow.util.FileUploadUtil;
import com.rainbow.util.QuerystringPageing;
import com.rainbow.util.StringTool;

@Service
public class BuyManageServiceImpl implements BuyManageService {

	@Autowired
	private BuyManageDao buyManageDao;
	
	@Autowired
	private ItemDao itemDao;
	
	@Resource
    private ApplicationContext applicationContext;
	
	/**
	 * 판매관리 레프트 메뉴 데이터 카운트 조회
	 */
	@Override
	public HashMap<String, Object> getBuyLeftMenuDataCount(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		resultMap.put("orderGroupCount", buyManageDao.getShopOrderInfoStateGroupCount(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 상품주문내역 페이지 데이터 조회
	 */
	@Override
	public HashMap<String, Object> buyList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
			resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("order_no"))) {
			paramMap.put("order_no", req.getParameter("order_no"));
			resultMap.put("order_no", req.getParameter("order_no"));
		}
		if(!StringUtils.isEmpty(req.getParameter("order_state"))) {
			paramMap.put("order_state", req.getParameter("order_state"));
			resultMap.put("order_state", req.getParameter("order_state"));
		}
		if(!StringUtils.isEmpty(req.getParameter("order_name"))) {
			paramMap.put("order_name", req.getParameter("order_name"));
			resultMap.put("order_name", req.getParameter("order_name"));
		}
		if(!StringUtils.isEmpty(req.getParameter("seller_mb_id"))) {
			paramMap.put("seller_mb_id", req.getParameter("seller_mb_id"));
			resultMap.put("seller_mb_id", req.getParameter("seller_mb_id"));
		}
		if(!StringUtils.isEmpty(req.getParameter("recv_name"))) {
			paramMap.put("recv_name", req.getParameter("recv_name"));
			resultMap.put("recv_name", req.getParameter("recv_name"));
		}
		if(!StringUtils.isEmpty(req.getParameter("order_seq"))) {
			paramMap.put("order_seq", req.getParameter("order_seq"));
			resultMap.put("order_seq", req.getParameter("order_seq"));
			
			if(!StringUtils.isEmpty(req.getParameter("order_detail"))) {
				HashMap<String, Object> orderMap = buyManageDao.getShopOrderOne(paramMap);
				if(!StringUtils.isEmpty(orderMap)) {
					paramMap.put("sch_sdate", orderMap.get("ORDER_DTTM_YMD"));
					resultMap.put("sch_sdate", orderMap.get("ORDER_DTTM_YMD"));
				}
			}
		}
		
		resultMap.put("quick", req.getParameter("quick"));
		
		
		int total = buyManageDao.getBuyListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("buyList", buyManageDao.getBuyList(paramMap));
		resultMap.put("paging", paging.getScript("schFrm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	/**
	 * 구매관리 - 주문상세페이지 데이터 조회
	 */
	@Override
	public HashMap<String, Object> buyView(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("info_seq", req.getParameter("info_seq"));
		paramMap.put("order_seq", req.getParameter("order_seq"));
		paramMap.put("order_no", req.getParameter("order_no"));
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		HashMap<String, Object> info = buyManageDao.getShopOrderInfoOne(paramMap);
		AES256SecureUtil aes = new AES256SecureUtil();
		info.put("ITEM_SELLER_HP", aes.aesDecode(String.valueOf(info.get("ITEM_SELLER_HP"))));
		info.put("RECV_HP", aes.aesDecode(String.valueOf(info.get("RECV_HP"))));
		info.put("RECV_MESSAGE", StringTool.getLineCharacterReplace((String)info.get("RECV_MESSAGE")));
		resultMap.put("info", info);
		
		resultMap.put("option", buyManageDao.getOrderInfoOption(paramMap));
		
		HashMap<String, Object> backExchange = buyManageDao.getShopItemBackExchange(paramMap);
		if(!StringUtils.isEmpty(backExchange) && !StringUtils.isEmpty(backExchange.get("BE_CONTENT"))) {
			backExchange.put("BE_CONTENT", StringTool.getLineCharacterReplace((String)backExchange.get("BE_CONTENT")));
		}
		if(!StringUtils.isEmpty(backExchange) && !StringUtils.isEmpty(backExchange.get("BE_ANSWER"))) {
			backExchange.put("BE_ANSWER", StringTool.getLineCharacterReplace((String)backExchange.get("BE_ANSWER")));
		}
		resultMap.put("backExchange", backExchange);
		resultMap.put("order_seq", req.getParameter("order_seq"));
		resultMap.put("order_no", req.getParameter("order_no"));
		resultMap.put("order_state", StringUtils.isEmpty(info.get("ORDER_STATE"))?"":info.get("ORDER_STATE"));
		
		return resultMap;
	}
	
	/**
	 * 주문내역 한건에 대한 옵션 조회
	 */
	@Override
	public HashMap<String, Object> getOrderInfoOption(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(req.getParameter("order_no"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			
			return resultMap;
		}
		
		paramMap.put("order_no", req.getParameter("order_no"));
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("optionList", buyManageDao.getOrderInfoOption(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 상품문의관리 화면 데이터 조회
	 */
	@Override
	public HashMap<String, Object> itemQaList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("search_word"))) {
			paramMap.put("search_word", req.getParameter("search_word"));
			resultMap.put("search_word", req.getParameter("search_word"));
		}
		if(!StringUtils.isEmpty(req.getParameter("search_type"))) {
			paramMap.put("search_type", req.getParameter("search_type"));
			resultMap.put("search_type", req.getParameter("search_type"));
		}
		if(!StringUtils.isEmpty(req.getParameter("is_answer"))) {
			paramMap.put("is_answer", req.getParameter("is_answer"));
			resultMap.put("is_answer", req.getParameter("is_answer"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
			resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		resultMap.put("quick", req.getParameter("quick"));
		
		int total = buyManageDao.getItemQaListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("qaList", buyManageDao.getItemQaList(paramMap));
		resultMap.put("paging", paging.getScript("schFrm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	/**
	 * 상품문의 질문(답변) 목록 조회
	 */
	@Override
	public HashMap<String, Object> getShopItemQaContentList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("iqa_seq", req.getParameter("iqa_seq"));
		
		ArrayList<HashMap<String, Object>> data = buyManageDao.getShopItemQaContentList(paramMap);
		if(data != null) {
			for(int i=0; i<data.size(); i++) {
				data.get(i).put("CONTENT", StringTool.getLineCharacterReplace((String)data.get(i).get("CONTENT")));
			}
		}
		resultMap.put("contentList", data);
		
		return resultMap;
	}
	
	/**
	 * 반품/교환요청 등록화면 필요 데이터 조회
	 */
	@Override
	public HashMap<String, Object> itemBackExchangeWrite(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("order_seq", req.getParameter("order_seq"));
		paramMap.put("order_no", req.getParameter("order_no"));
		
		resultMap.put("info", buyManageDao.getShopOrderInfoOne(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 주문취소 프로세스
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> cancelOrder(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		//필수값 체크
		if(StringUtils.isEmpty(req.getParameter("info_seq")) || StringUtils.isEmpty(req.getParameter("order_seq")) ||
				StringUtils.isEmpty(req.getParameter("order_no"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			return resultMap;
		}
		
		paramMap.put("info_seq", req.getParameter("info_seq"));
		paramMap.put("order_seq", req.getParameter("order_seq"));
		paramMap.put("order_no", req.getParameter("order_no"));
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		//현재 주문상태 조회
		HashMap<String, Object> currOrderInfo = buyManageDao.getShopOrderInfoOne(paramMap);
		
		if(currOrderInfo == null) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			return resultMap;
		}
		
		//현재주문상태값이 결제대기취소 또는 결제취소 상태일경우 중복처리 확인
		if(currOrderInfo.get("ORDER_STATE").equals("6") || currOrderInfo.get("ORDER_STATE").equals("7")) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "이미 주문이 취소되었습니다.");
			return resultMap;
		}
		
		//변경할 취소상태값 설정
		if(currOrderInfo.get("ORDER_STATE").equals("1")) {
			paramMap.put("order_state", "6");	//6:결제대기취소
		}else {
			paramMap.put("order_state", "7");	//7:결제취소
		}
		
		//결제대기취소(또는 결제취소) 상태값으로 변경
		buyManageDao.updateShopOrderInfoState(paramMap);
		
		//취소시 결제금액 반환처리(e-money)
		if(currOrderInfo.get("PAY_TYPE").equals("1") || currOrderInfo.get("PAY_TYPE").equals("2")) {
			int cashAmount = Integer.parseInt(currOrderInfo.get("ORDER_PRICE").toString()) + Integer.parseInt(currOrderInfo.get("DELIVERY_CHARGE").toString());
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			paramMap.put("cash_amount", cashAmount);
			paramMap.put("cl_type", currOrderInfo.get("PAY_TYPE").equals("1")?"7":"8");
			paramMap.put("order_seq", req.getParameter("order_seq"));
			itemDao.insertCashLogProcedure(paramMap);
		}
		
		//주문정보 로그등록
		buyManageDao.insertShopOrderInfoLog(paramMap);
		
		//상품판매수차감
		//item_seq와 order_no필요
		paramMap.put("item_seq", currOrderInfo.get("ITEM_SEQ"));
		buyManageDao.updateShopItemSellCnt(paramMap);
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("message", "요청이 등록되었습니다.");
		
		return resultMap;
	}
	
	/**
	 * 반품/교환요청 등록
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> insertItemBackExchange(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("order_seq")) || StringUtils.isEmpty(req.getParameter("order_no"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			return resultMap;
		}
		if(StringUtils.isEmpty(req.getParameter("be_subject"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "요청제목을 입력해 주세요.");
			return resultMap;
		}
		if(StringUtils.isEmpty(req.getParameter("be_content"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "요청내용을 입력해 주세요.");
			return resultMap;
		}
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		paramMap.put("info_seq", req.getParameter("info_seq"));
		paramMap.put("order_seq", req.getParameter("order_seq"));
		paramMap.put("order_no", req.getParameter("order_no"));
		paramMap.put("be_type", req.getParameter("be_type"));
		paramMap.put("be_subject", req.getParameter("be_subject"));
		paramMap.put("be_content", req.getParameter("be_content"));
		
		HashMap<String, Object> fileMap = FileUploadUtil.fileUpload(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),req, "product/back_exchange");
		
		//첨부파일 추가
		Iterator<String> iterator = fileMap.keySet().iterator();
		while (iterator.hasNext()) {
			String key = (String) iterator.next();
			paramMap.put(key, fileMap.get(key));
		}
		
		//현재 주문상태 조회
		HashMap<String, Object> currOrderInfo = buyManageDao.getShopOrderInfoOne(paramMap);
		
		//현재 주문상태가 반품/교환신청 상태인 경우 리턴
		if(currOrderInfo.get("ORDER_STATE").equals("9") || currOrderInfo.get("ORDER_STATE").equals("10")) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "이미 반품/교환신청 되었습니다.");
			return resultMap;
		}
		
		//반품/교환 요청 등록
		buyManageDao.insertItemBackExchange(paramMap);
		
		//주문상태변경(반품요청으로 변경)
		if(req.getParameter("be_type").equals("1")) {
			paramMap.put("order_state", "9");
		}else {
			paramMap.put("order_state", "10");
		}
		buyManageDao.updateShopOrderInfoState(paramMap);
		
		//주문정보 로그등록
		buyManageDao.insertShopOrderInfoLog(paramMap);
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("message", "요청이 등록되었습니다.");
		
		return resultMap;
	}
	
	/**
	 * 반품/교환요청 취소 프로세스
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> cancelBackExchange(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(req.getParameter("info_seq")) || StringUtils.isEmpty(req.getParameter("order_seq")) ||
				StringUtils.isEmpty(req.getParameter("order_no"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			return resultMap;
		}
		
		paramMap.put("info_seq", req.getParameter("info_seq"));
		paramMap.put("order_seq", req.getParameter("order_seq"));
		paramMap.put("order_no", req.getParameter("order_no"));
		
		//현재 주문상태 조회
		HashMap<String, Object> currOrderInfo = buyManageDao.getShopOrderInfoOne(paramMap);
		//이전 주문상태 조회(로그의 최근 두번째)
		HashMap<String, Object> prevOrderInfo = buyManageDao.getShopOrderInfoLogOne(paramMap);
		
		if(currOrderInfo == null || prevOrderInfo == null) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			return resultMap;
		}
		
		//이전 주문상태값으로 업데이트
		paramMap.put("order_state", prevOrderInfo.get("ORDER_STATE"));
		buyManageDao.updateShopOrderInfoState(paramMap);
		
		//주문정보 로그등록
		buyManageDao.insertShopOrderInfoLog(paramMap);
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("message", "요청이 등록되었습니다.");
		
		return resultMap;
	}
	
	/**
	 * 관심상품목록 필요 데이터 조회
	 */
	@Override
	public HashMap<String, Object> interestItemList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		if(!StringUtils.isEmpty(req.getParameter("item_seq"))) {
			paramMap.put("item_seq", req.getParameter("item_seq"));
			resultMap.put("item_seq", req.getParameter("item_seq"));
		}
		if(!StringUtils.isEmpty(req.getParameter("seller_id"))) {
			paramMap.put("seller_id", req.getParameter("seller_id"));
			resultMap.put("seller_id", req.getParameter("seller_id"));
		}
		
		int total = itemDao.getMyItemListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("myItemList", itemDao.getMyItemList(paramMap));
		resultMap.put("paging", paging.getScript("schFrm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	/**
	 * 관심상품 삭제하기(한건삭제, 모두삭제)
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> deleteInterestItem(HttpServletRequest req) throws Exception {
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		int interestItemListSize = 0;
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		
		if(!StringUtils.isEmpty(req.getParameter("interestItemList"))){
			Gson gson = new Gson();
			ArrayList<Long> interestItemList = gson.fromJson(req.getParameter("interestItemList"), new TypeToken<ArrayList<Long>>(){}.getType());
			interestItemListSize = interestItemList.size();
			paramMap.put("interestItemList", interestItemList);
		}else{
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "선택된 상품이 없습니다.");//선택된 쪽지 없음
			return resultMap;
		}
		
		int result = buyManageDao.deleteMyItem(paramMap);
		//모두 변경 완료.
		if(result == interestItemListSize) {
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			return resultMap;
		}else {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();	//강제롤백구문
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "관심상품 삭제에 실패하였습니다.");//부분 실패
			return resultMap;
		}
	}
}
