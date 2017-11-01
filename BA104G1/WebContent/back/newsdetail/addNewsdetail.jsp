<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.newsdetail.model.*"%>

<%
  NewsdetailVO newsdetailVO = (NewsdetailVO) request.getAttribute("newsdetailVO");
%>


<html>
<head>

<script src="<%=request.getContextPath()%>/back/js/newsdetail/jquery-3.1.1.min.js"></script>
<script src="<%=request.getContextPath()%>/back/js/newsdetail/jquery.file-preview.js"></script>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>��Ʒs�W - addEmp.jsp</title>
<script>
$(document).ready(function (){

    $(".form1").on('change', '.upload', function() {
        var _this = this;
        $.filePreview.create(this, {
            isReader: false,
            progress: function (key, percent){
                console.log(percent)
            },
            success: function (key, obj){
                var $img = $(_this).parents(".form1").find(".img").eq(key);
                $img.css({
                    'background-image' : 'url(' + obj.preview + ')'
                });
            }
        });
    });

})
</script>
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
    border: 1px solid #666666;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>��Ʒs�W - addNews.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/back/newsdetail/select_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>�峹���D:</td>
		<td><input type="TEXT" name="newstitle" size="45"/></td>
	</tr>
	<tr>
		<td>�峹���e:</td>
		<td>
		<textarea rows="5" cols="45" name="newsintro" size="45"/></textarea></td>
	</tr>
	<tr>
		<td>���u�s��:</td>
		<td><input name="empno" id="empno" type="text" value="EMP0010"></td>
	</tr>
	
	<tr>
		<td>�峹���A:</td>
		<td> <input type="radio" name="status" value="�W�[" checked> �W�[ 
		<input type="radio" name="status" value="�U�["> �U�[ </td>
	</tr>
	<tr>
	 	<td>�W�ǹϤ�:</td> 
	 	<td><input type="file" name="coverpic" id="coverpic" multiple="multiple" class="file-loading"></td>
	</tr>
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="�s�W"></FORM>
</body>


</html>