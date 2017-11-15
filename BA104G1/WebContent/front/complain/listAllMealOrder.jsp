<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.hcorder.model.*"%>
<%@ page import="com.member.model.*" %>
<%-- 此頁練習採用 EL 的寫法取值 --%>


<!-- 假取得 member_no -->
<% MemberService memSvc = new MemberService();
   MemberVO memVO = (MemberVO)memSvc.getOneMEMBER("mem01");
   session.setAttribute("memVO",memVO);
%>


<!-- 先假的 member_no -->
<%
	HcOrderMasterService hcOrderMasterSvc = new HcOrderMasterService();
    List<HcOrderMasterVO> list = hcOrderMasterSvc.getAll();
    pageContext.setAttribute("list",list);
%>



<html>
<head>
<title>所有訂單 - listAllHcOrder.jsp</title>

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
	width: 800px;
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

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有訂單 - listAll.jsp</h3>
		 <b>Hello! <%= memVO.getMemName() %> </b>
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
		<th>訂單編號</th>
		<th>會員編號</th>
		<th>下單日期</th>
		<th>狀態</th>
		<th>申訴</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="hcOrderMasterVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr align='center' valign='middle' ${(hcOrderMasterVO.orderNo==param.orderNo) ? 'bgcolor=#CCCCFF':''}><!--將修改的那一筆加入對比色而已-->
		<tr>
			<td>${hcOrderMasterVO.orderNo}</td>
			<td>${hcOrderMasterVO.memNo}</td>
			<td>${hcOrderMasterVO.orderDate}</td>
			<td>${hcOrderMasterVO.orderStatus}</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/hccomplain/hccomplain.do" style="margin-bottom: 0px;">
			     <input type="submit" value="申訴">
			     <input type="hidden" name="orderNo"  value="${hcOrderMasterVO.orderNo}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	value="getOne_For_Update_HcOrder"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> <br>
   <font color=blue>MEM_Name: </font> <%= memVO.getMemName() %> <br>
   <font color=blue>order_no: </font> ${hcOrderMasterVO.orderNo} <br>
   </b>


</body>
</html>