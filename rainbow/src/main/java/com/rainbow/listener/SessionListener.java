package com.rainbow.listener;

import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.context.ApplicationContext;
import org.springframework.util.StringUtils;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.rainbow.shop.member.service.MemberAuthServiceImpl;

public class SessionListener implements HttpSessionListener{
	
	@Override
	public void sessionCreated(HttpSessionEvent e) {
		// TODO Auto-generated method stub
	}
	
	/**
	 * 세션 삭제될시 리스너 (세션타임아웃 또는 로그아웃 버튼 클릭)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void sessionDestroyed(HttpSessionEvent e){
		
		System.out.println("sessionDestroyed");
		
		HttpSession session = e.getSession();
		HashMap<String,Object> member = (HashMap<String,Object>)session.getAttribute("rb_member");
	
		//로그인 되어 있는 상태에서 로그 아웃 될때만 로그를 쌓는다.
		if(!StringUtils.isEmpty(member)) {
		
			member.put("mb_logout_session_id", session.getId());
			
			ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(session.getServletContext());
			MemberAuthServiceImpl service = ctx.getBean(MemberAuthServiceImpl.class);
			
			if(!StringUtils.isEmpty(service)) {
	            try {
	            	service.memberLogoutProcess(member);
	            }catch(Exception event) {
	            	event.printStackTrace();
	            }finally {
	            	service = null;
	            }
	        }

		}
	}
}
