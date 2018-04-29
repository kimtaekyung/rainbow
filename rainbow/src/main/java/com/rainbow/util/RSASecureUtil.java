package com.rainbow.util;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.HashMap;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;

import com.rainbow.constant.Constant;

public class RSASecureUtil {
	
	private static String RSA_WEB_KEY 	= "RSA_KEY"; 		// 개인키 session key
	private static String RSA_INSTANCE 	= "RSA"; 				// rsa transformation
	
    /**
     * rsa 복호화
     * 
     * @param privateKey
     * @param securedValue
     * @return
     * @throws Exception
     */
	public static String decryptRsa(HttpServletRequest req,String securedValue) throws Exception {
    	HttpSession session = req.getSession();
    	PrivateKey privateKey = (PrivateKey) session.getAttribute(RSASecureUtil.RSA_WEB_KEY);
        Cipher cipher = Cipher.getInstance(RSASecureUtil.RSA_INSTANCE);
        byte[] encryptedBytes = hexToByteArray(securedValue);
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        return decryptedValue;
    }
 
    /**
     * 16진 문자열을 byte 배열로 변환한다.
     * 
     * @param hex
     * @return
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) { return new byte[] {}; }
 
        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
	
	/**
     * rsa 공개키, 개인키 생성
     * 
     * @param request
     */
    public static HashMap<String,Object> initRsa(HttpServletRequest request) {
    	
        HttpSession session = request.getSession();
        HashMap<String,Object> resultMap = new HashMap<String,Object>();
        
        KeyPairGenerator generator;
        try {
            generator = KeyPairGenerator.getInstance(RSASecureUtil.RSA_INSTANCE);
            generator.initialize(1024);
 
            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance(RSASecureUtil.RSA_INSTANCE);
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
 
            session.setAttribute(RSASecureUtil.RSA_WEB_KEY, privateKey); // session에 RSA 개인키를 세션에 저장
            
            
            
            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
            
            System.out.println("publicKeyModulus >> " + publicKeyModulus);
            System.out.println("publicKeyExponent >> " + publicKeyExponent);
            
            resultMap.put("RSAModulus", publicKeyModulus);
            resultMap.put("RSAExponent", publicKeyExponent);
            resultMap.put("result", Constant.AJAX_RESULT_SUCCESS);
            
             
            //request.setAttribute("RSAModulus", publicKeyModulus); // rsa modulus 를 request 에 추가
            //request.setAttribute("RSAExponent", publicKeyExponent); // rsa exponent 를 request 에 추가
        } catch (Exception e) {
            // TODO Auto-generated catch block
        	e.printStackTrace();
        	resultMap.put("result", Constant.AJAX_RESULT_FAIL);
        }
        return resultMap;
    }
    
    /**
     * rsa 세션에서 개인키 파기
     * @param request
     */
    public static void destroyRsa(HttpServletRequest request) {
    	HttpSession session = request.getSession();
        PrivateKey key = (PrivateKey) session.getAttribute(RSASecureUtil.RSA_WEB_KEY);
        if (key != null) { // 기존 key 파기
            session.removeAttribute(RSASecureUtil.RSA_WEB_KEY);
        }
    }
    
    
    
    
}
