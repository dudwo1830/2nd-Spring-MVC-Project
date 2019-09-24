package com.LYJ.controller;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.LYJ.domain.LoginDTO;
import com.LYJ.domain.MailUtils;
import com.LYJ.domain.UserDTO;
import com.LYJ.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {
	
	@Inject
	private UserService service;
	@Inject
	private JavaMailSender mailSender;
	
	private static final Logger logger = LoggerFactory.getLogger("UserController.class");
	
	//중복체크
	@ResponseBody
	@RequestMapping(value="/idCheck")
	public int IdCheck(HttpServletRequest request)throws Exception{
		String uid = request.getParameter("uid");
		int idCheck = service.checkId(uid);
		int result = 0;
		
		if(idCheck == 1) {
			logger.info("이메일 중복");
			result = 1;
		}
		return result;
	}
	//가입
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public void joinGET() {
		
	}
	@RequestMapping(value="/join_send", method=RequestMethod.POST)
	public void joinPOST(UserDTO dto, HttpServletResponse response) throws Exception{

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		out.println("<script language='javascript'>");
		out.println("alert('해당 이메일로 인증메일을 전송했습니다. \\n인증후에 로그인하실 수 있습니다.');");
		out.println("location.href='../';");
		out.println("</script>");
		out.flush();
		
		service.userInsert(dto);
	}
	//메일 인증
	@RequestMapping(value="/joinConfirm", method=RequestMethod.GET)
	public String uidConfirm(@ModelAttribute("dto") UserDTO dto, Model model, HttpServletResponse response, HttpSession session) throws Exception {
		dto.setAuthkeyStatus("Y");
		service.updateAuthkeyStatus(dto);
		model.addAttribute("auth_check", 1);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		service.userUpdate_pass(dto);
		out.println("<script language='javascript'>");
		out.println("alert('인증이 완료되었습니다 \\n로그인하여 이용해주세요');");
		out.println("</script>");
		out.flush();
		
		if(session.getAttribute("userDTO") != null) {
			session.removeAttribute("userDTO");
			session.invalidate();
		}
		return "home";
	}
	//비밀번호 찾기
	@RequestMapping(value="/findPass", method=RequestMethod.GET)
	public void GETfindPass(@ModelAttribute("dto") UserDTO dto, Model model) throws Exception{
		
	}
	@RequestMapping(value="/findPass", method=RequestMethod.POST)
	public String POSTfindPass(@RequestParam("uid") String uid, Model model) throws Exception{
		
		UserDTO dto = new UserDTO(); 
		dto = service.userView(uid);
		System.out.println(dto.getAuthkey());
		System.out.println(dto.getUid());
		
		MailUtils sendMail = new MailUtils(mailSender);
		sendMail.setSubject("LYJ 비밀번호 찾기 메일입니다");
		sendMail.setText(new StringBuffer().append("<h1>[비밀번호 변경]</h1>")
				.append("<p>아래 링크를 클릭하시면 비밀번호 변경 페이지로 이동합니다.</p>")
				.append("<a href='http://localhost:8080/user/changePass?authkey=")
				.append(dto.getAuthkey())
				.append("' target='_blenk'>비밀번호 변경</a><br>")
				.append("<p>만약 의도치 않은 메일이라면 무시해 주십시오</p>")
				.toString());
		sendMail.setFrom("temp", "admin");
		sendMail.setTo(dto.getUid());
		sendMail.send();
		
		return "/user/findPass_send";
	}
	//비밀번호 변경
	@RequestMapping(value="/changePass", method=RequestMethod.GET)
	public void GETChangePass() throws Exception{
		
	}
	@RequestMapping(value="/changePass", method=RequestMethod.POST)
	public void POSTChangePass(UserDTO dto, Model model, HttpServletResponse response, HttpSession session) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		service.userUpdate_pass(dto);
		
		out.println("<script language='javascript'>");
		out.println("alert('비밀번호가 변경되었습니다.\\n다시 로그인하여 이용해주세요.');");
		out.println("location.href='../';");
		out.println("</script>");
		out.flush();
		
	}
	//닉네임 변경
	@RequestMapping(value="/changeNick", method=RequestMethod.GET)
	public void GETChangeNick() throws Exception{
		
	}
	@RequestMapping(value="/changeNick", method=RequestMethod.POST)
	public void POSTChangeNick(UserDTO dto, LoginDTO ldto, HttpSession session, HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		service.userUpdate(dto);
		System.out.println(dto);
		
		out.println("<script language='javascript'>");
		out.println("alert('닉네임 변경이 완료되었습니다.');");
		out.println("location.href='../';");
		out.println("</script>");
		out.flush();
		
		dto = (UserDTO)session.getAttribute("userDTO");
		String uid = dto.getUid();
		String upw = dto.getUpw();
		System.out.println(dto);
		ldto.setUid(uid);
		ldto.setUpw(upw);
		dto = service.userLogin(ldto);
		System.out.println(ldto);
		session.removeAttribute("userDTO");
		session.setAttribute("userDTO", dto);
		System.out.println(dto);

	}
	//로그인
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public void loginGET(@ModelAttribute("ldto") LoginDTO ldto) {
		
	}
	//로그인 확인
	@ResponseBody
	@RequestMapping(value="login_check")
	public int login_check(HttpServletRequest request, UserDTO dto, String uid, String upw) throws Exception {
		int result = 0;
		uid = request.getParameter("uid");
		upw = request.getParameter("upw");
		if((uid != "" || uid != null) && (upw != null || upw != "")) {
			dto.setUid(uid);
			dto.setUpw(upw);
			dto = service.login_check(dto);
		}
		String yes = "Y";
		String no = "N";
		if(dto != null) {
			if(dto.getAuthkeyStatus().equals(yes)) {
				result = 1;
			}else if(dto.getAuthkeyStatus().equals(no)){
				result = 2;
			}
		}
		return result;
	}
	//로그인 처리
	@RequestMapping(value="/loginPOST", method=RequestMethod.POST)
	public void loginPOST(LoginDTO ldto, HttpSession session, Model model)throws Exception{
		UserDTO dto = service.userLogin(ldto);
		String uid = ldto.getUid();
		service.lastLogin(uid);
		session.setAttribute("userDTO", dto);
		logger.info("로그인 성공");
	}
	//로그아웃
	@RequestMapping(value="/logout", method= {RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception{
		Object obj = session.getAttribute("userDTO");
		
		if(obj != null) {
			session.removeAttribute("userDTO");
			session.invalidate();
		}
		return "redirect:/";
	}
	
	//광고제거
	@RequestMapping(value = "payUad", method = {RequestMethod.POST, RequestMethod.GET})
	public void payUad(HttpSession session, HttpServletResponse response, LoginDTO ldto) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		UserDTO dto = (UserDTO)session.getAttribute("userDTO");
		System.out.println(dto);
		String uid = dto.getUid();
		service.updateUad(uid);
		
		out.println("<script language='javascript'>");
		out.println("alert('1분동안 광고가 제거됩니다.');");
		out.println("location.href='../';");
		out.println("</script>");
		out.flush();
		
		String upw = dto.getUpw();
		ldto.setUid(uid);
		ldto.setUpw(upw);
		dto = service.userLogin(ldto);
		session.setAttribute("userDTO", dto);
	}
	
	//포인트 구입
	@RequestMapping(value="payUpoint", method = RequestMethod.POST)
	public void payUpoint(@ModelAttribute("upoint") Integer upoint, LoginDTO ldto, HttpServletResponse response, HttpSession session, UserDTO dto)throws Exception{
		dto = (UserDTO)session.getAttribute("userDTO");
		String uid = dto.getUid();
		service.updateUpoint(uid, upoint);
		String upw = dto.getUpw();
		ldto.setUid(uid);
		ldto.setUpw(upw);
		dto = service.userLogin(ldto);
		session.setAttribute("userDTO", dto);
	}
	
	//다운로드시 포인트감소
	@RequestMapping(value = "/userDownload", method = RequestMethod.POST)
	@ResponseBody
	public void userDownload(HttpServletRequest request) throws Exception{
		String downUid = request.getParameter("downloadUid");
		String upUid = request.getParameter("uploadUid");
		Integer upoint = Integer.parseInt(request.getParameter("downloadPt"));
		System.out.println("userDownload info : downUid = "+ downUid + "upUid = " + upUid + "upoint = " + upoint);
		//다운로드uid와 업로드uid가 같지 않다면
		if(!downUid.equals(upUid)) {
			System.out.println("포인트감소 실행");
			service.downloadPt(downUid, upoint);
		}
	}
}
