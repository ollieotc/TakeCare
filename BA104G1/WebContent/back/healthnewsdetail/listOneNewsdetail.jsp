<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.healthnewsdetail.model.*"%>

<%
  HealthNewsDetailVO healthNewsDetailVO = (HealthNewsDetailVO) request.getAttribute("healthNewsDetailVO");
%>

<html>
<head>
<title>保鍵資訊 - ListOneNewsdetail.jsp</title>


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
	width: 600px;
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
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>保健資訊 - ListOneNewsdetail.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/healthnewsdetail/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

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
	<tr>
		<td>${healthNewsDetailVO.healthNo}</td>
		<td>${healthNewsDetailVO.newsTitle}</td>
		<td>${healthNewsDetailVO.newsIntro}</td>
		<td>${healthNewsDetailVO.emp_no}</td>
		<td><img height=100 src="<%=request.getContextPath()%>/healthnewsdetail/healthimgread.do?healthNo=${healthNewsDetailVO.healthNo}"></td>
		<td>${healthNewsDetailVO.newsDate}</td>
		<td>${healthNewsDetailVO.status}</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/healthnewsdetail/healthnewsdetail.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改">
			    <input type="hidden" name="healthNo"  value="${healthNewsDetailVO.healthNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:listAllNews.jsp-->
			    <input type="hidden" name="action"	value="getOne_For_Update">
			</FORM>
		</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/healthnewsdetail/healthnewsdetail.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="healthNo"  value="${healthNewsDetailVO.healthNo}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			    <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:listAllNews.jsp-->
			    <input type="hidden" name="action" value="delete">
			</FORM>
		</td>
	</tr>
</table>


<font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
<font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%></br>
 
</body>
</html>