package com.empservice.model;

import java.sql.Timestamp;

public class EmpserviceVO {
	
	private String emosevno;
	private String emp_no;
	private byte[] empsevimg;
	private String empsevintro;
	private Timestamp empsevdate;
	private String empsevstatus;
	private String mem_no;
	
	
	public String getEmosevno() {
		return emosevno;
	}
	public void setEmosevno(String emosevno) {
		this.emosevno = emosevno;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public byte[] getEmpsevimg() {
		return empsevimg;
	}
	public void setEmpsevimg(byte[] empsevimg) {
		this.empsevimg = empsevimg;
	}
	public String getEmpsevintro() {
		return empsevintro;
	}
	public void setEmpsevintro(String empsevintro) {
		this.empsevintro = empsevintro;
	}
	public Timestamp getEmpsevdate() {
		return empsevdate;
	}
	public void setEmpsevdate(Timestamp empsevdate) {
		this.empsevdate = empsevdate;
	}
	public String getEmpsevstatus() {
		return empsevstatus;
	}
	public void setEmpsevstatus(String empsevstatus) {
		this.empsevstatus = empsevstatus;
	}
	public String getMem_no() {
		return mem_no;
	}
	public void setMem_no(String mem_no) {
		this.mem_no = mem_no;
	}
	

}
