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

import org.springframework.mobile.device.Device;
import org.springframework.mobile.device.DeviceUtils;

public class AccessDeviceFilter implements Filter {

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain next)
			throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest)req;
		HttpServletResponse response = (HttpServletResponse)res;
		Device device = DeviceUtils.getCurrentDevice(request);        
        if(device == null) {
        	response.sendRedirect("/WEB-INF/views/error/errorPage.jsp");
        }else {
        	String deviceType = "unknown";
	        if (device.isNormal()) {
	            deviceType = "pc";
	        } else if (device.isMobile()) {
	            deviceType = "mobile";
	        } else if (device.isTablet()) {
	            deviceType = "tablet";
	        }
	        if(deviceType.equals("unknown")){
	        	response.sendRedirect("/WEB-INF/views/error/errorPage.jsp");
	        }else{
	        	
	        	
	        	next.doFilter(req, res);
	        }
        }
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

}
