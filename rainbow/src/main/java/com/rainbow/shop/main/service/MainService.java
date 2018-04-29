package com.rainbow.shop.main.service;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface MainService {
	public ArrayList<HashMap<String, Object>> getCategoryList() throws Exception;
	public HashMap<String,Object>getQuestionAndAnswerList(HttpServletRequest req)throws Exception;
	public HashMap<String,Object> getSearchTextRankList() throws Exception;
	public HashMap<String,Object> mainView(HttpServletRequest req) throws Exception;
}
