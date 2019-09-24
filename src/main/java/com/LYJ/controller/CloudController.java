package com.LYJ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.LYJ.domain.CloudVO;
import com.LYJ.domain.UserDTO;
import com.LYJ.service.CloudService;

@Controller
@RequestMapping(value="/cloud/*")
public class CloudController {
	
	@Inject
	private CloudService service;
	//mycloud 페이지
	@RequestMapping(value="/myCloud", method= {RequestMethod.GET})
	public void myListAll(Model model, HttpSession session, String uid) throws Exception {
		UserDTO dto = (UserDTO)session.getAttribute("userDTO");
		uid = dto.getUid();
		
		model.addAttribute("listMy",service.fileListMy(uid));
	}
	//mycloud 페이지 스크롤
	@RequestMapping(value="/nextList", method = {RequestMethod.POST})
	@ResponseBody
	public List<CloudVO> nextList(HttpServletRequest request) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		Integer cidToStart = Integer.parseInt(request.getParameter("cid"));
		System.out.println("cidToStart : "+cidToStart);
		String cuid = request.getParameter("cuid");
		System.out.println("cuid : "+cuid);
		String keyword = request.getParameter("keyword");
		System.out.println("keyword : "+keyword);
		map.put("cidToStart", cidToStart);
		map.put("cuid", cuid);
		if(keyword != null && keyword != "") {
			map.put("keyword", keyword);
		}else {
			map.put("keyword", null);
		}
		return service.nextList(map);
	}
	//mycloud 페이지 파일업로드
	@RequestMapping(value="/myCloud", method= {RequestMethod.POST})
	public ModelAndView fileUpload(MultipartHttpServletRequest mRequest, HttpSession session) throws Exception {
		UserDTO dto = (UserDTO)session.getAttribute("userDTO");
		ModelAndView mav = new ModelAndView();
		String uid = dto.getUid();
		String unickName = dto.getUnickname();
		
		if(service.fileUpload(mRequest, uid, unickName)) {
			mav.addObject("result","SUCCESS");
		}else {
			mav.addObject("result", "FAIL");
		}
		mav.setViewName("/cloud/myCloud");
		System.out.println(mav);
		return mav;
	}
	//mycloud 페이지 검색
	@RequestMapping(value = "/searchMyList")
	@ResponseBody
	public List<CloudVO> searchMyList(HttpServletRequest request) throws Exception{
		String cuid = request.getParameter("cuid");
		String keyword = request.getParameter("keyword");
		System.out.println("search info : "+cuid + keyword);
		if(keyword == null || keyword ==  "") {
			return null;
		}else {
			return service.fileListMySearch(cuid, keyword);
		}
	}
	
	//P2P페이지
	@RequestMapping(value="/P2P")
	public void allList(Model model) throws Exception{
		
		model.addAttribute("listMy",service.fileList());
	}
	//P2P페이지 스크롤페이징
	@RequestMapping(value="/nextListAll", method = {RequestMethod.POST})
	@ResponseBody
	public List<CloudVO> nextListAll(HttpServletRequest request)throws Exception{
		/*
		 * Integer cidToStart = vo.getCid()-1; System.out.println(cidToStart);
		 * System.out.println(service.nextListAll(cidToStart)); return
		 * service.nextListAll(cidToStart);
		 */
		Map<String, Object> map = new HashMap<String, Object>();
		Integer cidToStart = Integer.parseInt(request.getParameter("cid"));
		System.out.println("cidToStart : "+cidToStart);
		String searchType = request.getParameter("cate");
		String keyword = request.getParameter("keyword");
		System.out.println("keyword : "+keyword);
		map.put("cidToStart", cidToStart);
		if(keyword != null && keyword != "") {
			map.put("keyword", keyword);
		}else {
			map.put("keyword", null);
		}
		if(searchType != null && keyword != "") {
			map.put("searchType", searchType);
		}else {
			map.put("searchType", null);
		}
		return service.nextAllList(map);
		
	}
	//P2P페이지 검색
	@RequestMapping(value = "/searchList")
	@ResponseBody
	public List<CloudVO> searchList(HttpServletRequest request) throws Exception{
		String keyword = request.getParameter("keyword");
		String cate = request.getParameter("cate");
		System.out.println("search info : "+ keyword + cate);
		
		if(keyword==null || keyword == "") {
			return null;
		}else {
			return service.fileListSearch(cate, keyword);
		}
	}
	//클라우드 파일 제거
	@RequestMapping(value="/fileDelete")
	public void fileDelete(CloudVO vo) throws Exception{
		service.fileDelete(vo);
	}
}
