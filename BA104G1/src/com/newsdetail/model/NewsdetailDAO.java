package com.newsdetail.model;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.io.*;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.nio.file.Files;

public class NewsdetailDAO implements NewsdetailDAO_interface{
	
	
// ***********  放到貓的Context.xml
//	 <Resource auth="Container" driverClassName="oracle.jdbc.driver.OracleDriver" maxActive="20" maxIdle="10" maxWait="-1" name="jdbc/TestDB" password="ba104g1" type="javax.sql.DataSource" url="jdbc:oracle:thin:@localhost:1521:XE" username="ba104g1"/>
//	 <Resource auth="Container" driverClassName="oracle.jdbc.driver.OracleDriver" maxActive="20" maxIdle="10" maxWait="-1" name="jdbc/TestDB" password="ba104g1" type="javax.sql.DataSource" url="jdbc:oracle:thin:@13.229.86.22:1521:XE" username="ba104g1"/>

	
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Takecare");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	// 新增
	private static final String INSERT_STMT =
			"INSERT INTO NEWSDETAIL(NEWSNO, NEWSTITLE, NEWSINTRO, EMP_NO, COVERPIC, STATUS) VALUES (to_char('ND'||LPAD(to_char(NEWSNO_SEQ.NEXTVAL),4,'0')),? ,?, ?, ?, ?)";
	// 查全部
	private static final String GET_ALL_STMT =
			"SELECT NEWSNO, NEWSTITLE, NEWSINTRO, EMP_NO, COVERPIC, NEWSDATE, STATUS FROM NEWSDETAIL ORDER BY NEWSNO DESC";
	// 員工關鍵字查詢
	private static final String GET_ONE_STMT =
			"SELECT NEWSNO, NEWSTITLE, NEWSINTRO, EMP_NO, COVERPIC, NEWSDATE, STATUS FROM NEWSDETAIL WHERE NEWSNO = ?";
	// 刪除
	private static final String DELETE = 
			"DELETE FROM NEWSDETAIL WHERE newsno = ?";
	// 修改
	private static final String UPDATE = 
			"UPDATE NEWSDETAIL SET NEWSTITLE=?, NEWSINTRO=?, EMP_NO=?, NEWSDATE=?, STATUS=? where NEWSNO = ?";

	@Override
	public void insert(NewsdetailVO newsdetailVO){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
//			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);
			
			
			pstmt.setString(1, newsdetailVO.getNewstitle());
			pstmt.setString(2, newsdetailVO.getNewsintro());
			pstmt.setString(3, newsdetailVO.getEmpno());
			pstmt.setBytes(4, newsdetailVO.getCoverpic());
			pstmt.setString(5, newsdetailVO.getStatus());
			
			pstmt.executeUpdate();
			
		// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}

	
	@Override
	public void update(NewsdetailVO newsdetailVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
			
			
			pstmt.setString(1, newsdetailVO.getNewsno());
			pstmt.setString(2, newsdetailVO.getNewstitle());
			pstmt.setString(3, newsdetailVO.getNewsintro());
			pstmt.setString(4, newsdetailVO.getEmpno());
//			pstmt.setBytes(5, newsdetailVO.getCoverpic());
			pstmt.setTimestamp(6, newsdetailVO.getNewsdate());
			pstmt.setString(7, newsdetailVO.getStatus());
			pstmt.executeUpdate();
		
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
				
			// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			if(con != null){
				try {
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void delete(String newsno) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, newsno);
			
			pstmt.executeUpdate();
			
			
		// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public NewsdetailVO findByPrimaryKey(String newsno) {
		NewsdetailVO newsdetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
		
		
			pstmt.setString(1, newsno);
			rs = pstmt.executeQuery();
			
			
			while (rs.next()){
				newsdetailVO = new NewsdetailVO();
				newsdetailVO.setNewsno(rs.getString("newsno"));
				newsdetailVO.setNewstitle(rs.getString("newstitle"));
				newsdetailVO.setNewsintro(rs.getString("newsintro"));
				newsdetailVO.setEmpno(rs.getString("emp_no"));
				newsdetailVO.setCoverpic(rs.getBytes("coverpic"));
				newsdetailVO.setNewsdate(rs.getTimestamp("newsdate"));
				newsdetailVO.setStatus(rs.getString("status"));
			}
			
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return newsdetailVO;
	}


	@Override
	public List<NewsdetailVO> getAll() {
		List<NewsdetailVO> list = new ArrayList<NewsdetailVO>();
		NewsdetailVO newsdetailVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
				
			while(rs.next()){
				newsdetailVO = new NewsdetailVO();
				newsdetailVO.setNewsno(rs.getString("newsno"));
				newsdetailVO.setNewstitle(rs.getString("newstitle"));
				newsdetailVO.setNewsintro(rs.getString("newsintro"));
				newsdetailVO.setEmpno(rs.getString("emp_no"));
				newsdetailVO.setCoverpic(rs.getBytes("coverpic"));
				newsdetailVO.setNewsdate(rs.getTimestamp("newsdate"));
				newsdetailVO.setStatus(rs.getString("status"));
				list.add(newsdetailVO);			
			}
			
		// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
		
		// Clean up JDBC resources
		} finally {
			if(pstmt !=null){
				try{
					pstmt.close();
				} catch (SQLException se){
					se.printStackTrace(System.err);
				}
			}
			
			if(con != null){
				try {
					con.close();
				} catch (Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
}