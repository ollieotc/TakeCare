<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.carcomplain.model.*"%>
<%@ page import="com.order.model.*"%>

<!-- CarComplainServlet.java , 存入req的carComplainVO物件 
     (包括幫忙取出的carComplainVO, 也包括輸入資料錯誤時的carComplainVO物件) -->

<% CarComplainVO carComplainVO = (CarComplainVO) request.getAttribute("carComplainVO"); %>



<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>回覆申訴 - update_car_input.jsp</title>

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
		 <h3>回覆申訴 - update_car_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/complain/listAllAllCom.jsp">回列表</a></h4>
	</td></tr>
</table>

<h3>回覆申訴:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/carcomplain/carcomplain.do" name="form1">
<table>

	<tr>
		<td>申訴編號:<font color=red><b>*</b></font></td>
		<td>${carComplainVO.complainNo}</td>
	</tr>
	<tr>
		<td>明細編號:<font color=red><b>*</b></font></td>
		<td>${carComplainVO.order_no}</td>
	</tr>
	<tr>
		<td>申訴內容:<font color=red><b>*</b></font></td>
		<td>${carComplainVO.complainDetail}</td>
	</tr>
	<tr>
		<td>申訴時間:<font color=red><b>*</b></font></td>
		<td>${orderVO.detailDate}</td>
	</tr>
	<tr>
		<td>申訴回覆:</td>
		<td><textarea rows="5" cols="45" name="complainReply" size="45"/>${complainVO.complainReply}</textarea></td>
	</tr>
	<tr>
		<td>文章狀態:</td>
		<td>
			<input type="radio" name="complainStatus" value="未處理" ${(complainVO.complainStatus == '未處理')?'checked':'' }> 未處理 
			<input type="radio" name="complainStatus" value="已完成" ${(complainVO.complainStatus == '已完成')?'checked':'' }> 已完成
		</td>
	</tr>
<!-- 	<tr> -->
<!-- 	 	<td>上傳圖片:</td>  -->
<!-- 	 	<td><input type="file" name="coverpic" id="coverpic" multiple="multiple" class="file-loading"></td> -->
<!-- 	</tr> -->


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="complainNo" value="${carComplainVO.complainNo}">
<input type="hidden" name="order_no" value="${carComplainVO.order_no}">
<input type="hidden" name="complainDetail" value="${carComplainVO.complainDetail}">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllCarCom.jsp-->
<input type="submit" value="送出"></FORM>



<font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
<font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%></br>
 

</body>


</html>