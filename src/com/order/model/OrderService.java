package com.order.model;

import java.util.List;



public class OrderService {

	private OrderDAO_interface dao;
	
	public OrderService(){
		dao = new OrderJDBCDAO();
	}
	
	public OrderVO getOneCarCom(String order_no){
		return dao.findByPrimaryKey(order_no);
	}
	
	public List<OrderVO> getAll(){
		return dao.getAll();
	}
}
