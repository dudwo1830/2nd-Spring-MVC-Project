package com.LYJ.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.LYJ.domain.LoginDTO;
import com.LYJ.domain.UserDTO;

@Repository
public class UserDAOImpl implements UserDAO{

	@Inject
	private SqlSession session;
	
	private static String namespace = "com.LYJ.mapper.UserMapper";
	
	@Override
	public String getTime() {
		return session.selectOne(namespace+".getTime");
	}

	@Override
	public void insertUser(UserDTO dto) throws Exception {
		session.insert(namespace+".insertUser", dto);
	}

	@Override
	public void updateUser(UserDTO dto) throws Exception {
		session.update(namespace+".updateUser", dto);
	}

	@Override
	public void updateUser_pass(UserDTO dto) throws Exception {
		session.update(namespace+".updateUser_pass", dto);
	}

	@Override
	public void deleteUser(String uid) throws Exception {
		session.delete(namespace+".deleteUser", uid);
	}

	@Override
	public UserDTO viewUser(String uid) throws Exception {
		return session.selectOne(namespace+".viewUser", uid);
	}
	
	@Override
	public UserDTO login(LoginDTO ldto) throws Exception {
		return session.selectOne(namespace+".login", ldto);
	}

	@Override
	public int checkId(String uid) throws Exception {
		return session.selectOne(namespace+".check_id", uid);
	}

	@Override
	public UserDTO login_check(UserDTO dto) throws Exception {
		return session.selectOne(namespace+".login_check", dto);
	}

	@Override
	public void lastLogin(String uid) throws Exception {
		session.update(namespace+".lastLogin", uid);
	}
	
	@Override
	public void updateAuthkey(UserDTO dto) throws Exception {
		session.update(namespace+".up_authkey", dto);
	}

	@Override
	public void updateAuthkeyStatus(UserDTO dto) throws Exception {
		session.update(namespace+".up_authkeyStatus", dto);
	}

	@Override
	public void updateUad(String uid) throws Exception {
		session.update(namespace+".payUad", uid);
	}

	@Override
	public void updateUpoint(String uid, Integer upoint) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uid", uid);
		map.put("upoint", upoint);
		session.update(namespace+".payUpoint", map);
	}
	
	@Override
	public void downloadPt(String uid, Integer upoint) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uid", uid);
		map.put("upoint", upoint);
		session.update(namespace+".downloadPt",map);
	}

	//Admin
	@Override
	public List<UserDTO> listUser() throws Exception {
		return session.selectList(namespace+".listUser");
	}
	
}
