package com.rainbow.shop.test.service;

import com.rainbow.shop.test.vo.TestVo;

public interface TestService {
	public String test() throws Exception;
	public void testInsert() throws Exception;
	public String testSelect() throws Exception;
	public void testUpdate(String str) throws Exception;
	public void testValid(TestVo testVo) throws Exception;
}
