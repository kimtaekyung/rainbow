package com.rainbow.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;
import org.springframework.util.StringUtils;

public class StringTool {

	/**
	 * 현재 날짜를 포맷형식에 맞게 반환
	 * @param format
	 * @return
	 */
	public static String getNowDate(String format){
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sd = new SimpleDateFormat(format);
		return sd.format(cal.getTime());
	}
	
	/**
	 * 현재 날짜에 num합산 후 반환
	 * @param date	계산할 날짜
	 * @param ymd	계산구분(y:년 m:월 d:일)
	 * @param num	계산할 값
	 * @return
	 */
	public static String getDateCalculate(String date, String ymd, int num){
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
	    try {
	        Date dt = df.parse(date);
	        cal.setTime(dt);
	        if(ymd.equals("y")) {
	        	cal.add(Calendar.YEAR, num);
	        }else if(ymd.equals("m")) {
	        	cal.add(Calendar.MONTH, num);
	        }else {
	        	cal.add(Calendar.DATE, num);
	        }
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    return df.format(cal.getTime());
		
	}
	
	/**
	 * 랜덤이름 생성
	 * @return
	 */
	public static String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	/**
	 * IP가져오기
	 * @param request
	 * @return
	 */
	public static String getClientIp(HttpServletRequest request){
		String clientIp = request.getHeader("X-FORWARDED-FOR");
		
		if (clientIp == null || clientIp.length() == 0 || clientIp.equalsIgnoreCase("unknown")) {
			clientIp = request.getHeader("Proxy-Client-IP");
		}
		if (clientIp == null || clientIp.length() == 0 || clientIp.equalsIgnoreCase("unknown")) {
			clientIp = request.getRemoteAddr();
		}
		return clientIp;
	}
	
	
	/**
	 * 접속 기기 정보 가져오기 1:pc, 2:mo, 3ta
	 * @param request
	 * @return
	 */
	public static char detectDevice(HttpServletRequest request) {        
        Device device = DeviceUtils.getCurrentDevice(request);        
        char deviceType = '4';
        if (device != null) {
        	if (device.isNormal()) {
                deviceType = '1';
            } else if (device.isMobile()) {
                deviceType = '2';
            } else if (device.isTablet()) {
                deviceType = '3';
            }
        }
        return deviceType;
    }
	
	/**
	 * 세션조회
	 * @param req
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public static HashMap<String, Object> getSessionMap(HttpServletRequest req) throws Exception{
		HttpSession session = req.getSession();
		return (HashMap<String, Object>)session.getAttribute("rb_member");
	}
	
	/**
	 * 요청 파라미터 확인(콘솔)
	 * @param req
	 * @throws Exception
	 */
	public static void requestConsoleViewer (HttpServletRequest req) throws Exception{
		Enumeration params = req.getParameterNames();
		System.out.println("----------------------------");
		while (params.hasMoreElements()){
		    String name = (String)params.nextElement();
		    System.out.println(name + " : " +req.getParameter(name));
		}
		System.out.println("----------------------------");
	}
	
	/**
	 * 맵 객체 확인(콘솔)
	 * @param map
	 * @throws Exception
	 */
	public static void HashMapConsoleViewer (HashMap<String,Object> map) throws Exception{
		
		if(!StringUtils.isEmpty(map)) {
			for(String key : map.keySet()){
				System.out.println(key + " : " + map.get(key));
	        }
		}else{
			System.out.println("Object is null");
		}
	}
	
	/**
	 * 줄바꿈 변경
	 * @param str
	 * @return
	 */
	public static String getLineCharacterReplace(String str){
		str = str.replace("\r\n", "<br>");
		str = str.replace("\n", "<br>");
		return str;
	}
}
