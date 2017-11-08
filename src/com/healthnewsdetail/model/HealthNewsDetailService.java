package com.healthnewsdetail.model;

import java.sql.*;
import java.util.*;


public class HealthNewsDetailService {
	
	private HealthNewsDetailDAO_interface dao;
	
	
	public HealthNewsDetailService(){
		dao = new HealthNewsDetailJDBCDAO();
	}
	
	
	public HealthNewsDetailVO addHeaNews( String newsTitle, String newsIntro, String emp_no, byte[] coverPic,String status){
		HealthNewsDetailVO healthNewsDetailVO = new HealthNewsDetailVO();
		healthNewsDetailVO.setNewsTitle(newsTitle);
		healthNewsDetailVO.setNewsIntro(newsIntro);
		healthNewsDetailVO.setEmp_no(emp_no);
		healthNewsDetailVO.setCoverPic(coverPic);
		healthNewsDetailVO.setStatus(status);
		dao.insert(healthNewsDetailVO);
		
		return healthNewsDetailVO;
	}
	
	public HealthNewsDetailVO updateHeaNews(String healthNo, String newsTitle, String newsIntro, String emp_no, byte[] coverPic, Timestamp newsDate, String status){
		HealthNewsDetailVO healthNewsDetailVO = new HealthNewsDetailVO();
		healthNewsDetailVO.setNewsTitle(newsTitle);
		healthNewsDetailVO.setNewsIntro(newsIntro);
		healthNewsDetailVO.setEmp_no(emp_no);
		healthNewsDetailVO.setCoverPic(coverPic);
		healthNewsDetailVO.setNewsDate(newsDate);
		healthNewsDetailVO.setStatus(status);
		dao.update(healthNewsDetailVO);
		
		return healthNewsDetailVO;
	
	}
	
	public void deleteHeaNews(String healthNo){
		dao.delete(healthNo);
	}
	
	public HealthNewsDetailVO getOneNews(String healthNo){
		return dao.findByPrimaryKey(healthNo);
	}
	
	public List<HealthNewsDetailVO> getAll(){
		return dao.getAll();
	}
	

}
