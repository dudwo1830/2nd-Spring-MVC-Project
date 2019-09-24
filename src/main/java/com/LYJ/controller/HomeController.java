package com.LYJ.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.LYJ.domain.LoginDTO;
import com.LYJ.domain.UserDTO;
import com.LYJ.service.UserService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Inject
	private UserService uservice;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session, LoginDTO ldto) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		UserDTO dto = (UserDTO)session.getAttribute("userDTO");
		System.out.println(dto);
		if(dto != null ) {
			ldto.setUid(dto.getUid());
			ldto.setUpw(dto.getUpw());
			session.removeAttribute("userDTO");
			session.setAttribute("userDTO", uservice.userLogin(ldto));
		}
		
		return "home";
	}
	
}
