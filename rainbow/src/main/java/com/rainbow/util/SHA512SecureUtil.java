package com.rainbow.util;

import java.security.MessageDigest;

public class SHA512SecureUtil {
	
	/**
	 * 전달받은 문자열을 salt 사용 하여 sha512 로 암호화하여 리턴한다. 
	 * @param str
	 * @param salt
	 * @return
	 * @throws Exception
	 */
	public static String incryptSha512(String str, String salt) throws Exception {
		String encStr = null;
		MessageDigest md = MessageDigest.getInstance("SHA-512");
		md.update(salt.getBytes("UTF-8"));
		byte[] bytes = md.digest(str.getBytes("UTF-8"));
		StringBuilder sb = new StringBuilder();
		for(int i=0; i< bytes.length ;i++){
			sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
		}
		encStr = sb.toString();
		return encStr;
	}
}
