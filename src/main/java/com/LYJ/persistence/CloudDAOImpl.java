package com.LYJ.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.LYJ.domain.CloudVO;

@Repository
public class CloudDAOImpl implements CloudDAO{

	@Inject
	private SqlSession session;
	
	private static String namespace = "com.LYJ.mapper.CloudMapper";
	
	@Override
	public void fileInsert(CloudVO vo) throws Exception {
		session.insert(namespace+".cwrite", vo);
	}
	
	@Override
	public void fileDelete(CloudVO vo) throws Exception {
		session.delete(namespace+".cdelete", vo);
	}

	@Override
	public List<CloudVO> fileList() throws Exception {
		return session.selectList(namespace+".listAll");
	}

	@Override
	public List<CloudVO> fileListSearch(Map<String, String> map) throws Exception {
		return session.selectList(namespace+".listSearch", map);
	}

	@Override
	public List<CloudVO> fileListMy(String uid) throws Exception {
		return session.selectList(namespace+".getMyCloud", uid);
	}

	@Override
	public List<CloudVO> nextList(Map<String, Object> map) throws Exception {
		return session.selectList(namespace+".nextList", map);
	}

	@Override
	public List<CloudVO> nextListAll(Integer cidToStart) throws Exception {
		return session.selectList(namespace+".nextListAll", cidToStart);
	}

	@Override
	public List<CloudVO> fileListMySearch(Map<String, String> map) throws Exception {
		return session.selectList(namespace+".mySearchList", map);
	}

	@Override
	public List<CloudVO> nextAllList(Map<String, Object> map) throws Exception {
		return session.selectList(namespace+".nextAllList", map);
	}
	
}
