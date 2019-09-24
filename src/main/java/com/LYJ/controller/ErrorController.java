package com.LYJ.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/error/*")
public class ErrorController {
	private static final Logger logger = LoggerFactory.getLogger(ErrorController.class);
	
	@RequestMapping(value="/common")
	public void commonError(HttpServletRequest request, Model model){
		logger.info("commonError");
		pageErrorLog(request);
		model.addAttribute("msg", "잘못된 접근이거나 존재하지 않는 페이지입니다");
	}
	
	private void pageErrorLog(HttpServletRequest request) {
		logger.info("status_code : " + request.getAttribute("javax.servlet.error.status_code"));
		logger.info("exception_type : " + request.getAttribute("javax.servlet.error.exception_type"));
		logger.info("message : " + request.getAttribute("javax.servlet.error.message"));
		logger.info("request_url : " + request.getAttribute("javax.servlet.error.request_url"));
		logger.info("exception : " + request.getAttribute("javax.servlet.error.exception"));
		logger.info("servlet_name : " + request.getAttribute("javax.servlet.error.servlet_name"));
	}
}
