package com.LYJ.common;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger("AuthInterceptor.class");
	
	//요청한 페이지 저장
	private void saveDestination(HttpServletRequest request) {
		String uri = request.getRequestURI();
		String query = request.getQueryString();
		if(query == null || query.equals("null")) {
			query = "";
		}else {
			query = "?" + query;
		}
		
		if(request.getMethod().equals("GET")) {
			logger.info("저장된 주소 : " + (uri + query));
			request.getSession().setAttribute("destination", uri + query);
		}
	}
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		//로그인세션이 없다면 로그인페이지로
		if(session.getAttribute("userDTO") == null) {
			logger.info("로그인되어있지 않음");
			saveDestination(request);
			System.out.println(request);
			out.println("<script language='javascript'>");
			out.println("alert('로그인이 필요한 서비스입니다.')");
			out.println("location.href='/user/login';");
			out.println("</script>");
			out.flush();
			return false;
		}
		
		return true;
	}
}
