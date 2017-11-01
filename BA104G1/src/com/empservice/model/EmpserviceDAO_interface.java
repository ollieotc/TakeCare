package com.empservice.model;

import java.util.List;

public interface EmpserviceDAO_interface {
	public void insert(EmpserviceVO empserviceVO);
	public EmpserviceVO findByPrimaryKey(String mem_no);
	public List<EmpserviceVO> getAll();

}
