package com.rainbow.shop.test.controller;

import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.rainbow.shop.test.service.TestServiceImpl;
import com.rainbow.shop.test.vo.TestVo;

@Controller
public class TestController {

	private static final Logger logger = LoggerFactory.getLogger(TestController.class);
	
	
	@Autowired
	TestServiceImpl service;
	@RequestMapping(value = "/testShop.do", method = RequestMethod.GET)
	public String test(Locale locale, Model model) throws Exception{
		return "home";
	}
	
	@RequestMapping(value = "/testSelect.do", method = RequestMethod.GET)
	public String test2(Locale locale, Model model) throws Exception{
		
		String result = service.testSelect();
		System.out.println(result);
		model.addAttribute("result", result);
		return "home";
	}
	@RequestMapping(value = "/testUpdate.do", method = RequestMethod.POST)
	public String test3(Locale locale, Model model,HttpServletRequest req) throws Exception{
		service.testUpdate(req.getParameter("textData"));
		String result = service.testSelect();
		model.addAttribute("result", result);
		return "home";
	}
	
	@RequestMapping(value = "/testUpdateAjax.do", method = RequestMethod.POST)
	@ResponseBody
	public HashMap<String,Object> test4(Locale locale, Model model,HttpServletRequest req) throws Exception{
		service.testUpdate(req.getParameter("textData"));
		HashMap<String,Object> resultMap =  new HashMap<String,Object>();
		String result = service.testSelect();
		resultMap.put("result", result);
		System.out.println(resultMap.toString());
		return resultMap;
	}
	
	@RequestMapping(value = "/testValid.do", method = RequestMethod.POST)
	public String test5(Locale locale, Model model,@ModelAttribute("testVo") @Valid TestVo testVo, BindingResult result) throws Exception{
		
		if(result.hasErrors()){
			System.out.println("error");
			return "home";
		}

		System.out.println(result);
		System.out.println(testVo.toString());
		return "home";
	}
}
