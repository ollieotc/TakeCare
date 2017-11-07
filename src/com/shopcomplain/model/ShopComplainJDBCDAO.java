package com.shopcomplain.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


public class ShopComplainJDBCDAO implements ShopComplainDAO_interface{

	String driver = "oracle.jdbc.driver.OracleDriver";
	String userid = "ba104g1";
	String passwd = "ba104g1";
	
//	// ************** AWS **************
//	String url = "jdbc:oracle:thin:@13.229.86.22:1521:XE";
	// ************** BA104 **************
	String url = "jdbc:oracle:thin:@10.120.25.6:1521:XE";
//	// ************* Localhost **********
//	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
	

	// 新增申訴
	private static final String INSERT_STMT = 
			"INSERT INTO SHOPCOMPLAIN (COMPLAINNO, ORDERNO, COMPLAINDETAIL, COMPLAINSTATUS) VALUES (to_char('SP'||LPAD(to_char(SHOPCOM_NO_SEQ.NEXTVAL),6,'0')), ?, ?, ? )";
	
	// 修改申訴
	private static final String UPDATE = 
			"UPDATE SHOPCOMPLAIN SET COMPLAINREPLY=?, REPLYDATE=CURRENT_TIMESTAMP, EMP_NO =?, COMPLAINSTATUS =? WHERE COMPLAINNO = ?";
	
	// 查全部申訴
	private static final String GET_ALL_STMT =
			"SELECT COMPLAINNO, ORDERNO, COMPLAINDETAIL, DETAILDATE , COMPLAINREPLY, REPLYDATE, EMP_NO ,COMPLAINSTATUS FROM SHOPCOMPLAIN ORDER BY COMPLAINNO";
	
	// 申訴單號單一查詢
	private static final String GET_ONE_STMT = 
			"SELECT COMPLAINNO, ORDERNO, COMPLAINDETAIL, DETAILDATE , COMPLAINREPLY, REPLYDATE, EMP_NO ,COMPLAINSTATUS  FROM SHOPCOMPLAIN WHERE COMPLAINNO=?";

	
	
	
	@Override
	public void insert(ShopComplainVO shopComplainVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);
			
			pstmt.setString(1, shopComplainVO.getOrderno());
			pstmt.setString(2, shopComplainVO.getComplainDetail());
			pstmt.setString(3, shopComplainVO.getComplainStatus());
			pstmt.executeQuery();
			
		// Handle any driver errors		
		} catch (ClassNotFoundException e){
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
				try{
					con.close();
				} catch(Exception e){
					e.printStackTrace(System.err);
				}
			}
		}
	}
	

	@Override
	public void update(ShopComplainVO shopComplainVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try{
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, shopComplainVO.getComplainReply());
			pstmt.setString(2, shopComplainVO.getEmp_no());
			pstmt.setString(3, shopComplainVO.getComplainStatus());
			pstmt.setString(4, shopComplainVO.getComplainNo());
			
			pstmt.executeQuery();
		
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
	public ShopComplainVO findByPrimaryKey(String complainNo) {
		ShopComplainVO shopComplainVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, complainNo);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				shopComplainVO = new ShopComplainVO();
				shopComplainVO.setComplainNo(rs.getString("complainno"));
				shopComplainVO.setOrderno(rs.getString("orderno"));
				shopComplainVO.setComplainDetail(rs.getString("complaindetail"));
				shopComplainVO.setDetailDate(rs.getTimestamp("detaildate"));
				shopComplainVO.setComplainReply(rs.getString("complainreply"));
				shopComplainVO.setReplyDate(rs.getTimestamp("replydate"));
				shopComplainVO.setEmp_no(rs.getString("emp_no"));
				shopComplainVO.setComplainStatus(rs.getString("complainstatus"));
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
		return shopComplainVO;
	}

	@Override
	public List<ShopComplainVO> getAll() {
		
		List<ShopComplainVO> list = new ArrayList<ShopComplainVO>();
		ShopComplainVO shopComplainVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				shopComplainVO = new ShopComplainVO();
				shopComplainVO.setComplainNo(rs.getString("complainno"));
				shopComplainVO.setOrderno(rs.getString("orderno"));
				shopComplainVO.setComplainDetail(rs.getString("complaindetail"));
				shopComplainVO.setDetailDate(rs.getTimestamp("detaildate"));
				shopComplainVO.setComplainReply(rs.getString("complainreply"));
				shopComplainVO.setReplyDate(rs.getTimestamp("replydate"));
				shopComplainVO.setEmp_no(rs.getString("emp_no"));
				shopComplainVO.setComplainStatus(rs.getString("complainstatus"));
				list.add(shopComplainVO);
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
	
	
	
	public static void main(String[] args){
		
		ShopComplainJDBCDAO dao = new ShopComplainJDBCDAO();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		
		// 新增
//		ShopComplainVO shopComplainVO1 = new ShopComplainVO();
//		shopComplainVO1.setOrderno("20171103-000002");
//		shopComplainVO1.setComplainDetail("TESt");
//		shopComplainVO1.setComplainStatus("未處理");
//		dao.insert(shopComplainVO1);
//		System.out.println("新增成功");
		
		
		// 修改
//		ShopComplainVO shopComplainVO2 = new ShopComplainVO();
//		shopComplainVO2.setComplainNo("SP000001");
//		shopComplainVO2.setEmp_no("EMP0001");	
//		shopComplainVO2.setComplainReply("小天使來解答,我們會再跟進!!!!");
//		shopComplainVO2.setComplainStatus("已完成");
//		dao.update(shopComplainVO2);
//		System.out.println("修改成功阿阿阿阿阿");
		
		
		
		// 查單個
		ShopComplainVO shopComplainVO3 = dao.findByPrimaryKey("SP000001");
		System.out.println("ComplainNo : " + shopComplainVO3.getComplainNo());
		System.out.println("OrderNO : " + shopComplainVO3.getOrderno());
		System.out.println("ComplainDetail : " + shopComplainVO3.getComplainDetail());
		System.out.println("DetailDate : " + sdf.format(shopComplainVO3.getDetailDate()));
		System.out.println("ComplainReply : " + shopComplainVO3.getComplainReply());
		System.out.println("ReplyDate : " + sdf.format(shopComplainVO3.getReplyDate()));
		System.out.println("EmpNO : " + shopComplainVO3.getEmp_no());
		System.out.println("Status : " + shopComplainVO3.getComplainStatus());
		System.out.println();
		
		
		// 查全部
//		List<ShopComplainVO> list = dao.getAll();
//		for(ShopComplainVO shopComplainVO : list){
//			System.out.println("ComplainNo : " + shopComplainVO.getComplainNo());
//			System.out.println("OrderNO : " + shopComplainVO.getOrderno());
//			System.out.println("ComplainDetail : " + shopComplainVO.getComplainDetail());
//			System.out.println("DetailDate : " + sdf.format(shopComplainVO.getDetailDate()));
//			System.out.println("ComplainReply : " + shopComplainVO.getComplainReply());
//			System.out.println("ReplyDate : " + sdf.format(shopComplainVO.getReplyDate()));
//			System.out.println("EmpNO : " + shopComplainVO.getEmp_no());
//			System.out.println("Status : " + shopComplainVO.getComplainStatus());
//			System.out.println();
//		}
	}

}
