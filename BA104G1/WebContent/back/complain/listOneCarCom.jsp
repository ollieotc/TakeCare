<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carcomplain.model.*"%>

<%
  CarComplainVO carComplainVO = (CarComplainVO) request.getAttribute("carComplainVO"); //CarComplainServlet.java(Controller), 存入req的carComplainVO物件
%>

<%-- <jsp:useBean id="listOneCarCom" scope="request" type="java.util.Set<CarComplainVO>" /> --%>


<html>
<head>
<title>查詢單一派車申訴</title>


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
		 <h3>查詢單一派車申訴</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/complain/listAllCarCom.jsp">回申訴表單</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>申訴編號</th>
		<th>訂單編號</th>
		<th>申訴內容</th>
		<th>申訴時間</th>
		<th>回覆申訴內容</th>
		<th>回覆申訴時間</th>
		<th>員工編號</th>
		<th>狀態</th>
		<th>回覆</th>
	</tr>
	<tr>
		<td>${carComplainVO.complainNo}</td>
		<td>${carComplainVO.order_no}</td>
		<td>${carComplainVO.complainDetail}</td>
		<td>${carComplainVO.detailDate}</td>
		<td>${carComplainVO.complainReply}</td>
		<td>${carComplainVO.replyDate}</td>
		<td>${carComplainVO.emp_no}</td>
		<td>${carComplainVO.complainStatus}</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/carcomplain/carcomplain.do" style="margin-bottom: 0px;">
			    <input type="submit" value="回覆">
			    <input type="hidden" name="complainNo"  value="${carComplainVO.complainNo}">
			    <input type="hidden" name="requestURL" value="/back/complain/listAllCarCom.jsp"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
				<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllCarCom.jsp-->
			    <input type="hidden" name="action"	value="getOne_For_Updat_car">
			</FORM>
		</td>
	</tr>
</table>

</body>
</html>