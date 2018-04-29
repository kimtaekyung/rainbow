package com.rainbow.shop.excel.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public interface ExcelDao {
	public ArrayList<HashMap<String,Object>> getEmoneyUseList(HashMap<String,Object> paramMap)throws SQLException;
}
