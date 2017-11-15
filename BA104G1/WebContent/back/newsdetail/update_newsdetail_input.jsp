<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.newsdetail.model.*"%>

<%
NewsdetailVO newsdetailVO = (NewsdetailVO) request.getAttribute("newsdetailVO"); // 存入req的newsdetailVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>最新消息修改</title>

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
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>最新資訊修改 - update_newsdetail_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/newsdetail/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>最新資訊修改:</h3>

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
		<td>文章編號:<font color=red><b>*</b></font></td>
		<td>${newsdetailVO.newsno}</td>
	</tr>
	<tr>
		<td>文章標題:</td>
		<td><input type="TEXT" name="newstitle" size="45" value="${newsdetailVO.newstitle}" /></td>
	</tr>
	<tr>
		<td>文章內容:</td>
		<td>
		<textarea rows="5" cols="45" name="newsintro" size="45"/>${newsdetailVO.newsintro}</textarea></td>
	</tr>
	<tr>
		<td>員工編號:</td>
		<td><input name="empno" id="empno" type="text" value="${newsdetailVO.empno}"></td>
	</tr>
	<tr>
		<td>文章狀態:</td>
		<td> <input type="radio" name="status" value="上架" ${(newsdetailVO.status == '上架')?'checked':'' }> 上架 
		<input type="radio" name="status" value="下架" ${(newsdetailVO.status == '下架')?'checked':'' }> 下架 </td>
	</tr>
	<tr>
	 	<td>圖片修改:</td> 
	 	<td><input type="file" name="coverpic" id="coverpic" multiple="multiple" class="file-loading"></td>
	 	<p><img src="<%=request.getContextPath()%>/newsdetail/newsimgread.do?newsno=${newsVO.newsno}" style= max-width:150px;max-height:150px;></img></p>
	</tr>


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="newsno" value="${newsdetailVO.newsno}">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllNews.jsp-->
<input type="submit" value="送出修改">

</FORM>


</body>
</html>