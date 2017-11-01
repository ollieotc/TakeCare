<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.newsdetail.model.*"%>

<%
  NewsdetailVO newsdetailVO = (NewsdetailVO) request.getAttribute("newsdetailVO"); //NewsdetailServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>最新消息 - ListOneNewsdetail.jsp</title>


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
		 <h3>最新消息 - ListOneNewsdetail.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/newsdetail/select_page.jsp">回首頁</a></h4>
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
		<td>${newsdetailVO.newsno}</td>
		<td>${newsdetailVO.newstitle}</td>
		<td>${newsdetailVO.newsintro}</td>
		<td>${newsdetailVO.empno}</td>
		<td><img height=100 src="<%=request.getContextPath()%>/DBGifReader4.do?newsno=${newsdetailVO.newsno}"></td>
		<td>${newsdetailVO.newsdate}</td>
		<td>${newsdetailVO.status}</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" style="margin-bottom: 0px;">
			    <input type="submit" value="修改">
			    <input type="hidden" name="newsno"  value="${newsdetailVO.newsno}">
			    <input type="hidden" name="action"	value="getOne_For_Update">
			</FORM>
		</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" style="margin-bottom: 0px;">
			    <input type="submit" value="刪除">
			    <input type="hidden" name="newsno"  value="${newsdetailVO.newsno}">
			    <input type="hidden" name="action" value="delete">
			</FORM>
		</td>
	</tr>
</table>

</body>
</html>