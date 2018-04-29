package com.rainbow.constant;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Pattern;
public class Constant {
	
	public static final String AJAX_RESULT_SUCCESS 				= "SUCCESS";
	public static final String AJAX_RESULT_FAIL 				= "FAIL";
	
	public static final String ID_REGULAR_EXPRESSTION 				= "^[a-zA-Z0-9_]{3,20}$";       //a~z 또는 A~Z 또는 0~9 _ 입력 가능 하고 4~20글자                  
	public static final String PW_REGULAR_EXPRESSTION				= "^.*(?=^.{8,20}$)(?=.*\\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$";                        
	public static final String NAME_REGULAR_EXPRESSTION				= "^[가-힣]{2,4}$";                                                                      
	public static final String NICKNAME_REGULAR_EXPRESSTION 		= "^[0-9a-zA-Z가-힣]{1,20}$";                                                            
	public static final String BIRTH_REGULAR_EXPRESSTION			= "^(19|20)\\d{2}(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[0-1])$";                            
	public static final String TEL_REGULAR_EXPRESSTION				= "^\\d{2,3}-\\d{3,4}-\\d{4}$";                                                           
	public static final String HP_REGULAR_EXPRESSTION				= "^01([0|1|6|7|8|9]?)-([0-9]{3,4})-([0-9]{4})$";                                    
	public static final String EMAIL_REGULAR_EXPRESSTION			= "^[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\\.]?[0-9a-zA-Z])*\\.[a-zA-Z]{2,3}$";
	public static final String BIZNAME_REGULAR_EXPRESSTION 			= "^[0-9a-zA-Z가-힣]{1,20}$";                                                            
	public static final String BIZCEONAME_REGULAR_EXPRESSTION 		= "^[가-힣]{2,4}$";                                                                      
	public static final String BIZNO_REGULAR_EXPRESSTION			= "([0-9]{3})-([0-9]{2})-([0-9]{5})";                                                
	public static final String ZIPCODE_REGULAR_EXPRESSTION			= "^[0-9]{5,6}$";                                                                      
	public static final String ADDRESS_REGULAR_EXPRESSTION			= "^[0-9a-zA-Z가-힣\\s]{1,50}$";                                                          
	public static final String ADDRESS_DETAIL_REGULAR_EXPRESSTION	= "^[0-9a-zA-Z가-힣\\s]{1,50}$";                                                          
	public static final String BIZTELNO_REGULAR_EXPRESSTION			= "^\\d{2,3}-\\d{3,4}-\\d{4}$";                                                           
	public static final String SELLCODE_REGULAR_EXPRESSTION			= "^[0-9a-zA-Z]{1,70}$";   
	public static final String SPACE_REGULAR_EXPRESSTION			= "\\s/g";
	public static final String ONE_NUMBER_REGULAR_EXPRESSTION		= "^[0-9]{1}";
	public static final String BANK_OWNER_EXPRESSTION				= "^[가-힣]{2,4}$";
	public static final String BANK_NAME_EXPRESSTION				= "^[a-zA-Z가-힣]{2,10}$";
	public static final String BANK_NO_EXPRESSTION					= "^[0-9]{5,30}";
	public static final String BIZ_TYPE_EXPRESSTION					= "^[가-힣]{1,10}$";
	public static final String BIZ_CONDITION_EXPRESSTION			= "^[가-힣]{1,10}$";
	public static final String BIZ_CATEGORY_EXPRESSTION				= "^[가-힣]{1,10}$";
	public static final String LEAVE_REASON_EXPRESSTION				= "^[0-9a-zA-Z가-힣\\s]{1,100}$";
	public static final String IP_REASON_EXPRESSTION				= "^(1|2)?\\d?\\d([.](1|2)?\\d?\\d){3}$";
	public static final String SUPPORT_TYPE_REGULAR_EXPRESSTION		= "^[0-9]{1,2}";
	public static final String EMONEY_CHARGE_AMOUNT_REGULAR_EXPRESSTION		= "^[0-9]{5,9}";
	
	
	
	public static final String NUMBER_EXPRESSION					= "^[0-9]*$";
	public static final String IMAGE_EXPRESSION						= "([^\\s]+(\\.(?i)(jpg|png|gif|jpeg))$)";

	
	public static final String PRICE_EXPRESSION					= "^\\d{1,8}$";
	public static final String DATE_EXPRESSION					= "^(19|20)\\d{2}-?(0[1-9]|1[012])-?(0[1-9]|[12][0-9]|3[0-1])$";
	public static final String ITEM_CATEGORY1_EXPRESSION		= "^C[0-9]{2}";
	public static final String ITEM_CATEGORY2_EXPRESSION		= "^C[0-9]{4}";
	
	public static ArrayList<HashMap<String,Object>> LIVE_SEARCH_RANK = new ArrayList<HashMap<String,Object>>();
	
	/**
	 * 문자열 자바스크립트 정규식 검사
	 * @param o
	 * @param regex
	 * @return
	 */
	public static boolean getRegexMatchResultOfString(Object o , String regex) {
		if(o instanceof String) {
	        if(Pattern.matches(regex, (String)o)){
	            return true;
	        }else{
	        	return false;
	        }

		}else {
			return false;
		}
	}
}
