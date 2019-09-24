package com.LYJ.persistence;

import java.util.List;
import java.util.Map;

import com.LYJ.domain.CloudVO;

public interface CloudDAO {
	//파일 업로드
	public void fileInsert(CloudVO vo) throws Exception;
	//파일 삭제
	public void fileDelete(CloudVO vo) throws Exception;
	//파일 리스트 불러오기
	public List<CloudVO> fileList() throws Exception;
	
	public List<CloudVO> nextListAll(Integer cidToStart) throws Exception;
	
	public List<CloudVO> fileListSearch(Map<String, String> map) throws Exception;
	
	public List<CloudVO> fileListMy(String uid) throws Exception;
	
	public List<CloudVO> fileListMySearch(Map<String, String> map) throws Exception;

	public List<CloudVO> nextList(Map<String, Object> map) throws Exception;
	
	public List<CloudVO> nextAllList(Map<String, Object> map) throws Exception;
	
}
