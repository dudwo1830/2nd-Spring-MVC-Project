package com.LYJ.persistence;

import java.util.List;

import com.LYJ.domain.LoginDTO;
import com.LYJ.domain.UserDTO;

public interface UserDAO {
	
	public String getTime();
	
	public void insertUser(UserDTO dto) throws Exception;
	
	public void updateUser(UserDTO dto) throws Exception;
	
	public void updateUser_pass(UserDTO dto) throws Exception;
	
	public void deleteUser(String uid) throws Exception;
	
	public UserDTO viewUser(String uid) throws Exception;
	
	//로그인
	public UserDTO login(LoginDTO ldto) throws Exception;
	
	public int checkId(String uid) throws Exception;
	
	public UserDTO login_check(UserDTO dto) throws Exception;
	//마지막 로그인
	public void lastLogin(String uid) throws Exception;
	//인증 관련
	public void updateAuthkey(UserDTO dto) throws Exception;
	public void updateAuthkeyStatus(UserDTO dto) throws Exception;
	//광고제거
	public void updateUad(String uid) throws Exception;
	//포인트결제
	public void updateUpoint(String uid, Integer upoint) throws Exception;
	//Admin
	public List<UserDTO> listUser() throws Exception;
	//다운로드시 포인트감소
	public void downloadPt(String uid, Integer upoint) throws Exception;
}
