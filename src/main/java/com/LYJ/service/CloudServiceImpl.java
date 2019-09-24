package com.LYJ.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.LYJ.domain.CloudVO;
import com.LYJ.persistence.CloudDAO;

@Service
public class CloudServiceImpl implements CloudService{

	@Inject
	private CloudDAO dao;

	@Override
	public void fileInsert(CloudVO vo) throws Exception {
		dao.fileInsert(vo);
	}

	@Override
	public void fileDelete(CloudVO vo) throws Exception {
		dao.fileDelete(vo);
	}

	@Override
	public List<CloudVO> fileList() throws Exception {
		return dao.fileList();
	}

	@Override
	public List<CloudVO> fileListSearch(String cate, String search) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("searchType", cate);
		map.put("keyword", search);
		
		return dao.fileListSearch(map);
	}

	@Override
	public List<CloudVO> fileListMy(String uid) throws Exception {
		return dao.fileListMy(uid);
	}

	@Override
	public boolean fileUpload(MultipartHttpServletRequest mRequest, String uid, String unickName) throws Exception {
		
		boolean isSuccess = false;
		String uploadPath = "C:\\eclipse-workspace\\LYJ\\src\\main\\webapp\\resources\\upload\\";
		File dir = new File(uploadPath);
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		Iterator<String> iter = mRequest.getFileNames();
		
		while(iter.hasNext()) {
			String uploadFileName = iter.next();
			MultipartFile mFile = mRequest.getFile(uploadFileName);
			String originalFileName = mFile.getOriginalFilename();
			long fileSize = mFile.getSize();
			String saveFileName = originalFileName;
			int pos = originalFileName.lastIndexOf('.');
			String ext = originalFileName.substring(pos +1);
			System.out.println("확장자 : "+ext);

			if(saveFileName != null && !saveFileName.equals("")) {
				//파일명이 중복될경우 임의의 파일명으로 변경
				if(new File(uploadPath + saveFileName).exists()) {
					saveFileName =System.currentTimeMillis() + "_" + saveFileName;
				}
				CloudVO vo = new CloudVO();
				vo.setCoriginName(originalFileName);
				vo.setCfileName(saveFileName);
				vo.setCfileSize(fileSize);
				vo.setCuid(uid);
				vo.setCunickName(unickName);
				vo.setExt(ext);
				try {
					dao.fileInsert(vo);
					mFile.transferTo(new File(uploadPath + saveFileName));
					isSuccess = true;
				}catch(IllegalStateException e) {
					e.printStackTrace();
					isSuccess = false;
				}catch(IOException e) {
					e.printStackTrace();
					isSuccess = false;
				}
			}//if END
		}//while END
		return isSuccess;	
	}

	@Override
	public List<CloudVO> nextList(Map<String, Object> map) throws Exception {
		return dao.nextList(map);
	}

	@Override
	public List<CloudVO> nextListAll(Integer cidToStart) throws Exception {
		return dao.nextListAll(cidToStart);
	}

	@Override
	public List<CloudVO> fileListMySearch(String cuid, String keyword) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("cuid", cuid);
		map.put("keyword", keyword);
		return dao.fileListMySearch(map);
	}

	@Override
	public List<CloudVO> nextAllList(Map<String, Object> map) throws Exception {
		return dao.nextAllList(map);
	}
	
}
