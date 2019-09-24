package com.LYJ.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.LYJ.domain.LoginDTO;
import com.LYJ.domain.MailUtils;
import com.LYJ.domain.TempKey;
import com.LYJ.domain.UserDTO;
import com.LYJ.persistence.UserDAO;

@Service
public class UserServiceImpl implements UserService{

	@Inject
	private UserDAO dao;
	
	@Inject
	private JavaMailSender mailSender;
	
	@Override
	@Transactional
	public void userInsert(UserDTO dto) throws Exception {
		dao.insertUser(dto);
		
		String authkey = new TempKey().getKey(50, false);
		dto.setAuthkey(authkey);
		dao.updateAuthkey(dto);
		
		MailUtils sendMail = new MailUtils(mailSender);
		sendMail.setSubject("LYJ 회원가입 인증메일 입니다");
		sendMail.setText(new StringBuffer().append("<h1>[이메일 인증]</h1>")
				.append("<p>아래 링크를 클릭하시면 이메일 인증이 완료됩니다.</p>")
				.append("<a href='http://localhost:8080/user/joinConfirm?uid=")
				.append(dto.getUid())
				.append("&unickname=")
				.append(dto.getUnickname())
				.append("&authkey=")
				.append(authkey)
				.append("' target='_blenk'>이메일 인증 확인</a><br>")
				.append("<p>만약 의도치 않은 메일이라면 무시해 주십시오</p>")
				.toString());
		sendMail.setFrom("temp", "admin");
		sendMail.setTo(dto.getUid());
		sendMail.send();
	}

	@Override
	public void userUpdate(UserDTO dto) throws Exception {
		dao.updateUser(dto);
	}

	@Override
	public void userUpdate_pass(UserDTO dto) throws Exception {
		dao.updateUser_pass(dto);
	}

	@Override
	public void userDelete(String uid) throws Exception {
		dao.deleteUser(uid);
	}

	@Override
	public UserDTO userLogin(LoginDTO ldto) throws Exception {
		return dao.login(ldto);
	}

	@Override
	public UserDTO userView(String uid) throws Exception {
		return dao.viewUser(uid);
	}

	@Override
	public void lastLogin(String uid) throws Exception {
		dao.lastLogin(uid);
	}

	@Override
	public int checkId(String uid) throws Exception {
		return dao.checkId(uid);
	}

	@Override
	public UserDTO login_check(UserDTO dto) throws Exception {
		return dao.login_check(dto);
	}

	@Override
	public void updateAuthkey(UserDTO dto) throws Exception {
		dao.updateAuthkey(dto);
	}

	@Override
	public void updateAuthkeyStatus(UserDTO dto) throws Exception {
		dao.updateAuthkeyStatus(dto);
	}

	@Override
	public void updateUad(String uid) throws Exception {
		dao.updateUad(uid);
	}
	
	@Override
	public void updateUpoint(String uid, Integer upoint) throws Exception {
		dao.updateUpoint(uid, upoint);
	}

	@Override
	public void downloadPt(String uid, Integer upoint) throws Exception {
		dao.downloadPt(uid, upoint);
	}

	//admin
	@Override
	public List<UserDTO> listUser() throws Exception {
		return dao.listUser();
	}
	
}
