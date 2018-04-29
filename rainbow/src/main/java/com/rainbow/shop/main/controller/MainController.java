package com.rainbow.shop.main.controller;

import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rainbow.constant.Constant;
import com.rainbow.shop.main.service.MainServiceImpl;

@Controller
public class MainController {
	@Autowired
	private MainServiceImpl mainService;
	
	/**
	 * 메인 페이지 이동 요청
	 * @param locale
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String goMain(HttpServletRequest req, Model model) throws Exception{
		
		model.addAttribute("resultMap",mainService.mainView(req));
		return "/main/main";
	}
	
	/**
	 * 메뉴 카테고리 리스트 가져오기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/categoryListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> categoryListAjax() throws Exception{
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("resultData", mainService.getCategoryList());
		
		return resultMap;
	}
	
	/**
	 * Q&A 페이지로 이동
	 * @param req
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/main/questionAndAnswerList.do", method = RequestMethod.GET)
	public String questionAndAnswerList(HttpServletRequest req, Model model) throws Exception{
		model.addAttribute("resultMap",mainService.getQuestionAndAnswerList(req));
		return "/main/questionAndAnswerList";
	}
	/**
	 * 검색어 랭킹 리스트 가져오기
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/main/getSearchTextRankListAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String, Object> getSearchTextRankList(HttpServletRequest req) throws Exception{
		return mainService.getSearchTextRankList();
	}
	
}
