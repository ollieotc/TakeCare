package com.carcomplain.controller;

import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.carcomplain.model.*;
import com.order.model.*;


@WebServlet("/CarComplainServlet")
public class CarComplainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		

		
/************************************** insert **********************************************************************************/		
		
		if("insert".equals(action)){  //addCarCom.jsp請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			

			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/complain/listAllCarCom.jsp】 或 
			req.setAttribute("requestURL", requestURL); // 送出修改的來源網頁路徑, 存入req (是為了給update_car_input.jsp)
			
			String whichPage = req.getParameter("whichPage");
			req.setAttribute("whichPage", whichPage);   // 送出修改的來源網頁的第幾頁, 存入req(只用於:listAllCarcom.jsp)
			
	
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				
				//  申訴單號
				String order_no = req.getParameter("order_no");
				System.out.println("============"+order_no);
			
				// 申訴內容
				String complainDetail = req.getParameter("complainDetail");
				System.out.println("============"+complainDetail+"============");
				if(complainDetail == null || complainDetail.trim().length() ==0){
					errorMsgs.add("申訴內容請勿空白");
				}
										
				CarComplainVO carComplainVO = new CarComplainVO();
				carComplainVO.setOrder_no(order_no);
				carComplainVO.setComplainDetail(complainDetail);
				carComplainVO.setComplainStatus("未處理");
				
				
				// Send the use back to the form, if there were errors
				if(!errorMsgs.isEmpty()){
					req.setAttribute("carComplainVO", carComplainVO);  //含有輸入格式錯誤的carComplainVO,也存入req
					System.out.println(order_no);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front/carcomplain/addCarCom.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				

				/***************************2.開始修改資料*****************************************/
				CarComplainService carComplainSvc = new CarComplainService();
				carComplainVO = carComplainSvc.addCarCom(order_no, complainDetail, "未處理");
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				
//				String url ="/front/carcomplain/listAllOrder.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listAllOrder.jsp
//				successView.forward(req, res);
				
				
				req.setAttribute("carComplainVO", carComplainVO); // 資料庫update成功後,正確的的empVO物件,存入req
//				
				String url = requestURL+"?whichPage="+whichPage+"&order_no="+order_no; // 送出修改的來源網頁的第幾頁(只用於:listAllCarCom.jsp)和修改的是哪一筆
				System.out.println("requestURL:"+requestURL+"------------"+"order_no:"+order_no);
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);
			
				/***************************其他可能的錯誤處理*************************************/
			
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front/carcomplain/addCarCom.jsp");
				failureView.forward(req, res);
				
			
			}
		}
		
		  
/************************************** getOne_For_Updat_car **********************************************************************************/		

		if ("getOne_For_Updat_car".equals(action)) { // 來自listAllCarCom.jsp 或  的請求

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
				
				String complainNo = req.getParameter("complainNo");
				String order_no = req.getParameter("order_no");
				
				/***************************2.開始查詢資料****************************************/
				CarComplainService carComplainSvc = new CarComplainService();
				CarComplainVO carComplainVO = carComplainSvc.getOneCarCom(complainNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("carComplainVO", carComplainVO); // 資料庫取出的carComplainV物件,存入req
				String url = "/back/complain/update_car_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料取出時失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(requestURL);
				failureView.forward(req, res);
			}
		}
		
		
		
		
		
/************************************** getOne_For_Display **********************************************************************************/		

		
		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

		
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				
				String complainNo = req.getParameter("complainNo");
				
				/***************************2.開始查詢資料*****************************************/
				CarComplainService carComplainSvc = new CarComplainService();
				CarComplainVO carComplainVO = carComplainSvc.getOneCarCom(complainNo);
				
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("carComplainVO", carComplainVO); // 資料庫取出的carComplainV物件,存入req
				String url = "/back/complain/listOneCarCom.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交update_emp_input.jsp
				successView.forward(req, res);

		}
		
		
/************************************** delete **********************************************************************************/		

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/complain/listAllCarCom.jsp】 或 
			
			String whichPage = req.getParameter("whichPage");
			
			
			try {
				/***************************1.接收請求參數***************************************/
				String complainNo = req.getParameter("complainNo");
						
				/***************************2.開始刪除資料***************************************/
				CarComplainService carComplainSvc = new CarComplainService();
				carComplainSvc.deleteCarCom(complainNo);
						
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				
				String url = requestURL+"?whichPage="+whichPage+"&complianNo="+complainNo; // 送出修改的來源網頁的第幾頁(只用於:listAllCarCom.jsp)和修改的是哪一筆
				System.out.println("requestURL:"+requestURL+"------------"+"complainNo:"+complainNo);
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);
					
				/***************************其他可能的錯誤處理**********************************/
				} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
								.getRequestDispatcher("/back/newsdetail/listAllNewsdetail.jsp");
				failureView.forward(req, res);
			}
		}
				
	
/************************************** update **********************************************************************************/		
		
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
			
			String whichPage = req.getParameter("whichPage"); // 送出修改的來源網頁的第幾頁(只用於:istAllEmp.jsp)
			
			System.out.println("requestURL:"+requestURL+"------------"+"complainNo:"+whichPage);
			
			
			
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String complainNo = req.getParameter("complainNo");
				System.out.println("=========" + complainNo);
				
				String order_no = req.getParameter("order_no");
				System.out.println("=========" + order_no);
				
//				Timestamp detailDate = Timestamp.valueOf(req.getParameter("detailDate"));
//				System.out.println("========="+ detailDate);
				
				String complainDetail = req.getParameter("complainDetail");
				
//				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh24:mm:ss");
			
				
				
				
				String complainReply = req.getParameter("complainReply");
				if( complainReply == null || complainReply.trim().length() ==0){
					errorMsgs.add("回覆內容請勿留空");
				}
				
				Timestamp replyDate = new Timestamp(System.currentTimeMillis());
				
				String emp_no = req.getParameter("emp_no");
				
				String complainStatus = req.getParameter("complainStatus");
				
				
				
				
				CarComplainVO carComplainVO = new CarComplainVO();
				carComplainVO.setComplainNo(complainNo);
				carComplainVO.setOrder_no(order_no);
				carComplainVO.setComplainDetail(complainDetail);
				//carComplainVO.setDetailDate(detailDate);
				carComplainVO.setComplainReply(complainReply);
				carComplainVO.setReplyDate(replyDate);
				carComplainVO.setEmp_no(emp_no);
				carComplainVO.setComplainStatus(complainStatus);
						
				
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("carComplainVO", carComplainVO); // 含有輸入格式錯誤的carComplainVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/complain/update_car_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				CarComplainService carComplainSvc = new CarComplainService();
				carComplainVO = carComplainSvc.updateCarCom(complainNo, complainReply,replyDate, "EMP0001" ,"已完成");
				
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("carComplainVO", carComplainVO); // 資料庫update成功後,正確的的empVO物件,存入req
//				String url = "/back/complain/listAllCarCom.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
//				successView.forward(req, res);
				
//				if(requestURL.equals("/back/complain/listAllCarCom.jsp"))
//					req.setAttribute("carlist",carComplainSvc.getOneCarCom(complainNo)); // 資料庫取出的list物件,存入request
//				
				String url = requestURL+"?whichPage="+whichPage+"&complianNo="+complainNo; // 送出修改的來源網頁的第幾頁(只用於:listAllCarCom.jsp)和修改的是哪一筆
				System.out.println("requestURL:"+requestURL+"------------"+"complainNo:"+complainNo);
				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/complain/update_car_input.jsp");
				failureView.forward(req, res);
			}
		}
	
	}

}
