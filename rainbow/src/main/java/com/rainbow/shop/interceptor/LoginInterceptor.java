package com.rainbow.shop.interceptor;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.rainbow.shop.member.service.MemberAuthServiceImpl;
import com.rainbow.shop.member.service.MyPageServiceImpl;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	
	@Autowired
	MemberAuthServiceImpl memberAuthServiceImpl;
	
	@Autowired
	MyPageServiceImpl myPageServiceImpl;
	// preHandle() : 컨트롤러보다 먼저 수행되는 메서드
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	
    	System.out.println("interceptor!!!");
        // session 객체를 가져옴
        HttpSession session = request.getSession();
        // login처리를 담당하는 사용자 정보를 담고 있는 객체를 가져옴
        HashMap<String,Object> member = (HashMap<String,Object>)session.getAttribute("rb_member");
        
        boolean ajax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
    	if(StringUtils.isEmpty(member)){
    		
    		
    		if(ajax){
    			//response.setStatus(300);
    			response.sendError(300);
    		}else{
    			
    			String loginUrl = "/auth/login.do";
    			
    			if(!StringUtils.isEmpty(request.getRequestURI())){
    				if(!StringUtils.isEmpty(request.getQueryString())){
    					loginUrl += "?" + request.getRequestURI() +"?"+ request.getQueryString();
                	}else {
                		loginUrl += "?" + request.getRequestURI();
                	}
    				
    			}
            	response.sendRedirect(loginUrl);
    		}
    		return false;
        }else{
    		
        	int count = myPageServiceImpl.getMemberSessionStoreCount(request);
        	//로그인 세션 스토어에 현재 값이 존재 할경우.
        	if(count > 0) {
        		memberAuthServiceImpl.initMemberSessionInfo(request);
        	//브라우저에 세션값은 남아있으나 스토어에 값이 없는 경우(강제 로그아웃)
        	}else {
        		//강제 로그아웃 구분값.
        		request.setAttribute("compulsion", true);
        		memberAuthServiceImpl.memberLogout(request);
        		if(ajax){
        			//response.setStatus(300);
        			response.sendError(300);
        		}else{
        			
        			String loginUrl = "/auth/login.do";
        			
        			if(!StringUtils.isEmpty(request.getRequestURI())){
        				if(!StringUtils.isEmpty(request.getQueryString())){
        					loginUrl += "?" + request.getRequestURI() +"?"+ request.getQueryString();
                    	}else {
                    		loginUrl += "?" + request.getRequestURI();
                    	}
        				
        			}
                	response.sendRedirect(loginUrl);
        		}
        		return false;
        	}
        }
        // preHandle의 return은 컨트롤러 요청 uri로 가도 되냐 안되냐를 허가하는 의미임
        // 따라서 true로하면 컨트롤러 uri로 가게 됨.
        return true;
    }
    // 컨트롤러가 수행되고 화면이 보여지기 직전에 수행되는 메서드
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
    }

}
