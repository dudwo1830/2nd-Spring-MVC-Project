package com.LYJ.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter{
	
	private static final String LOGIN = "userDTO";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	//로그인페이지로 이동
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler) throws Exception{
		HttpSession session = request.getSession();
		//기존 로그인세션이 있다면 제거후 로그인페이지로
		if(session.getAttribute(LOGIN) != null) {
			logger.info("로그인 세션 제거");
			session.removeAttribute(LOGIN);
		}
		return true;
	}
	//저장해 두었던 페이지로 이동
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, 
			Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
		HttpSession session = request.getSession();
		Object destination = session.getAttribute("destination");
		logger.info("로그인 후 이동할 주소 : "+destination);
		response.sendRedirect(destination != null ? (String) destination : "/");
	}
}
