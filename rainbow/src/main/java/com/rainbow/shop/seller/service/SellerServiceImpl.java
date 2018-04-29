package com.rainbow.shop.seller.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.rainbow.constant.Constant;
import com.rainbow.shop.buyer.dao.BuyManageDao;
import com.rainbow.shop.item.dao.ItemDao;
import com.rainbow.shop.seller.dao.SellerDao;
import com.rainbow.util.AES256SecureUtil;
import com.rainbow.util.ExcelReadOption;
import com.rainbow.util.ExcelUtil;
import com.rainbow.util.FileUploadUtil;
import com.rainbow.util.MapDeserializerDoubleAsIntFix;
import com.rainbow.util.QuerystringPageing;
import com.rainbow.util.StringTool;

@Service
public class SellerServiceImpl implements SellerService {
	
	@Autowired
	private SellerDao dao;
	
	@Autowired
	private ItemDao itemDao;
	
	@Autowired
	private BuyManageDao buyManageDao;
	
	@Resource
    private ApplicationContext applicationContext;
	
	/**
	 * 판매관리 레프트 메뉴 데이터 카운트 조회
	 */
	@Override
	public HashMap<String, Object> getSellLeftMenuDataCount(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		resultMap.put("itemGroupCount", dao.getShopItemStatusGroupCount(paramMap));
		resultMap.put("orderGroupCount", dao.getShopOrderInfoStateGroupCount(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 등록상품 상태별 카운트 조회
	 */
	@Override
	public HashMap<String, Object> getShopItemStatusGroupCount(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		return dao.getShopItemStatusGroupCount(paramMap);
	}

	/**
	 * 주문내역 상태별 카운트 조회
	 */
	@Override
	public HashMap<String, Object> getShopOrderInfoStateGroupCount(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		
		return dao.getShopOrderInfoStateGroupCount(paramMap);
	}
	
	/**
	 * 상품대량(엑셀)등록 프로세스
	 * 파일을 읽어 내용을 화면으로 리턴
	 */
	@Override
	public HashMap<String, Object> itemExcelRead(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		MultipartHttpServletRequest multipart = (MultipartHttpServletRequest) req;
		MultipartFile excelFile = multipart.getFile("excel_file");
		
		if(excelFile==null || excelFile.isEmpty()){
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "엑셀파일을 선택해주세요.");
			return resultMap;
        }
		
		//엑셀파일을 읽기 위해서 서버에 저장
		File destFile = new File(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()) + File.separator + "excel" + File.separator + excelFile.getOriginalFilename());
        try{
        	if(!destFile.exists()) {
        		destFile.mkdirs();
        	}
            excelFile.transferTo(destFile);
        }catch(Exception e){
            throw new RuntimeException(e.getMessage(),e);
        }
        
        ExcelReadOption excelReadOption = new ExcelReadOption();
        excelReadOption.setFilePath(destFile.getAbsolutePath());
        excelReadOption.setOutputColumns("B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","AA","AB","AC","AD","AE","AF");
        excelReadOption.setStartRow(5);
        
        List<Map<String, String>> excelContent = ExcelUtil.excelRead(excelReadOption);
        
        //데이터 validationCheck
        checkValidationExcelContent(excelContent);

        resultMap.put("excelData", excelContent);
        
        resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("message", "엑셀파일 읽기 성공.");
		
		return resultMap;
	}
	
	/**
	 * 엑셀에서 읽어온 데이터 유효성 검사
	 * @param excelContent
	 * @param resultMap
	 */
	public void checkValidationExcelContent(List<Map<String, String>> excelContent) {
		if(!StringUtils.isEmpty(excelContent)) {
			String errMsg = "";
			for(int i=0; i<excelContent.size(); i++) {
				errMsg = "";	//행마다 초기화
				
				//카테고리
				if(StringUtils.isEmpty(excelContent.get(i).get("B"))) {
					errMsg = "B열 : 카테고리는 필수입력입니다.<br/>";
				}else {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("B"), Constant.ITEM_CATEGORY2_EXPRESSION)){
						errMsg = errMsg + "B열 : 카테고리 형식이 유효하지 않습니다.<br/>";
					}
				}
				
				//상품제목
				if(StringUtils.isEmpty(excelContent.get(i).get("C"))) {
					errMsg = errMsg + "C열 : 상품제목은 필수입력입니다.<br/>";
				}
				
				//상품명
				if(StringUtils.isEmpty(excelContent.get(i).get("D"))) {
					errMsg = errMsg + "D열 : 상품명은 필수입력입니다.<br/>";
				}else {
					Loop : for(int j=0; j<excelContent.size(); j++) {
						if(i > 0 && i != j) {
							if(excelContent.get(i).get("D").trim().equals(excelContent.get(j).get("D").trim())) {
								errMsg = errMsg + "D열 : 다른 행에 중복된 상품명이 존재 합니다.<br/>";
								break Loop;
							}
						}
					}
				}
				
				//키워드
				if(StringUtils.isEmpty(excelContent.get(i).get("E"))) {
					errMsg = errMsg + "E열 : 키워드는 필수입력입니다.<br/>";
				}
				
				//원산지(제조국)
				if(StringUtils.isEmpty(excelContent.get(i).get("F"))) {
					errMsg = errMsg + "F열 : 원산지(제조국)은(는) 필수입력입니다.<br/>";
				}
				
				//제조사
				if(StringUtils.isEmpty(excelContent.get(i).get("G"))) {
					errMsg = errMsg + "G열 : 제조사는 필수입력입니다.<br/>";
				}
				
				//상품상세내용
				
				//메인상품이미지
				if(StringUtils.isEmpty(excelContent.get(i).get("J"))) {
					errMsg = errMsg + "J열 : 메인상품이미지는 필수입력입니다.<br/>";
				}
//				else {
//					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("J"), Constant.IMAGE_EXPRESSION)){
//						errMsg = errMsg + "J열 : 메인상품이미지는 gif,jpg,jpeg,png 형식만 입력해주세요.<br/>";
//					}
//				}
				
				//상품시중가격
				if(StringUtils.isEmpty(excelContent.get(i).get("K"))) {
					errMsg = errMsg + "K열 : 상품시중가격은 필수입력입니다.<br/>";
				}else {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("K"), Constant.PRICE_EXPRESSION)){
						errMsg = errMsg + "K열 : 상품시중가격은 숫자만 입력해주세요.<br/>";
					}
				}
				
