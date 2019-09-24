package com.LYJ.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.LYJ.domain.CloudVO;

public interface CloudService {
	
	public void fileInsert(CloudVO vo) throws Exception;
	
	public void fileDelete(CloudVO vo) throws Exception;
	
	public List<CloudVO> fileList() throws Exception;
	
	public List<CloudVO> fileListSearch(String cate, String search) throws Exception;
	
	public List<CloudVO> fileListMy(String uid) throws Exception;
	
	public boolean fileUpload(MultipartHttpServletRequest mRequest, String uid, String unickName) throws Exception;

	public List<CloudVO> nextList(Map<String, Object> map) throws Exception;

	public List<CloudVO> nextListAll(Integer cidToStart) throws Exception;
	
	public List<CloudVO> fileListMySearch(String cuid, String keyword) throws Exception;
	
	public List<CloudVO> nextAllList(Map<String, Object> map) throws Exception;
}
