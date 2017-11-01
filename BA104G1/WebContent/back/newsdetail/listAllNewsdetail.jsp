<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.newsdetail.model.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>



<%  NewsdetailService newsdetailSvc = new NewsdetailService();
	List<NewsdetailVO> list = newsdetailSvc.getAll();
	pageContext.setAttribute("list",list);
%>



<html>
<head>
<title>所有最新資訊資料 - listAllNewsdetail.jsp</title>

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
		 <h3>所有最新消息資料 - listAllNewsdetail.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/newsdetail/select_page.jsp">回首頁</a></h4>
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
	<c:forEach var="newsdetailVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${newsdetailVO.newsno}</td>
			<td>${newsdetailVO.newstitle}</td>
			<td>${newsdetailVO.newsintro}</td>
			<td>${newsdetailVO.empno}</td>
			<td><img height=100 src="<%=request.getContextPath()%>/DBGifReader4.do?newsno=${newsdetailVO.newsno}"></td>
			<td>${new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(newsdetailVO.newsdate)}</td>
			<td>${newsdetailVO.status}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="newsno"  value="${newsdetailVO.newsno}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="newsno"  value="${newsdetailVO.newsno}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>