				//상품판매가격
				if(!StringUtils.isEmpty(excelContent.get(i).get("L"))) {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("L"), Constant.PRICE_EXPRESSION)){
						errMsg = errMsg + "L열 : 상품판매가격은 숫자만 입력해주세요.<br/>";
					}
				}else {
					excelContent.get(i).put("L", "0");
				}
				
				//할인금액
				if(!StringUtils.isEmpty(excelContent.get(i).get("M"))) {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("M"), Constant.PRICE_EXPRESSION)){
						errMsg = errMsg + "M열 : 할인금액은 숫자만 입력해주세요.<br/>";
					}
				}else {
					excelContent.get(i).put("M", "0");
				}
				
				//상품금액 체크
				if(!StringUtils.isEmpty(excelContent.get(i).get("L")) && !excelContent.get(i).get("L").equals("0")) {
					if(Integer.parseInt(excelContent.get(i).get("L")) <= Integer.parseInt(excelContent.get(i).get("M"))) {
						errMsg = errMsg + "M열 : 할인금액은 판매가격보다 크거나 같을 수 없습니다.<br/>";
					}else {
						excelContent.get(i).put("last_price", String.valueOf(Integer.parseInt(excelContent.get(i).get("L")) - Integer.parseInt(excelContent.get(i).get("M"))));
					}
				}else {
					if(Integer.parseInt(excelContent.get(i).get("K")) <= Integer.parseInt(excelContent.get(i).get("M"))) {
						errMsg = errMsg + "M열 : 할인금액은 시중가격보다 크거나 같을 수 없습니다.<br/>";
					}else {
						excelContent.get(i).put("last_price", String.valueOf(Integer.parseInt(excelContent.get(i).get("K")) - Integer.parseInt(excelContent.get(i).get("M"))));
					}
				}
				
				//상품재고수량
				if(StringUtils.isEmpty(excelContent.get(i).get("N"))) {
					errMsg = errMsg + "N열 : 상품재고수량은 필수입력입니다.<br/>";
				}else {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("N"), Constant.NUMBER_EXPRESSION)){
						errMsg = errMsg + "N열 : 상품재고수량은 숫자만 입력해주세요.<br/>";
					}
				}
				
				//상품판매시작일자
				if(StringUtils.isEmpty(excelContent.get(i).get("O"))) {
					errMsg = errMsg + "O열 : 상품판매시작일자 필수입력입니다.<br/>";
				}else {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("O"), Constant.DATE_EXPRESSION)){
						errMsg = errMsg + "O열 : 상품판매시작일자가 유효하지 않습니다.<br/>";
					}
				}
				
				//상품판매종료일자
				if(StringUtils.isEmpty(excelContent.get(i).get("P"))) {
					errMsg = errMsg + "P열 : 상품판매시작일자 필수입력입니다.<br/>";
				}else {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("P"), Constant.DATE_EXPRESSION)){
						errMsg = errMsg + "P열 : 상품판매시작일자가 유효하지 않습니다.<br/>";
					}
				}
				
				//시작일자 종료일자 From_To체크
				if(!StringUtils.isEmpty(excelContent.get(i).get("O")) && !StringUtils.isEmpty(excelContent.get(i).get("P"))) {
					if(excelContent.get(i).get("O").compareTo(excelContent.get(i).get("P")) > 0) {
						errMsg = errMsg + "O열 : 판매시작일자는 판매종료일자보다 클 수 없습니다.<br/>";
					}
				}
				
				//상품태그
				if(StringUtils.isEmpty(excelContent.get(i).get("Q"))) {
					errMsg = errMsg + "Q열 : 상품태그는 필수입력입니다.<br/>";
				}
				
				//상품태그2
				if(StringUtils.isEmpty(excelContent.get(i).get("R"))) {
					errMsg = errMsg + "R열 : 상품태그2는 필수입력입니다.<br/>";
				}
				
				//배송비유형
				if(StringUtils.isEmpty(excelContent.get(i).get("S"))) {
					errMsg = errMsg + "S열 : 배송비유형은 필수입력입니다.<br/>";
				}else {
					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("S"), Constant.NUMBER_EXPRESSION)){
						errMsg = errMsg + "S열 : 배송비유형은 숫자만 입력해주세요.<br/>";
					}
				}
				
				//상품추가이미지1
