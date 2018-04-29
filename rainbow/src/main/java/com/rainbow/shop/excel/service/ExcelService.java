package com.rainbow.shop.excel.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ExcelService {
	public void download(HttpServletRequest req,HttpServletResponse res) throws Exception;
}
