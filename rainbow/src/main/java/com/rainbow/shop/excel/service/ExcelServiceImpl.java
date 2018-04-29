package com.rainbow.shop.excel.service;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.rainbow.shop.excel.dao.ExcelDao;
import com.rainbow.util.StringTool;

@Service
public class ExcelServiceImpl implements ExcelService{

	@Autowired
	ExcelDao excelDao;

	@SuppressWarnings("unchecked")
	@Override
	public void download(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		StringTool.requestConsoleViewer(req);
		String orderName,searchInfoObject,headerInfoObjectList,saveFileName = null;
		if(StringUtils.isEmpty(req.getParameter("orderName")) || StringUtils.isEmpty(req.getParameter("searchInfoObject")) || StringUtils.isEmpty(req.getParameter("headerInfoObjectList")) || StringUtils.isEmpty(req.getParameter("saveFileName"))) {
			throw new Exception();
		}
		orderName = req.getParameter("orderName");
		searchInfoObject = req.getParameter("searchInfoObject");
		headerInfoObjectList = req.getParameter("headerInfoObjectList");
		saveFileName = req.getParameter("saveFileName");
		HashMap<String,Object> member = StringTool.getSessionMap(req);
		HashMap<String,Object> paramMap = new HashMap<String,Object>();
		Gson gson = new Gson();
		
		HashMap<String,Object> searchInfoObjectMap = gson.fromJson(searchInfoObject, new TypeToken<HashMap<String,Object>>(){}.getType());
		
		//page 와 페이지 사이즈는 필요가 없기때문에 제거
		for ( String key : searchInfoObjectMap.keySet() ) {
			if(!key.equals("page") && !key.equals("pageSize")) {
				paramMap.put(key, searchInfoObjectMap.get(key));
			}
		}
		
		paramMap.put("mb_seq", member.get("MB_SEQ"));
		ArrayList<HashMap<String,Object>> excelDataList = null;
		Method[] methodList = excelDao.getClass().getMethods();
		
		for(Method m : methodList) {
			endPoint : if(m.getName().equals(orderName)) {
				excelDataList = (ArrayList<HashMap<String, Object>>) m.invoke(excelDao, paramMap);
				break endPoint;
			}
		}
		//쿼리 실행 결과
		if(!StringUtils.isEmpty(excelDataList)) {
			
			ArrayList<HashMap<String,String>> headerInfoHashMapList = gson.fromJson(headerInfoObjectList, new TypeToken<ArrayList<HashMap<String,String>>>(){}.getType());
	    	// 워크북 생성
			
			if(!StringUtils.isEmpty(headerInfoHashMapList)) {
				
				HashMap<String,String> keyCompareMap = new HashMap<String,String>();
				//셀넓이 자동 조절용 인데 현재 개발 안됨.
				//HashMap<String,Integer> sizeCompareMap = new HashMap<String,Integer>();
				@SuppressWarnings("resource")
				SXSSFWorkbook wb = new SXSSFWorkbook();
			    SXSSFSheet sheet = wb.createSheet(saveFileName);
			    
				Row row = null;
				Cell cell = null;
				int rowNo = 0;
				// 테이블 헤더용 스타일
				CellStyle headStyle = wb.createCellStyle();
				// 가는 경계선을 가집니다.
				headStyle.setBorderTop(BorderStyle.THIN);
				headStyle.setBorderBottom(BorderStyle.THIN);
				headStyle.setBorderLeft(BorderStyle.THIN);
				headStyle.setBorderRight(BorderStyle.THIN);
				// 데이터는 가운데 정렬합니다.
				headStyle.setAlignment(HorizontalAlignment.CENTER);
				
				// 헤더 생성
				row = sheet.createRow(rowNo++);
				for(HashMap<String, String> headerMap :  headerInfoHashMapList) {

					cell = row.createCell(Integer.parseInt(headerMap.get("index")));
					cell.setCellStyle(headStyle);
					cell.setCellValue(headerMap.get("valueParam"));
					keyCompareMap.put(headerMap.get("keyParam"), headerMap.get("index"));
				}
				
				// 기본 셀 넓이 지정
				for (int x = 0; x < sheet.getRow(0).getPhysicalNumberOfCells(); x++) {
		            sheet.setColumnWidth(x, 20*256);
		            //셀넓이 자동 조절용 인데 현재 개발 안됨.
		            //sizeCompareMap.put(String.valueOf(x), 20*256);
		        }
				
				// 데이터용 경계 스타일 테두리만 지정
				CellStyle bodyStyle = wb.createCellStyle();
				bodyStyle.setBorderTop(BorderStyle.THIN);
				bodyStyle.setBorderBottom(BorderStyle.THIN);
				bodyStyle.setBorderLeft(BorderStyle.THIN);
				bodyStyle.setBorderRight(BorderStyle.THIN);
				bodyStyle.setAlignment(HorizontalAlignment.CENTER);
				//화면에 뿌려질 데이터
				for(int i = 0; i < excelDataList.size(); i++) {
					row = sheet.createRow(rowNo++);
					
					HashMap<String,Object> dataMap = excelDataList.get(i);
					Set<String> set = dataMap.keySet();
					Iterator<String> iterator = set.iterator();
					while(iterator.hasNext()){
						String key = iterator.next();
						if(!StringUtils.isEmpty(keyCompareMap.get(key))) {
							cell = row.createCell(Integer.parseInt(keyCompareMap.get(key)));
							cell.setCellStyle(bodyStyle);
							cell.setCellValue(dataMap.get(key).toString() == null? "" : dataMap.get(key).toString());
							//셀넓이 자동 조절용 인데 현재 개발 안됨.
							//int valueLength = dataMap.get(key).toString().length();
						}
					}
				}
				// 컨텐츠 타입과 파일명 지정
				res.setHeader("Set-Cookie", "fileDownload=true; path=/");
				res.setHeader("Content-Disposition", String.format("attachment; filename=\""+new String((saveFileName).getBytes("KSC5601"),"8859_1")+".xlsx\""));
				wb.write(res.getOutputStream());
				wb.dispose();
				
			}
			
		}
	}
}