//				if(!StringUtils.isEmpty(excelContent.get(i).get("AB"))) {
//					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("AB"), Constant.IMAGE_EXPRESSION)){
//						errMsg = errMsg + "AB열 : 상품추가이미지1은 gif,jpg,jpeg,png 형식만 입력해주세요.<br/>";
//					}
//				}
//				//상품추가이미지2
//				if(!StringUtils.isEmpty(excelContent.get(i).get("AC"))) {
//					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("AC"), Constant.IMAGE_EXPRESSION)){
//						errMsg = errMsg + "AC열 : 상품추가이미지2은 gif,jpg,jpeg,png 형식만 입력해주세요.<br/>";
//					}
//				}
//				//상품추가이미지3
//				if(!StringUtils.isEmpty(excelContent.get(i).get("AD"))) {
//					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("AD"), Constant.IMAGE_EXPRESSION)){
//						errMsg = errMsg + "AD열 : 상품추가이미지3은 gif,jpg,jpeg,png 형식만 입력해주세요.<br/>";
//					}
//				}
//				//상품추가이미지4
//				if(!StringUtils.isEmpty(excelContent.get(i).get("AE"))) {
//					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("AE"), Constant.IMAGE_EXPRESSION)){
//						errMsg = errMsg + "AE열 : 상품추가이미지4은 gif,jpg,jpeg,png 형식만 입력해주세요.<br/>";
//					}
//				}
//				//상품추가이미지5
//				if(!StringUtils.isEmpty(excelContent.get(i).get("AF"))) {
//					if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("AF"), Constant.IMAGE_EXPRESSION)){
//						errMsg = errMsg + "AF열 : 상품추가이미지5은 gif,jpg,jpeg,png 형식만 입력해주세요.<br/>";
//					}
//				}
				
				//필수옵션체크
				if(!StringUtils.isEmpty(excelContent.get(i).get("T"))) {
					if(!StringUtils.isEmpty(excelContent.get(i).get("U")) && !StringUtils.isEmpty(excelContent.get(i).get("V")) && !StringUtils.isEmpty(excelContent.get(i).get("W"))) {
						if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("V").replaceAll("\\|", ""), Constant.NUMBER_EXPRESSION)){
							errMsg = errMsg + "V열 : 상품필수옵션 재고수량은 숫자만 입력해주세요.<br/>";
						}
						if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("W").replaceAll("\\|", ""), Constant.NUMBER_EXPRESSION)){
							errMsg = errMsg + "W열 : 상품필수옵션 금액은 숫자만 입력해주세요.<br/>";
						}
					}else {
						errMsg = errMsg + "T~W열 : 상품필수옵션값이 유효하지 않습니다.<br/>";
					}
				}
				//추가옵션체크
				if(!StringUtils.isEmpty(excelContent.get(i).get("X"))) {
					if(!StringUtils.isEmpty(excelContent.get(i).get("Y")) && !StringUtils.isEmpty(excelContent.get(i).get("Z")) && !StringUtils.isEmpty(excelContent.get(i).get("AA"))) {
						if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("Z").replaceAll("\\|", ""), Constant.NUMBER_EXPRESSION)){
							errMsg = errMsg + "Z열 : 상품추가옵션 재고수량은 숫자만 입력해주세요.<br/>";
						}
						if(!Constant.getRegexMatchResultOfString(excelContent.get(i).get("AA").replaceAll("\\|", ""), Constant.NUMBER_EXPRESSION)){
							errMsg = errMsg + "AA열 : 상품추가옵션 금액은 숫자만 입력해주세요.<br/>";
						}
					}else {
						errMsg = errMsg + "X~AA열 : 상품추가옵션값이 유효하지 않습니다.<br/>";
					}
				}
				
				excelContent.get(i).put("errMsg", errMsg);
				
				if(StringUtils.isEmpty(errMsg)) {
					excelContent.get(i).put("state", "0");	//정상
				}else {
					excelContent.get(i).put("state", "-1");	//오류
				}
			}
		}
	}
	
	/**
	 * 엑셀로 읽어온 상품내용을 저장한다.
	 */
	@Override
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	public HashMap<String, Object> insertExcelItemList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		
		if(StringUtils.isEmpty(req.getParameter("item_list"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			return resultMap;
		}
		
		GsonBuilder gsonBuilder = new GsonBuilder();
		gsonBuilder.registerTypeAdapter(new TypeToken<HashMap<String, Object>>(){}.getType(),  new MapDeserializerDoubleAsIntFix());
		
//		Gson gson = new Gson();
		Gson gson = gsonBuilder.create();
		List<HashMap<String,Object>> itemList = gson.fromJson(req.getParameter("item_list"), new TypeToken<List<HashMap<String,Object>>>(){}.getType());
		
		if(itemList != null && itemList.size() > 0) {
			String temp = "";
			String itemContent = "";
			for(HashMap<String, Object> map : itemList) {
				List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
				temp = "";
				itemContent = "";
				
				//상품상세설명
				temp = FileUploadUtil.fileUploadUrl(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),"product/item", map.get("item_content").toString());
				itemContent = "<p style=\"text-align: center;\" align=\"center\"><img src=\""+temp+"\" style=\"max-width:100%; height:auto;\"><br style=\"clear:both;\"><br></p>";
				map.put("item_content", itemContent);
				
				//대표이미지
				map.put("item_represent_image", FileUploadUtil.fileUploadUrl(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),"product/item", map.get("item_represent_image").toString()));
				
				if(!StringUtils.isEmpty(map.get("item_img1"))) {
					map.put("item_img1", FileUploadUtil.fileUploadUrl(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),"product/item", map.get("item_img1").toString()));
				}
				if(!StringUtils.isEmpty(map.get("item_img2"))) {
					map.put("item_img2", FileUploadUtil.fileUploadUrl(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),"product/item", map.get("item_img2").toString()));
				}
				if(!StringUtils.isEmpty(map.get("item_img3"))) {
					map.put("item_img3", FileUploadUtil.fileUploadUrl(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),"product/item", map.get("item_img3").toString()));
				}
				if(!StringUtils.isEmpty(map.get("item_img4"))) {
					map.put("item_img4", FileUploadUtil.fileUploadUrl(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),"product/item", map.get("item_img4").toString()));
				}
				if(!StringUtils.isEmpty(map.get("item_img5"))) {
					map.put("item_img5", FileUploadUtil.fileUploadUrl(applicationContext.getMessage("file.upload.path", null, Locale.getDefault()),"product/item", map.get("item_img5").toString()));
				}
				
				//상품할인율 계산
				float itemCustPrice = Float.parseFloat(map.get("item_cust_price").toString());
				float itemLastPrice = Float.parseFloat(map.get("item_last_price").toString());
				int itemSaleRate = Math.round((itemCustPrice - itemLastPrice) / itemCustPrice * 100);
				map.put("item_sale_rate", itemSaleRate);
				
				//등록자
				map.put("mb_seq", memberMap.get("MB_SEQ"));
				
				//상품저장로직
				itemDao.insertItem(map);
				
				//필수옵션
				if(!StringUtils.isEmpty(map.get("select_option_list"))) {
					List<HashMap<String,Object>> opList = gson.fromJson(String.valueOf(map.get("select_option_list")), new TypeToken<List<HashMap<String,Object>>>(){}.getType());
					for(int j=0; j<opList.size(); j++) {
						opList.get(j).put("mb_seq", memberMap.get("MB_SEQ"));
						opList.get(j).put("item_seq", map.get("item_seq"));
						
						list.add(opList.get(j));
					}
				}
				//추가옵션
				if(!StringUtils.isEmpty(map.get("add_option_list"))) {
					List<HashMap<String,Object>> opList = gson.fromJson(String.valueOf(map.get("add_option_list")), new TypeToken<List<HashMap<String,Object>>>(){}.getType());
					for(int j=0; j<opList.size(); j++) {
						opList.get(j).put("mb_seq", memberMap.get("MB_SEQ"));
						opList.get(j).put("item_seq", map.get("item_seq"));
						
						list.add(opList.get(j));
					}
				}
				
				//옵션저장로직
				if(list != null && list.size() > 0) {
					itemDao.insertItemOption(list);
				}
			}
			
			resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			resultMap.put("message", "상품이 등록되었습니다.");
		}
		
		return resultMap;
	}
	
	/**
	 * 판매등록상품 목록화면 데이터 조회
	 */
	@Override
	public HashMap<String, Object> sellRegistItemList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("item_status"))) {
			paramMap.put("item_status", req.getParameter("item_status"));
			resultMap.put("item_status", req.getParameter("item_status"));
		}
		if(!StringUtils.isEmpty(req.getParameter("search_word"))) {
			paramMap.put("search_word", req.getParameter("search_word"));
			paramMap.put("search_type", req.getParameter("search_type"));
			resultMap.put("search_word", req.getParameter("search_word"));
			resultMap.put("search_type", req.getParameter("search_type"));
		}
		if(!StringUtils.isEmpty(req.getParameter("item_display"))) {
			paramMap.put("item_display", req.getParameter("item_display"));
			resultMap.put("item_display", req.getParameter("item_display"));
		}
		if(!StringUtils.isEmpty(req.getParameter("cate_code1"))) {
			paramMap.put("cate_code1", req.getParameter("cate_code1"));
			resultMap.put("cate_code1", req.getParameter("cate_code1"));
		}
		if(!StringUtils.isEmpty(req.getParameter("cate_code2"))) {
			paramMap.put("cate_code2", req.getParameter("cate_code2"));
			resultMap.put("cate_code2", req.getParameter("cate_code2"));
		}
		if(!StringUtils.isEmpty(req.getParameter("cate_code3"))) {
			paramMap.put("cate_code3", req.getParameter("cate_code3"));
			resultMap.put("cate_code3", req.getParameter("cate_code3"));
		}
		if(!StringUtils.isEmpty(req.getParameter("item_qty"))) {
			paramMap.put("item_qty", req.getParameter("item_qty"));
			resultMap.put("item_qty", req.getParameter("item_qty"));
		}
		
		int total = dao.getSellRegistItemListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("itemList", dao.getSellRegistItemList(paramMap));
		resultMap.put("paging", paging.getScript("schFrm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	/**
	 * 판매자 상품 진열여부 수정
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateShopItemDisplay(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("item_seq")) || StringUtils.isEmpty(req.getParameter("item_display"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
		}else {
			paramMap.put("item_seq", req.getParameter("item_seq"));
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			paramMap.put("item_display", req.getParameter("item_display"));
			
			int result = dao.updateShopItemDisplay(paramMap);
			if(result > 0) {
				returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
				returnMap.put("message", "변경하였습니다.");
			}else {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "변경에 실패했습니다.");
			}
		}
		
		return returnMap;
	}
	
	/**
	 * 판매자 상품 상태변경
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateShopItemStatus(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("item_seq")) || StringUtils.isEmpty(req.getParameter("item_status"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
		}else {
			paramMap.put("item_seq", req.getParameter("item_seq"));
			paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
			paramMap.put("item_status", req.getParameter("item_status"));
			
			HashMap<String, Object> itemMap = itemDao.getItem(paramMap);
			if(itemMap == null) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "잘못된 요청입니다.");
				return returnMap;
			}
			
			if(itemMap.get("ITEM_STATUS").equals(req.getParameter("item_status"))) {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "현재 상태와 동일한 상태입니다.");
				return returnMap;
			}
			
			int result = dao.updateShopItemStatus(paramMap);
			if(result > 0) {
				returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
				returnMap.put("message", "상태를 변경하였습니다.");
			}else {
				returnMap.put("result", Constant.AJAX_RESULT_FAIL);
				returnMap.put("message", "상태 변경에 실패했습니다.");
			}
		}
		
		return returnMap;
	}
	
	/**
	 * 상품판매목록화면 데이터 조회
	 */
	@Override
	public HashMap<String, Object> sellList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("item_seller_seq", memberMap.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("order_state"))) {
			paramMap.put("order_state", req.getParameter("order_state"));
			resultMap.put("order_state", req.getParameter("order_state"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
			resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("day_type"))) {
			paramMap.put("day_type", req.getParameter("day_type"));
			resultMap.put("day_type", req.getParameter("day_type"));
		}else {
			paramMap.put("day_type", "1");	//주문일기준
			resultMap.put("day_type", "1");
		}
		
		if(!StringUtils.isEmpty(req.getParameter("order_no"))) {
			paramMap.put("order_no", req.getParameter("order_no"));
			resultMap.put("order_no", req.getParameter("order_no"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("order_name"))) {
			paramMap.put("order_name", req.getParameter("order_name"));
			resultMap.put("order_name", req.getParameter("order_name"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("buyer_id"))) {
			paramMap.put("buyer_id", req.getParameter("buyer_id"));
			resultMap.put("buyer_id", req.getParameter("buyer_id"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("order_qty"))) {
			paramMap.put("order_qty", req.getParameter("order_qty"));
			resultMap.put("order_qty", req.getParameter("order_qty"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("order_price"))) {
			paramMap.put("order_price", req.getParameter("order_price"));
			resultMap.put("order_price", req.getParameter("order_price"));
		}
		resultMap.put("quick", req.getParameter("quick"));
		
		int total = dao.getSellItemListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("sellList", dao.getSellItemList(paramMap));
		resultMap.put("paging", paging.getScript("schFrm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	/**
	 * 주문상세내역 화면 데이터 조회
	 */
	@Override
	public HashMap<String, Object> sellView(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("order_seq", req.getParameter("order_seq"));
		paramMap.put("order_no", req.getParameter("order_no"));
		paramMap.put("item_seller_seq", memberMap.get("MB_SEQ"));
		
		HashMap<String, Object> info = dao.getShopOrderInfoOne(paramMap);
		info.put("RECV_MESSAGE", StringTool.getLineCharacterReplace((String)info.get("RECV_MESSAGE")));
		AES256SecureUtil aes = new AES256SecureUtil();
		info.put("RECV_HP", aes.aesDecode((String)info.get("RECV_HP")));
		resultMap.put("info", info);
		
		resultMap.put("option", dao.getOrderInfoOption(paramMap));
		
		HashMap<String, Object> backExchange = dao.getShopItemBackExchange(paramMap);
		if(!StringUtils.isEmpty(backExchange) && !StringUtils.isEmpty(backExchange.get("BE_CONTENT"))) {
			backExchange.put("BE_CONTENT", StringTool.getLineCharacterReplace((String)backExchange.get("BE_CONTENT")));
		}
		if(!StringUtils.isEmpty(backExchange) && !StringUtils.isEmpty(backExchange.get("BE_ANSWER"))) {
			backExchange.put("BE_ANSWER", StringTool.getLineCharacterReplace((String)backExchange.get("BE_ANSWER")));
		}
		resultMap.put("backExchange", backExchange);
		resultMap.put("order_seq", req.getParameter("order_seq"));
		resultMap.put("order_no", req.getParameter("order_no"));
		resultMap.put("order_state", StringUtils.isEmpty(info.get("ORDER_STATE"))?"":info.get("ORDER_STATE"));
		
		return resultMap;
	}
	
	/**
	 * 주문내역 한건에 대한 옵션 조회
	 */
	@Override
	public HashMap<String, Object> getOrderInfoOption(HttpServletRequest req) throws Exception {
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("order_no"))) {
			resultMap.put("result", Constant.AJAX_RESULT_FAIL);
			resultMap.put("message", "잘못된 요청입니다.");
			
			return resultMap;
		}
		
		paramMap.put("order_no", req.getParameter("order_no"));
		paramMap.put("item_seller_seq", memberMap.get("MB_SEQ"));
		
		resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		resultMap.put("optionList", dao.getOrderInfoOption(paramMap));
		
		return resultMap;
	}
	
	/**
	 * 상품문의관리 화면 데이터 조회
	 */
	@Override
	public HashMap<String, Object> itemQaList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		paramMap.put("mb_seq", memberMap.get("MB_SEQ"));
		if(!StringUtils.isEmpty(req.getParameter("search_word"))) {
			paramMap.put("search_word", req.getParameter("search_word"));
			resultMap.put("search_word", req.getParameter("search_word"));
		}
		if(!StringUtils.isEmpty(req.getParameter("search_type"))) {
			paramMap.put("search_type", req.getParameter("search_type"));
			resultMap.put("search_type", req.getParameter("search_type"));
		}
		if(!StringUtils.isEmpty(req.getParameter("is_answer"))) {
			paramMap.put("is_answer", req.getParameter("is_answer"));
			resultMap.put("is_answer", req.getParameter("is_answer"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_sdate"))) {
			paramMap.put("sch_sdate", req.getParameter("sch_sdate"));
			resultMap.put("sch_sdate", req.getParameter("sch_sdate"));
		}else {
			paramMap.put("sch_sdate", StringTool.getDateCalculate(StringTool.getDateCalculate(StringTool.getNowDate("yyyy-MM-dd"), "m", -1), "d", 1));
			resultMap.put("sch_sdate", paramMap.get("sch_sdate"));
		}
		
		if(!StringUtils.isEmpty(req.getParameter("sch_edate"))) {
			paramMap.put("sch_edate", req.getParameter("sch_edate"));
			resultMap.put("sch_edate", req.getParameter("sch_edate"));
		}else {
			paramMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
			resultMap.put("sch_edate", StringTool.getNowDate("yyyy-MM-dd"));
		}
		resultMap.put("quick", req.getParameter("quick"));
		
		int total = dao.getItemQaListCount(paramMap);
		String page = !StringUtils.isEmpty(req.getParameter("page")) ? req.getParameter("page") : "1";
		String pageSize = !StringUtils.isEmpty(req.getParameter("pageSize")) ? req.getParameter("pageSize") : "10";
		QuerystringPageing paging = new QuerystringPageing(total, Integer.parseInt(page), Integer.parseInt(pageSize));
		paramMap.put("page", (int) paging.getLimit().get("start"));
		paramMap.put("pageSize", (int) paging.getLimit().get("end"));
		resultMap.put("qaList", dao.getItemQaList(paramMap));
		resultMap.put("paging", paging.getScript("schFrm"));
		resultMap.put("page", page);
		resultMap.put("pageSize", pageSize);
		resultMap.put("total", total);
		
		return resultMap;
	}
	
	/**
	 * 상품문의 질문(답변) 목록 조회
	 */
	@Override
	public HashMap<String, Object> getShopItemQaContentList(HttpServletRequest req) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("iqa_seq", req.getParameter("iqa_seq"));
		
		ArrayList<HashMap<String, Object>> data = dao.getShopItemQaContentList(paramMap);
		if(data != null) {
			for(int i=0; i<data.size(); i++) {
				data.get(i).put("CONTENT", StringTool.getLineCharacterReplace((String)data.get(i).get("CONTENT")));
			}
		}
		resultMap.put("contentList", data);
		
		return resultMap;
	}
	
	/**
	 * 반품/교환요청 답변등록
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateShopItemBackExchangeAnswer(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("be_seq"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
		}else {
			paramMap.put("be_seq", req.getParameter("be_seq"));
			paramMap.put("be_answer", req.getParameter("be_answer"));
			paramMap.put("be_answer_mb_seq", memberMap.get("MB_SEQ"));
			
			dao.updateShopItemBackExchangeAnswer(paramMap);
			
			//주문상태변경
			//상태값이 없으면 요청반려 --> 상태값 구매완료로 변경
			if(!req.getParameter("order_state").equals(req.getParameter("curr_order_state"))) {
				paramMap.put("info_seq", req.getParameter("info_seq"));
				paramMap.put("order_seq", req.getParameter("order_seq"));
				paramMap.put("order_no", req.getParameter("order_no"));
				paramMap.put("order_state", StringUtils.isEmpty(req.getParameter("order_state")) ? "5":req.getParameter("order_state"));
				dao.updateShopOrderState(paramMap);
				
				//주문상태변경 로그등록
				paramMap.put("curr_order_state", req.getParameter("curr_order_state"));
				dao.insertShopOrderInfoLog(paramMap);
			}
				
			returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
			returnMap.put("message", "등록하였습니다.");
		}
		
		return returnMap;
	}
	
	/**
	 * 주문상태 변경
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateShopOrderState(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		
		if(StringUtils.isEmpty(req.getParameter("info_seq"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
			return returnMap;
		}
		if(StringUtils.isEmpty(req.getParameter("order_state"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "변경할 상태를 선택해 주세요.");
			return returnMap;
		}
		if(!Constant.getRegexMatchResultOfString(req.getParameter("order_state"), Constant.NUMBER_EXPRESSION)) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "변경할 상태값이 올바르지 않습니다.");
			return returnMap;
		}
		
		paramMap.put("info_seq", req.getParameter("info_seq"));
		paramMap.put("order_state", req.getParameter("order_state"));
		paramMap.put("order_seq", req.getParameter("order_seq"));
		paramMap.put("order_no", req.getParameter("order_no"));
		
		//현재 주문상태 조회
		HashMap<String, Object> currOrderInfo = dao.getShopOrderInfoOne(paramMap);
		
		if(currOrderInfo == null) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
			return returnMap;
		}
		
		//현재주문상태값이 변경하려는 상태일경우 중복처리 확인
		if(currOrderInfo.get("ORDER_STATE").equals(req.getParameter("order_state"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "변경하려는 상태로 이미 변경되어 있습니다.");
			return returnMap;
		}
		
		//변경할 상태로 업데이트
		dao.updateShopOrderState(paramMap);
		
		//주문정보 로그등록
		dao.insertShopOrderInfoLog(paramMap);
		
		//상태가 판매취소 또는 반품완료일경우 결제금액 반환처리
		//결제타입이 (e-money)인 경우에만
		if(req.getParameter("order_state").equals("8") || req.getParameter("order_state").equals("13")) {
			if(currOrderInfo.get("PAY_TYPE").equals("1") || currOrderInfo.get("PAY_TYPE").equals("2")) {
				int cashAmount = Integer.parseInt(currOrderInfo.get("ORDER_PRICE").toString()) + Integer.parseInt(currOrderInfo.get("DELIVERY_CHARGE").toString());
				paramMap.put("mb_seq", currOrderInfo.get("MB_SEQ"));
				paramMap.put("cash_amount", cashAmount);
				paramMap.put("cl_type", currOrderInfo.get("PAY_TYPE").equals("1")?"7":"8");
				paramMap.put("order_seq", req.getParameter("order_seq"));
				itemDao.insertCashLogProcedure(paramMap);
			}
			
			//상품판매수차감
			//item_seq와 order_no필요
			paramMap.put("item_seq", currOrderInfo.get("ITEM_SEQ"));
			buyManageDao.updateShopItemSellCnt(paramMap);
		}
		
		returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		returnMap.put("message", "변경하였습니다.");
		
		
		return returnMap;
	}
	
	/**
	 * 배송정보 저장
	 */
	@Transactional(propagation=Propagation.REQUIRED, rollbackFor=Throwable.class)
	@Override
	public HashMap<String, Object> updateDeliveryInfo(HttpServletRequest req) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> memberMap = StringTool.getSessionMap(req);
		
		if(StringUtils.isEmpty(req.getParameter("info_seq")) || StringUtils.isEmpty(req.getParameter("delivery_company")) || StringUtils.isEmpty(req.getParameter("delivery_no"))) {
			returnMap.put("result", Constant.AJAX_RESULT_FAIL);
			returnMap.put("message", "잘못된 요청입니다.");
			return returnMap;
		}
		
		paramMap.put("info_seq", req.getParameter("info_seq"));
		paramMap.put("delivery_company", req.getParameter("delivery_company"));
		paramMap.put("delivery_no", req.getParameter("delivery_no"));
		
		dao.updateDeliveryInfo(paramMap);
		
		returnMap.put("result", Constant.AJAX_RESULT_SUCCESS);
		returnMap.put("message", "저장하였습니다.");
		
		return returnMap;
	}
}
