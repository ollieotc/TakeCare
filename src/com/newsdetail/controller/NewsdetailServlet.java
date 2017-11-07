package com.newsdetail.controller;

import java.io.*;
import java.sql.Timestamp;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


import com.newsdetail.model.*;



@WebServlet("/NewsdetailServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 100 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)
public class NewsdetailServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
/************************************** insert **********************************************************************************/		
	
		if("insert".equals(action)){  // 來自addNewsdetail.jsp的請求 
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try{
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String newstitle = req.getParameter("newstitle");
				if( newstitle == null || newstitle.trim().length() ==0){
					errorMsgs.add("文章標題請勿空白");
				}
				
				String newsintro = req.getParameter("newsintro");
				if( newsintro == null || newsintro.trim().length() ==0){
					errorMsgs.add("文章內容請勿留空");
				}
				
				String empno = new String(req.getParameter("empno").trim());
				
				String status = new String(req.getParameter("status"));
				
				Part img = req.getPart("coverpic");
				byte[] coverpic = getPictureByteArray(img);
				System.out.println(coverpic);
				
				
				NewsdetailVO newsdetailVO = new NewsdetailVO();
				newsdetailVO.setNewstitle(newstitle);
				newsdetailVO.setNewsintro(newsintro);
				newsdetailVO.setEmpno(empno);
				newsdetailVO.setCoverpic(coverpic);
				newsdetailVO.setStatus(status);
				
				
				// Send the use back to the form, if there were errors
				if(!errorMsgs.isEmpty()){
					// 含有輸入格式錯誤的newsdetailVO物件,也存入req
					req.setAttribute("newsdetailVO", newsdetailVO);
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/newsdetail/addNewsdetail.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				
				NewsdetailService newsdetailSvc = new NewsdetailService();
				newsdetailVO = newsdetailSvc.addNews(newstitle, newsintro, empno, coverpic, status);
				
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/back/newsdetail/listAllNewsdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllNews.jsp
				successView.forward(req,res);	
				
			} catch(Exception e){
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back/newsdetail/addNewsdetail.jsp");
				failureView.forward(req,res);
			}
			
		}
		
		
/************************************** update **********************************************************************************/		

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
		
			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String newsno = req.getParameter("newsno").trim();
				
				String newstitle = req.getParameter("newstitle");
				if( newstitle == null || newstitle.trim().length() ==0){
					errorMsgs.add("文章標題請勿空白");
				}
				
				String newsintro = req.getParameter("newsintro");
				if( newsintro == null || newsintro.trim().length() ==0){
					errorMsgs.add("文章內容請勿留空");
				}
				
				String empno = new String(req.getParameter("empno").trim());
				
				Part img = req.getPart("coverpic");
				byte[] coverpic = null;
				if (coverpic.length ==0 ){
					
				} else {
					
				}
				
				
				Timestamp newsdate = new Timestamp(System.currentTimeMillis());
				
				String status = new String(req.getParameter("status"));

				NewsdetailVO newsdetailVO = new NewsdetailVO();
				newsdetailVO.setNewsno(newsno);
				newsdetailVO.setNewstitle(newstitle);
				newsdetailVO.setNewsintro(newsintro);
				newsdetailVO.setEmpno(empno);
//				newsdetailVO.setCoverpic(coverpic);
				newsdetailVO.setNewsdate(newsdate);
				newsdetailVO.setStatus(status);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("newsdetailVO", newsdetailVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/newsdetail/update_newsdetail_input.jsp");
					failureView.forward(req, res);
					return; //程式中斷
				}
				
				/***************************2.開始修改資料*****************************************/
				NewsdetailService newsdetailSvc = new NewsdetailService();
				newsdetailVO = newsdetailSvc.updateNews(newsno, newstitle, newsintro, empno ,newsdate, status);
								
				/***************************3.修改完成,準備轉交(Send the Success view)*************/
				req.setAttribute("newsdetailVO", newsdetailVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back/newsdetail/listOneNewsdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:"+e.getMessage());
				
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/newsdetail/update_newsdetail_input.jsp");
				failureView.forward(req, res);
			}
		}
		
/************************************** getOne_For_Display **********************************************************************************/		
				
		if("getOne_For_Display".equals(action)){ // 來自select_page.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			
			try{
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("newsno");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入文章編號");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/newsdetail/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				String newsno = null;
				try {
					newsno = new String(str);
				} catch (Exception e) {
					errorMsgs.add("文章編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/newsdetail/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				/***************************2.開始查詢資料*****************************************/
				NewsdetailService newsdetailSvc = new NewsdetailService();
				NewsdetailVO newsdetailVO = newsdetailSvc.getOneNews(newsno);
				if (newsdetailVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back/newsdetail/select_page.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("newsdetailVO", newsdetailVO); // 資料庫取出的newsdetailVO物件,存入req
				String url = "/back/newsdetail/listOneNewsdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch(Exception e){
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/newsdetail/select_page.jsp");
				failureView.forward(req, res);	
				
			}
			
		}
		
		
		
/************************************** getOne_For_Update **********************************************************************************/		
	
		if ("getOne_For_Update".equals(action)) { // 來自listAllNewsdetail.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				String newsno = new String(req.getParameter("newsno"));
				
				/***************************2.開始查詢資料****************************************/
				NewsdetailService newsdetailSvc = new NewsdetailService();
				NewsdetailVO newsdetailVO = newsdetailSvc.getOneNews(newsno);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("newsdetailVO", newsdetailVO);         // 資料庫取出的newsdetailVO物件,存入req
				String url = "/back/newsdetail/update_newsdetail_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_newsdetail_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/newsdetail/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}

		

		
		
/************************************** delete **********************************************************************************/		

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				String newsno = new String(req.getParameter("newsno"));
				
				/***************************2.開始刪除資料***************************************/
				NewsdetailService newsdetailSvc = new NewsdetailService();
				newsdetailSvc.deleteNews(newsno);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/back/newsdetail/listAllNewsdetail.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back/newsdetail/listAllNewsdetail.jsp");
				failureView.forward(req, res);
			}
		}
	}
	public static byte[] getPictureByteArray(Part part) throws IOException{
		
		InputStream in = part.getInputStream();
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buffer = new byte[8192]; //自動緩衝區
		int i;
		while((i = in.read(buffer)) != -1){
			baos.write(buffer, 0, i); // (哪個陣列,開始索引值,緩衝區資料大小)
		}
		baos.close();
		in.close();
		
		return baos.toByteArray();
		
	}	
}	

