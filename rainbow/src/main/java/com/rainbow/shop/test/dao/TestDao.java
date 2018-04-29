package com.rainbow.shop.test.dao;

import java.sql.SQLException;

import com.rainbow.shop.test.vo.TestVo;

public interface TestDao {
	public String test() throws SQLException;
	public void testInsert() throws SQLException;
	public String testSelect() throws SQLException;
	public void testUpdate(String str) throws SQLException;
	public void testValid(TestVo testVo) throws SQLException;
}
