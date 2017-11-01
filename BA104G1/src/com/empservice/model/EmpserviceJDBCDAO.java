package com.empservice.model;

import java.sql.*;

public class EmpserviceJDBCDAO implements EmpserviceDAO_interface{
	
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@13.229.86.22:1521:XE";
//	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String userid = "ba104g1";
	String passwd = "ba104g1";
	
	// 新增
	private static final String INSERT_STMT =
			"INSERT INTO EMPSERVICEDETAIL(EMPSEVNO, EMP_NO, EMPSEVIMG, EMPSEVINTRO, EMPSEVSTATUS, MEM_NO) VALUES(to_char('ESV' || LPAD(to_char(EMPSEVNO_SEQ.NEXTVAL),6,'0')),?, ?, ?, ?, ?, ?)";
	// 查全部
	private static final String GET_ALL_STMT = 
			"SELECT EMPSEVNO, EMO_NO, EMPSEVIMG, EMPSEVINTRO, EMPSEVDATE, EMPSEVSTATUS, MEM_NO FROM EMPSERVICEDETAIL ORDER BY EMPSEVNO";
	
	// 查詢會員編號紀錄
	private static final String GET_MEMONE_STMT =
			"SELECT EMPSEVNO, EMO_NO, EMPSEVIMG, EMPSEVINTRO, EMPSEVDATE, EMPSEVSTATUS, MEM_NO FROM EMPSERVICEDETAIL WHERE MEM_NO = ?";
	
	// 查詢員工編號紀錄
	private static final String GET_EMPONE_STMT =
			"SELECT EMPSEVNO, EMO_NO, EMPSEVIMG, EMPSEVINTRO, EMPSEVDATE, EMPSEVSTATUS, MEM_NO FROM EMPSERVICEDETAIL WHERE EMP_NO = ?";
	
	
	
	@Override
	public void insert(EmpserviceVO empserviceVO){
		
	}
	
	@Override
	public EmpserviceVO findByPrimaryKey(String mem_no){
		EmpserviceVO empserviceVO = null;
		Connection con = null;
		PreparedStatement  pstmt = null;
		ResultSet rs = null;
		
	}
	

}
