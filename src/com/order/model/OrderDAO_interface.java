package com.order.model;

import java.util.List;


public interface OrderDAO_interface {
	public OrderVO findByPrimaryKey(String order_no);
	public List<OrderVO> getAll();
	

}
