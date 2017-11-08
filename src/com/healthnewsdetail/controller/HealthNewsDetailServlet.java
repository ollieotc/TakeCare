package com.healthnewsdetail.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.healthnewsdetail.model.*;

@WebServlet("/HealthNewsDetailServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 100 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class HealthNewsDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		
/************************************** insert **********************************************************************************/		
		
		if("insert".equals(action)){
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String newsTitle = req.getParameter("newsTitle");
				if( newsTitle == null || newsTitle.trim().length() ==0){
					errorMsgs.add("文章標題請勿空白");
				}
				
				String newsIntro = req.getParameter("newsIntro");
				if( newsIntro == null || newsIntro.trim().length() ==0){
					errorMsgs.add("文章內容請勿留空");
				}
				
				String emp_no = req.getParameter("emp_no");
				String status = req.getParameter("status");
				
				byte[] coverPic = null;
				Part part = req.getPart("coverPic");
				coverPic = getPictureByteArray(part);
				if( part == null || part.getSize()==0 ){
					errorMsgs.add("請上傳照片");
				}
				System.out.println("aaaaaaaaaaaaaa" + part);
				
				
				HealthNewsDetailVO healthNewsDetailVO = new HealthNewsDetailVO();
				healthNewsDetailVO.setNewsTitle(newsTitle);
				healthNewsDetailVO.setNewsIntro(newsIntro);
				healthNewsDetailVO.setEmp_no(emp_no);
				healthNewsDetailVO.setCoverPic(coverPic);
				healthNewsDetailVO.setStatus(status);
				
				
				// Send the use back to the form, if there were errors
				if(!errorMsgs.isEmpty()){
					req.setAttribute("healthNewsDetailVO", healthNewsDetailVO); // 含有輸入格式錯誤的HealthNewsDetailVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/healthnewsdetail/addNewsdetail.jsp");
					failureView.forward(req, res);
					return;
				}
				
				
				/***************************2.開始新增資料***************************************/
				
				HealthNewsDetailService healthNewsDetailSvc = new HealthNewsDetailService();
				healthNewsDetailVO = healthNewsDetailSvc.addHeaNews(newsTitle, newsIntro, emp_no , coverPic , status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back/healthnewsdetail/listAllNewsdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllNews.jsp
				successView.forward(req,res);	
				
				/***************************其他可能的錯誤處理**********************************/
			} catch(Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back/healthnewsdetail/addNewsdetail.jsp");
				failureView.forward(req,res);
				System.out.println("*******************");
			}
		
				
		}
		
		
/************************************** 查詢單個 getOne_For_Display **********************************************************************************/		
		
		if("getOne_For_Display".equals(action)){
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String healthNo = req.getParameter("healthNo");
				if (healthNo == null || (healthNo.trim()).length() == 0) {
					errorMsgs.add("請輸入文章編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/healthnewsdetail/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				HealthNewsDetailService healthNewsDetailSvc = new HealthNewsDetailService();
				HealthNewsDetailVO healthNewsDetailVO = healthNewsDetailSvc.getOneNews(healthNo);
				if (healthNo == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/healthnewsdetail/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("healthNewsDetailVO", healthNewsDetailVO); // 資料庫取出的empVO物件,存入req
				String url = "/back/healthnewsdetail/listOneNewsdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/healthnewsdetail/select_page.jsp");
				failureView.forward(req, res);
			}
		
		}
		
		
		
		
/**************************************  getOne_For_Update **********************************************************************************/		
				
		if ("getOne_For_Update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】		
			
			try {
				/***************************1.接收請求參數****************************************/
				String healthNo = req.getParameter("healthNO");
				
				/***************************2.開始查詢資料****************************************/
				HealthNewsDetailService healthNewsDetailSvc = new HealthNewsDetailService();
				HealthNewsDetailVO healthNewsDetailVO = healthNewsDetailSvc.getOneNews(healthNo);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("healthNewsDetailVO", healthNewsDetailVO); // 資料庫取出的empVO物件,存入req
				String url = requestURL;
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
		
		
/**************************************  update **********************************************************************************/		
		
		
//		if ("update".equals(action)) { // 來自update_newsdetail_input.jsp的請求
//			
//			List<String> errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//			
//			String requestURL = req.getParameter("requestURL"); // 送出修改的來源網頁路徑: 可能為【/emp/listAllEmp.jsp】 或  【/dept/listEmps_ByDeptno.jsp】 或 【 /dept/listAllDept.jsp】
//		
//			try {
//				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
//				Integer empno = new Integer(req.getParameter("empno").trim());
//				String ename = req.getParameter("ename").trim();
//				String job = req.getParameter("job").trim();				
//				
//				java.sql.Date hiredate = null;
//				try {
//					hiredate = java.sql.Date.valueOf(req.getParameter("hiredate").trim());
//				} catch (IllegalArgumentException e) {
//					hiredate=new java.sql.Date(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}
//
//				Double sal = null;
//				try {
//					sal = new Double(req.getParameter("sal").trim());
//				} catch (NumberFormatException e) {
//					sal = 0.0;
//					errorMsgs.add("薪水請填數字.");
//				}
//
//				Double comm = null;
//				try {
//					comm = new Double(req.getParameter("comm").trim());
//				} catch (NumberFormatException e) {
//					comm = 0.0;
//					errorMsgs.add("獎金請填數字.");
//				}
//
//				Integer deptno = new Integer(req.getParameter("deptno").trim());
//
//				EmpVO empVO = new EmpVO();
//				empVO.setEmpno(empno);
//				empVO.setEname(ename);
//				empVO.setJob(job);
//				empVO.setHiredate(hiredate);
//				empVO.setSal(sal);
//				empVO.setComm(comm);
//				empVO.setDeptno(deptno);
//
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					req.setAttribute("empVO", empVO); // 含有輸入格式錯誤的empVO物件,也存入req
//					RequestDispatcher failureView = req
//							.getRequestDispatcher("/emp/update_emp_input.jsp");
//					failureView.forward(req, res);
//					return; //程式中斷
//				}
//				
//				/***************************2.開始修改資料*****************************************/
//				EmpService empSvc = new EmpService();
//				empVO = empSvc.updateEmp(empno, ename, job, hiredate, sal,comm, deptno);
//				
//				/***************************3.修改完成,準備轉交(Send the Success view)*************/				
//				DeptService deptSvc = new DeptService();
//				if(requestURL.equals("/dept/listEmps_ByDeptno.jsp") || requestURL.equals("/dept/listAllDept.jsp"))
//					req.setAttribute("listEmps_ByDeptno",deptSvc.getEmpsByDeptno(deptno)); // 資料庫取出的list物件,存入request
//
//                String url = requestURL;
//				RequestDispatcher successView = req.getRequestDispatcher(url);   // 修改成功後,轉交回送出修改的來源網頁
//				successView.forward(req, res);
//
//				/***************************其他可能的錯誤處理*************************************/
//			} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/emp/update_emp_input.jsp");
//				failureView.forward(req, res);
//			}
//		}

		
	}
	
	
	
	public static byte[] getPictureByteArray(Part part) throws IOException{
		
		InputStream in = part.getInputStream();
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[in.available()]; //自動緩衝區
		int i;
		while((i = in.read(buffer)) != -1){
			baos.write(buffer, 0, i); // (哪個陣列,開始索引值,緩衝區資料大小)
		}
		baos.close();
		in.close();
		
		return baos.toByteArray();
		
	}
//	
//	public String getFileNameFromPart(Part part) {
//		String header = part.getHeader("content-disposition");
////		System.out.println("header=" + header); // 測試用
//		String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
////		System.out.println("filename=" + filename); // 測試用
//		if (filename.length() == 0) {
//			return null;
//			}
//		return filename;
//		}
	

}

	



