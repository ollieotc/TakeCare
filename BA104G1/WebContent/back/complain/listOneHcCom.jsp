<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hccomplain.model.*"%>

<%
  HcComplainVO HcComplainVO = (HcComplainVO) request.getAttribute("hcComplainVO"); //hcComplainServlet.java(Controller), 存入req的hcComplainVO物件
%>


<html>
<head>
<title>查詢單一長照申訴</title>


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
		 <h3>查詢單一長照申訴</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/complain/listAllHcCom.jsp">回申訴表單</a></h4>
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
		<td>${hcComplainVO.complainNo}</td>
		<td>${hcComplainVO.order_no}</td>
		<td>${hcComplainVO.complainDetail}</td>
		<td>${hcComplainVO.detailDate}</td>
		<td>${hcComplainVO.complainReply}</td>
		<td>${hcComplainVO.replyDate}</td>
		<td>${hcComplainVO.emp_no}</td>
		<td>${hcComplainVO.complainStatus}</td>
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/hccomplain/hccomplain.do" style="margin-bottom: 0px;">
			    <input type="submit" value="回覆">
			    <input type="hidden" name="complainNo"  value="${hcComplainVO.complainNo}">
			    <input type="hidden" name="requestURL" value="/back/complain/listAllhcCom.jsp"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
				<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllhcCom.jsp-->
			    <input type="hidden" name="action"	value="getOne_For_Updat_hc">
			</FORM>
		</td>
	</tr>
</table>

</body>
</html>