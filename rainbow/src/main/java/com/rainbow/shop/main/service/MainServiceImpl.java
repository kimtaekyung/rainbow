package com.rainbow.shop.main.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.rainbow.constant.Constant;
import com.rainbow.shop.main.dao.MainDao;

@Service
public class MainServiceImpl implements MainService {
	
	@Autowired
	private MainDao mainDao;
	
	
	/**
	 * 카테고리 목록 조회
	 */
	@Override
	public ArrayList<HashMap<String, Object>> getCategoryList() throws Exception {
		return mainDao.getCategoryList();
	}
	
	/**
	 * 메인화면 데이터 조회
	 */
	@Override
	public HashMap<String, Object> mainView(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		
		resultMap.put("advertiseList", mainDao.getAdvertiseList(paramMap));
		resultMap.put("newItemList", mainDao.getNewItemList(paramMap));
		resultMap.put("popularItemList", mainDao.getPopularItemList(paramMap));
		resultMap.put("specialPriceItemList", mainDao.getSpecialPriceItemList(paramMap));
		
		return resultMap;
	}

	
	/**
	 * Q&A 리스트 가져오기
	 */
	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String, Object> getQuestionAndAnswerList(HttpServletRequest req) throws Exception {
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		// TODO Auto-generated method stub
		
		if(!StringUtils.isEmpty(req.getParameter("rqt_seq"))) {
			if(Constant.getRegexMatchResultOfString(req.getParameter("rqt_seq"), Constant.ONE_NUMBER_REGULAR_EXPRESSTION)) {
				paramMap.put("rqt_seq", req.getParameter("rqt_seq"));
				resultMap.put("rqt_seq", req.getParameter("rqt_seq"));
			}else {
				resultMap.put("rqt_seq", "");
			}
		}else {
			resultMap.put("rqt_seq", "");
		}
		
		if(!StringUtils.isEmpty(req.getParameter("search_word"))) {
			paramMap.put("search_word", req.getParameter("search_word"));
			resultMap.put("search_word", req.getParameter("search_word"));
		}
		
		
		resultMap.put("questionAndAnswerTypeList", mainDao.getQuestionAndAnswerTypeList());
		resultMap.put("questionAndAnswerList", mainDao.getQuestionAndAnswerList(paramMap));
		return resultMap;
	}


	@Override
	@Transactional(
			propagation=Propagation.REQUIRED,
			rollbackFor=Throwable.class)
	public HashMap<String,Object> getSearchTextRankList() throws Exception {
		// TODO Auto-generated method stub
		HashMap<String,Object> resultMap = new HashMap<String,Object>();
		resultMap.put("searchTextRankList", mainDao.getSearchTextRankList());
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		return resultMap;
		
	}
}
