<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.healthnewsdetail.model.*"%>

<%
  HealthNewsDetailVO healthNewsDetailVO = (HealthNewsDetailVO) request.getAttribute("healthNewsDetailVO");
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>保健資料修改</title>

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
		 <h3>保健資料修改</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/healthnewsdetail/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<h3>保健資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/healthnewsdetail/healthnewsdetail.do" name="form1"  enctype="multipart/form-data">
<table>

	<tr>
		<td>文章編號:<font color=red><b>*</b></font></td>
		<td>${healthNewsDetailVO.healthNo}</td>
	</tr>
	<tr>
		<td>文章標題:</td>
		<td><input type="TEXT" name="newsTitle" size="45" value="${healthNewsDetailVO.newsTitle}" /></td>
	</tr>
	<tr>
		<td>文章內容:</td>
		<td>
		<textarea rows="5" cols="45" name="newsIntro" size="45"/>${healthNewsDetailVO.newsIntro}</textarea></td>
	</tr>
	<tr>
		<td>員工編號:</td>
		<td><input name="empno" id="emp_no" type="text" value="${healthNewsDetailVO.emp_no}"></td>
	</tr>
	<tr>
		<td>文章狀態:</td>
		<td> <input type="radio" name="status" value="上架" ${(healthNewsDetailVO.status == '上架')?'checked':'' }> 上架 
		<input type="radio" name="status" value="下架" ${(healthNewsDetailVO.status == '下架')?'checked':'' }> 下架 </td>
	</tr>
	<tr>
	 	<td>上傳圖片:</td> 
	 	<td><input type="file" name="coverPic" id="coverPic" multiple="multiple" class="file-loading"></td>
		<p><img src="<%=request.getContextPath()%>/healthnewsdetail/healthimgread.do?healthNo=${healthNewsDetailVO.healthNo}" style= max-width:150px;max-height:150px;></img></p>
	</tr>


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="healthNo"   value="${healthNewsDetailVO.healthNo}">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:listAllNews.jsp-->
<input type="submit" value="送出修改"></FORM>



<font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
<font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%></br>
 

</body>
</html>