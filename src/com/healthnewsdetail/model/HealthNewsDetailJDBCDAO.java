package com.healthnewsdetail.model;

import java.io.*;
import java.nio.file.Files;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


public class HealthNewsDetailJDBCDAO implements HealthNewsDetailDAO_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String userid = "ba104g1";
	String passwd = "ba104g1";
	
//	// ************** AWS **************
//	String url = "jdbc:oracle:thin:@13.229.86.22:1521:XE";
	// ************** BA104 **************
//	String url = "jdbc:oracle:thin:@10.120.25.6:1521:XE";
//	// ************* Localhost **********
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	


	// 新增
	private static final String INSERT_STMT =
			"INSERT INTO HEALTHNEWSDETAIL (HEALTHNO, NEWSTITLE, NEWSINTRO, EMP_NO, COVERPIC, STATUS) VALUES (to_char('HD'||LPAD(to_char(HEALTHNO_SEQ.NEXTVAL),4,'0')),? , ?, ?, ?, ?)";
	// 查全部
	private static final String GET_ALL_STMT =
			"SELECT HEALTHNO, NEWSTITLE, NEWSINTRO, EMP_NO, COVERPIC, NEWSDATE, STATUS FROM HEALTHNEWSDETAIL ORDER BY HEALTHNO DESC";
	// 員工關鍵字查詢
	private static final String GET_ONE_STMT =
			"SELECT HEALTHNO, NEWSTITLE, NEWSINTRO, EMP_NO, COVERPIC, NEWSDATE, STATUS FROM HEALTHNEWSDETAIL WHERE HEALTHNO = ?";
	// 刪除
	private static final String DELETE = 
			"DELETE FROM HEALTHNEWSDETAIL WHERE HEALTHNO = ?";
	// 修改
	private static final String UPDATE = 
			"UPDATE HEALTHNEWSDETAIL SET NEWSTITLE=?, NEWSINTRO=?, EMP_NO=?, COVERPIC=?, NEWSDATE=CURRENT_TIMESTAMP , STATUS=? where HEALTHNO = ?";

	
	
	
	
	@Override
	public void insert(HealthNewsDetailVO healthNewsDetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			

			pstmt.setString(1, healthNewsDetailVO.getNewsTitle());
			pstmt.setString(2, healthNewsDetailVO.getNewsIntro());
			pstmt.setString(3, healthNewsDetailVO.getEmp_no());
			pstmt.setBytes(4, healthNewsDetailVO.getCoverPic());
			pstmt.setString(5, healthNewsDetailVO.getStatus());
			
			pstmt.executeUpdate();

			
		// Handle any driver errors	
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			
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
	public void update(HealthNewsDetailVO healthNewsDetailVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, healthNewsDetailVO.getNewsTitle());
			pstmt.setString(2, healthNewsDetailVO.getNewsIntro());
			pstmt.setString(3, healthNewsDetailVO.getEmp_no());
			pstmt.setBytes(4, healthNewsDetailVO.getCoverPic());
			pstmt.setString(5, healthNewsDetailVO.getStatus());
			pstmt.setString(6, healthNewsDetailVO.getHealthNo());
			pstmt.executeUpdate();
		
			// Handle any driver errors	
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
				
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
	public void delete(String healthNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setString(1, healthNo);
			
			pstmt.executeUpdate();
			
			
			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public HealthNewsDetailVO findByPrimaryKey(String healthNo) {
		HealthNewsDetailVO healthNewsDetailVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
		
		
			pstmt.setString(1, healthNo);
			rs = pstmt.executeQuery();
			
			
			while (rs.next()){
				healthNewsDetailVO = new HealthNewsDetailVO();
				healthNewsDetailVO.setHealthNo(rs.getString("healthNo"));
				healthNewsDetailVO.setNewsTitle(rs.getString("newsTitle"));
				healthNewsDetailVO.setNewsIntro(rs.getString("newsIntro"));
				healthNewsDetailVO.setEmp_no(rs.getString("emp_no"));
				healthNewsDetailVO.setCoverPic(rs.getBytes("coverPic"));
				healthNewsDetailVO.setNewsDate(rs.getTimestamp("newsDate"));
				healthNewsDetailVO.setStatus(rs.getString("status"));
			}
		// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
		return healthNewsDetailVO;
	}


	@Override
	public List<HealthNewsDetailVO> getAll() {
		List<HealthNewsDetailVO> list = new ArrayList<HealthNewsDetailVO>();
		HealthNewsDetailVO healthNewsDetailVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
	
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
				
			while(rs.next()){
				healthNewsDetailVO = new HealthNewsDetailVO();
				healthNewsDetailVO.setHealthNo(rs.getString("healthNo"));
				healthNewsDetailVO.setNewsTitle(rs.getString("newsTitle"));
				healthNewsDetailVO.setNewsIntro(rs.getString("newsIntro"));
				healthNewsDetailVO.setEmp_no(rs.getString("emp_no"));
				healthNewsDetailVO.setCoverPic(rs.getBytes("coverPic"));
				healthNewsDetailVO.setNewsDate(rs.getTimestamp("newsDate"));
				healthNewsDetailVO.setStatus(rs.getString("status"));
				list.add(healthNewsDetailVO);			
			}
			
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
		
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
	
	public static void main(String[] args) throws IOException{
		
		HealthNewsDetailJDBCDAO dao = new HealthNewsDetailJDBCDAO();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		File pic = new File("WebContent/img", "notimg.jpg");
		byte[] buffer = Files.readAllBytes(pic.toPath());
		
		// 新增 *****************
//		HealthNewsDetailVO healthNewsDetailVO1 = new HealthNewsDetailVO();
//		healthNewsDetailVO1.setNewsTitle("有我罩你進駐中科，佈局國際市場");
//		healthNewsDetailVO1.setNewsIntro("全球人口高齡化的必然趨勢，促使生技醫療產業前景持續看好，我國向來致力發展生技產業，由科技部輔導廠商投入創新研發，落實科研成果產業化，並於全台設立科學園區形成生技產業聚落，有我罩你於7月25日正式進駐中部科學工業園區，成立「克弗爾肽」研發中心，擴大研發能量，進軍國際市場");
//		healthNewsDetailVO1.setEmp_no("EMP0010");
//		healthNewsDetailVO1.setCoverPic(buffer);
//		healthNewsDetailVO1.setStatus("上架");
//		dao.insert(healthNewsDetailVO1);
//		System.out.println("新增成功");
		
		
		
		// 修改
//		HealthNewsDetailVO healthNewsDetailVO2 = new HealthNewsDetailVO();
//		healthNewsDetailVO2.setHealthNo("HD0002");
//		healthNewsDetailVO2.setNewsTitle("讓我們一起學習有尊嚴的照護，熱烈報名中");
//		healthNewsDetailVO2.setNewsIntro("全球人口高齡化的必然趨勢，促使生技醫療產業前景持續看好，我國向來致力發展生技產業，由科技部輔導廠商投入創新研發，落實科研成果產業化，並於全台設立科學園區形成生技產業聚落，有我罩你於7月25日正式進駐中部科學工業園區，成立「克弗爾肽」研發中心，擴大研發能量，進軍國際市場");
//		healthNewsDetailVO2.setEmp_no("EMP0010");
//		healthNewsDetailVO2.setCoverPic(buffer);
//		healthNewsDetailVO2.setNewsDate(new Timestamp(System.currentTimeMillis()));
//		healthNewsDetailVO2.setStatus("下架");
//		dao.update(healthNewsDetailVO2);
//		System.out.println("修改成功:" + System.currentTimeMillis());
		
		
		// 查單筆
//		HealthNewsDetailVO healthNewsDetailVO3 = dao.findByPrimaryKey("HD0003");
//		System.out.println("HealthNo : " + healthNewsDetailVO3.getHealthNo() + ".");
//		System.out.println("NewsTitle : " + healthNewsDetailVO3.getNewsTitle() + ".");
//		System.out.println("NewsIntro : " + healthNewsDetailVO3.getNewsIntro() + ".");
//		System.out.println("Emp_no : " + healthNewsDetailVO3.getEmp_no() + ".");
//		System.out.println("CoverPic : " + healthNewsDetailVO3.getCoverPic() + ".");
//		System.out.println("NewsDate : " + sdf.format(healthNewsDetailVO3.getNewsDate()));
//		System.out.println("Status : " + healthNewsDetailVO3.getStatus());
//		System.out.println();
		
		

		// 查全部 *****************
//		List<HealthNewsDetailVO> list = dao.getAll();
//		for(HealthNewsDetailVO healthNewsDetailVO : list){
//			System.out.println("HealthNo : " + healthNewsDetailVO.getHealthNo());
//			System.out.println("NewsTitle : " + healthNewsDetailVO.getNewsTitle());
//			System.out.println("NewsIntro : " + healthNewsDetailVO.getNewsIntro());
//			System.out.println("Emp_no : " + healthNewsDetailVO.getEmp_no());
//			System.out.println("CoverPic : " + healthNewsDetailVO.getCoverPic());
//			System.out.println("NewsDate : " + sdf.format(healthNewsDetailVO.getNewsDate()));
//			System.out.println("Status : " + healthNewsDetailVO.getStatus());
//			System.out.println();
		}
		
		// 刪除 *****************
//		dao.delete("HD0007");
//		System.out.println("刪除成功");
		
	
}
