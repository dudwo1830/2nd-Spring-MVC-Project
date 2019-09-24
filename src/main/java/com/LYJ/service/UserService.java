package com.LYJ.service;

import java.util.List;

import com.LYJ.domain.LoginDTO;
import com.LYJ.domain.UserDTO;

public interface UserService {

	public void userInsert(UserDTO dto)throws Exception;
	
	public void userUpdate(UserDTO dto)throws Exception;
	
	public void userUpdate_pass(UserDTO dto)throws Exception; 
	
	public void userDelete(String uid) throws Exception;
	
	public UserDTO userLogin(LoginDTO ldto) throws Exception;
	
	public UserDTO userView(String uid) throws Exception;
	
	public void lastLogin(String uid) throws Exception;
	
	public int checkId(String uid) throws Exception;
	
	public UserDTO login_check(UserDTO dto) throws Exception;
	
	public void updateAuthkey(UserDTO dto) throws Exception;
	
	public void updateAuthkeyStatus(UserDTO dto)throws Exception;
	
	public void updateUad(String uid) throws Exception;
	
	public void updateUpoint(String uid, Integer upoint) throws Exception;
	
	public void downloadPt(String uid, Integer upoint) throws Exception;
	
	//admin
	public List<UserDTO> listUser() throws Exception;
	
}
