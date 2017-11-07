package com.order.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderJDBCDAO implements OrderDAO_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String userid = "ba104g1";
	String passwd = "ba104g1";
	
//	// ************** AWS **************
//	String url = "jdbc:oracle:thin:@13.229.86.22:1521:XE";
	// ************** BA104 **************
//	String url = "jdbc:oracle:thin:@10.120.25.6:1521:XE";
//	// ************* Localhost **********
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	
	

	// 查全部訂單
	private static final String GET_ALL_STMT =
			"SELECT ORDER_NO, MEM_NO, ORDER_DATE, ORDER_STATUS FROM CAR_ORDER ORDER BY ORDER_NO";

	// 訂單單號單一查詢
	private static final String GET_ONE_STMT = 
			"SELECT ORDER_NO, MEM_NO, ORDER_DATE, ORDER_STATUS FROM CAR_ORDER WHERE ORDER_NO=?";

	
	
	
	@Override
	public OrderVO findByPrimaryKey(String order_no) {
		OrderVO orderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
			pstmt.setString(1, order_no);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				orderVO = new OrderVO();
				orderVO.setOrder_no(rs.getString("order_no"));
				orderVO.setMem_no(rs.getString("mem_no"));
				orderVO.setOrder_date(rs.getDate("order_date"));
				orderVO.setOrder_status(rs.getString("order_status"));
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
		return orderVO;
	}
	
	@Override
	public List<OrderVO> getAll() {
		List<OrderVO> list = new ArrayList<OrderVO>();
		OrderVO orderVO = null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				orderVO = new OrderVO();
				orderVO.setOrder_no(rs.getString("order_no"));
				orderVO.setMem_no(rs.getString("mem_no"));
				orderVO.setOrder_date(rs.getDate("order_date"));
				orderVO.setOrder_status(rs.getString("order_status"));
				list.add(orderVO);
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
			
			
			OrderJDBCDAO dao = new OrderJDBCDAO();
			
			
			// 查單個
//			OrderVO orderVO1 = dao.findByPrimaryKey("20171102-000011");
//			System.out.println("orderno :" + orderVO1.getOrder_no());
//			System.out.println("memno :" + orderVO1.getMem_no());
//			System.out.println("date : " + orderVO1.getOrder_date());
//			System.out.println("status :" + orderVO1.getOrder_status());
//			System.out.println();
			
			List<OrderVO> list = dao.getAll();
			for(OrderVO orderVO : list){
				System.out.println("orderno :" + orderVO.getOrder_no());
				System.out.println("memno :" + orderVO.getMem_no());
				System.out.println("date : " + orderVO.getOrder_date());
				System.out.println("status :" + orderVO.getOrder_status());
			}
		}
	}
