package com.rainbow.shop.test.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.rainbow.shop.test.dao.TestDao;
import com.rainbow.shop.test.vo.TestVo;

@Service
public class TestServiceImpl implements TestService{
	
	@Autowired
	private TestDao testDao;
	
	
	@Override
	public String test() throws Exception {
		return testDao.test();
	}
	@Transactional(
			propagation=Propagation.REQUIRED)
	@Override
	public void testInsert() throws Exception {
		// TODO Auto-generated method stub
		testDao.testInsert();
	}

	@Override
	public String testSelect() throws Exception {
		// TODO Auto-generated method stub
		return testDao.testSelect();
	}

	@Override
	public void testUpdate(String str) throws Exception {
		// TODO Auto-generated method stub
		testDao.testUpdate(str);
	}
	
	
	@Override
	public void testValid(TestVo testVo) throws Exception {
		// TODO Auto-generated method stub
	}
}
