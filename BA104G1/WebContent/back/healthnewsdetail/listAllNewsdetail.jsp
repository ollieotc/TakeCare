<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.healthnewsdetail.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>



<%  HealthNewsDetailService healthNewsDetailSvc = new HealthNewsDetailService();
	List<HealthNewsDetailVO> list = healthNewsDetailSvc.getAll();
	pageContext.setAttribute("list",list);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	pageContext.setAttribute("sdf",sdf);
%>



<html>
<head>
<title>所有保健資訊資料 - listAllNewsdetail.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>


<table id="table-1">
	<tr><td>
		 <h3>所有保健資訊資料  - listAllNewsdetail.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/healthnewsdetail/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>文章編號</th>
		<th>文章標題</th>
		<th>文章內容</th>
		<th>員工編號</th>
		<th>文章照片</th>
		<th>修改時間</th>
		<th>文章狀態</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="healthNewsDetailVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		 <tr align='center' valign='middle' ${(healthNewsDetailVO.healthNo == param.healthNo) ? 'bgcolor=#FF7744':''}>
			<td>${healthNewsDetailVO.healthNo}</td>
			<td>${healthNewsDetailVO.newsTitle}</td>
			<td>${healthNewsDetailVO.newsIntro}</td>
			<td>${healthNewsDetailVO.emp_no}</std>
			<td><img src="<%=request.getContextPath()%>/healthnewsdetail/healthimgread.do?healthNo=${healthNewsDetailVO.healthNo}" style= max-width:70px;max-height:70px; ></td>
			<td>${sdf.format(healthNewsDetailVO.newsDate)}</td>
			<td>${healthNewsDetailVO.status}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/healthnewsdetail/healthnewsdetail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="healthNo"   value="${healthNewsDetailVO.healthNo}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/healthnewsdetail/healthnewsdetail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="healthNo"   value="${healthNewsDetailVO.healthNo}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>