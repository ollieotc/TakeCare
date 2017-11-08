<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.carcomplain.model.*"%>
<%@ page import="com.order.model.*"%>

<% OrderVO orderVO = (OrderVO) request.getAttribute("orderVO"); %>
<% CarComplainVO carComplainVO = (CarComplainVO) request.getAttribute("carComplainVO"); %>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>派車申訴新增 - addCarCom.jsp</title>

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
		 <h3>派車申訴新增 - addCarCom.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/front/carcomplain/listAllOrder.jsp">回訂單頁面</a></h4>
	</td></tr>
</table>

<h3>申訴新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red"></font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/carcomplain/carcomplain.do" name="form1">
<table>
	<tr>
		<td>訂單編號:<font color=red><b>*</b></font></td>
		<td>${orderVO.order_no}</td>
	</tr>
	
	<tr>
		<td>申訴內容</td>
		<td><textarea rows="5" cols="45" name="complainDetail" /></textarea></td>
	</tr>
	<tr>
		<td colspan="2">訂單明細
		<jsp:include page="listOrder.jsp" />
		</td>
	</tr>
</table>

<br>
<input type="hidden" name="order_no" value="${orderVO.order_no}">
<input type="hidden" name="action" value="insert">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:listAllOrder.jsp-->
<input type="submit" value="送出"></FORM>



<font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
<font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%><br>
 

</body>

        
</html>