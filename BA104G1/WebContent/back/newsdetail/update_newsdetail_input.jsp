<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.newsdetail.model.*"%>

<%
NewsdetailVO newsdetailVO = (NewsdetailVO) request.getAttribute("newsdetailVO"); //EmpServlet.java (Concroller), �s�Jreq��empVO���� (�]�A�������X��empVO, �]�]�A��J��ƿ��~�ɪ�empVO����)
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>��ƭק� - update_newsdetail_input.jsp</title>

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
		 <h3>��ƭק� - update_newsdetail_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back/newsdetail/select_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" name="form1">
<table>

	<tr>
		<td>�峹�s��:<font color=red><b>*</b></font></td>
		<td>${newsdetailVO.newsno}</td>
	</tr>
	<tr>
		<td>�峹���D:</td>
		<td><input type="TEXT" name="newstitle" size="45" value="${newsdetailVO.newstitle}" /></td>
	</tr>
	<tr>
		<td>�峹���e:</td>
		<td>
		<textarea rows="5" cols="45" name="newsintro" size="45"/>${newsdetailVO.newsintro}</textarea></td>
	</tr>
	<tr>
		<td>���u�s��:</td>
		<td><input name="empno" id="empno" type="text" value="${newsdetailVO.empno}"></td>
	</tr>
	<tr>
		<td>�峹���A:</td>
		<td> <input type="radio" name="status" value="�W�[" ${(newsdetailVO.status == '�W�[')?'checked':'' }> �W�[ 
		<input type="radio" name="status" value="�U�[" ${(newsdetailVO.status == '�U�[')?'checked':'' }> �U�[ </td>
	</tr>


</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="newsno" value="${newsdetailVO.newsno}">
<input type="submit" value="�ק�"></FORM>
</body>


</html>