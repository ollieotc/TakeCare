<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.newsdetail.model.*"%>

<%
  NewsdetailVO newsdetailVO = (NewsdetailVO) request.getAttribute("newsdetailVO");
%>


<html>
<head>

<script src="<%=request.getContextPath()%>/back/js/newsdetail/jquery-3.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/back/js/newsdetail/jquery.file-preview.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>資料新增 - addNews.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 1px solid #666666;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>資料新增 - addNews.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back/newsdetail/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>文章標題:</td>
		<td><input type="TEXT" name="newstitle" size="45" value="${newsdetailVO.newstitle == null ? '' : newsdetailVO.newstitle}"/></td>
	</tr>
	<tr>
		<td>文章內容:</td>
		<td>
		<textarea rows="5" cols="45" name="newsintro" size="45" />${newsdetailVO.newsintro == null ? '' : newsdetailVO.newsintro}</textarea></td>
	</tr>
	<tr>
		<td>員工編號:</td>
		<td><input name="empno" id="empno" type="text" value="EMP0010"></td>
	</tr>
	
	<tr>
		<td>文章狀態:</td>
		<td> <input type="radio" name="status" value="上架" checked> 上架 
		<input type="radio" name="status" value="下架"> 下架 </td>
	</tr>
	<tr>
	 	<td>上傳圖片:</td> 
	 	<td><input type="file" name="coverpic" id="coverpic" multiple="multiple"></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert_front">
<input type="submit" value="新增"></FORM>
</body>


</html>