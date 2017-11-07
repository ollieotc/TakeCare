package com.order.controller;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.carcomplain.model.*;
import com.order.model.*;

@WebServlet("/OrderService")
public class OrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		
/************************************** getOne_For_Update **********************************************************************************/		
		if ("getOne_For_Update".equals(action) || ("listOrder_Byadd".equals(action))) { // 來自listAllOrder.jsp 或  /dept/listEmps_ByDeptno.jsp 的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/complain/listAllCarCom.jsp】 或 
			req.setAttribute("requestURL", requestURL); // 送出修改的來源網頁路徑, 存入req (是為了給update_car_input.jsp)
			
			String whichPage = req.getParameter("whichPage");
			req.setAttribute("whichPage", whichPage);   // 送出修改的來源網頁的第幾頁, 存入req(只用於:listAllCarcom.jsp)
			
			
			try {
				/***************************1.接收請求參數****************************************/
				String order_no = new String(req.getParameter("order_no"));
				
				/***************************2.開始查詢資料****************************************/
				OrderService orderSvc = new OrderService();
				OrderVO orderVO = orderSvc.getOneCarCom(order_no);
				
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("orderVO", orderVO); // 資料庫取出的orderVO物件,存入req
				
				String url = null;
				if ("getOne_For_Update".equals(action))
					url = "/front/carcomplain/addCarCom.jsp";        // 成功轉交 addCarCom.jsp
				else if ("listOrder_Byadd".equals(action))
					url = "/front/carcomplain/listOrder.jsp";   // 成功轉交 listAllOrder.jsp
				
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交addCarCom.jsp
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				throw new ServletException(e);
			}
		}
				
	}

}
