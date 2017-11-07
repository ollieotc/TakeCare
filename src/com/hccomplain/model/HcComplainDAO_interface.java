package com.hccomplain.model;

import java.util.List;


public interface HcComplainDAO_interface {
	public void insert(HcComplainVO hcComplainVO);
	public void update(HcComplainVO hcComplainVO);
	public HcComplainVO findByPrimaryKey(String complainNo);
	public List<HcComplainVO> getAll();

}
