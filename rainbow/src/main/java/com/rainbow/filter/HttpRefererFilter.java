package com.rainbow.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class HttpRefererFilter implements Filter{
	
	
	private FilterConfig filterConfig = null;
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		
		req.setCharacterEncoding(filterConfig.getInitParameter("encoding"));
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		HttpSession session = request.getSession();
		//접속 경로
		String jonctionUrl = request.getHeader("referer");
		System.out.println("jonctionUrl >> " + jonctionUrl);
		//토큰
		String loginTokken = request.getHeader("loginTokken");
		if(session != null) {
			if(jonctionUrl != null){
				session.setAttribute("jonctionUrl", jonctionUrl);
			}
			if(loginTokken != null){
				session.setAttribute("loginTokken", loginTokken);
			}
		}
		response.sendRedirect("/main.do");
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.filterConfig = filterConfig;
	}

}
