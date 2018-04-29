package com.rainbow.shop.excel.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rainbow.shop.excel.service.ExcelServiceImpl;

@Controller
public class ExcelController {

	@Autowired
	ExcelServiceImpl excelService;
	
	/**
	 * 엑셀 다운로드
	 * @param req
	 * @param res
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel/download.do")
	public void download(HttpServletRequest req , HttpServletResponse res) throws Exception {
		excelService.download(req,res);
	}
}
