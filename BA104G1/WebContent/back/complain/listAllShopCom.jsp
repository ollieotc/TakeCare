<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.shopcomplain.model.*"%>
<%@ page import="com.employee.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<!-- 假取得 emp_no -->
<% 
   EmployeeService employeeSvc = new EmployeeService();
   EmployeeVO employeeVO = (EmployeeVO)employeeSvc.getOneEMPLOYEE("B00001");
   session.setAttribute("employeeVO",employeeVO);
%>
<!-- 假取得 emp_no -->

<%  ShopComplainService shopComplainSvc = new ShopComplainService();
	List<ShopComplainVO> list = shopComplainSvc.getAll();
	pageContext.setAttribute("list",list);
%>
<% ShopComplainVO shopComplainVO = (ShopComplainVO) request.getAttribute("ShopComplainVO"); %>

<%
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	pageContext.setAttribute("sdf",sdf);
%>

<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>商城申訴</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">  
    <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/back/css/complain/complain.css">

</head>

<body>

<!-- 測試用 ===========-->
<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> <br>
   <font color=blue>EMP_ID: </font> <%= employeeVO.getEmpId() %> <br></b>
<!-- 測試用 ===========-->
<b>Hello! <%= employeeVO.getEmpId() %> </b>

        <!-- 商城申訴 ========================================================================== -->
 
            <table class="table table-striped">
                <div class="dropdown">
                    <button class="btn btn-default dropdown-toggle pull-right dropdown" type="button" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-check"></span>&nbsp 全部 / 未處理
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu dropdown-menu-right" style="margin-top: 17px">
                        <li><a href="#">全部</a></li>
                        <li><a href="#">未處理</a></li>
                        <li><a href="#">已完成</a></li>
                    </ul>
                </div>
                <thead>
                    <tr class="row-name">
                        <th style="width:15%">申訴編號</th>
                        <th style="width:15%">訂單編號</th>
                        <th style="width:10%">會員編號</th>
                        <th style="width:25%">申訴內容</th>
                        <th style="width:13%">時間</th>
                        <th>狀態</th>
                        <th>編輯</th>
                    </tr>
                </thead>
                <tbody>
                <%@ include file="page1.file" %>  
                <c:forEach var="shopComplainVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
                   <!--將修改的那一筆加入對比色而已-->
                    <tr class="row-content ${(shopComplainVO.complainNo == param.complainNo) ? 'text-primary':''}" valign='middle'>
                        <td >
                        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/shopcomplain/shopcomplain.do" style="margin-bottom: 0px;">
						    <button type="submit">${shopComplainVO.complainNo}</button>
						    <input type="hidden" name="complainNo"  value="${shopComplainVO.complainNo}">
						    <input type="hidden" name="action"	value="getOne_For_Display">
						</FORM>
                        </td>
                        <td>${shopComplainVO.orderno}</td>
                        <td>${shopComplainVO.complainDetail}</td>
                        <td>${sdf.format(shopComplainVO.detailDate)}</td>
                        <td>${shopComplainVO.complainReply}</td>
                        <td>
                       	<c:choose>
						    <c:when test="${shopComplainVO.complainStatus == '未處理'}">
						       <span class="fa edit label label-danger" style="height: 30px;">${shopComplainVO.complainStatus}</span>
						    </c:when>
						    <c:otherwise>
						       <span class="fa edit label label-default" style="height: 30px;">${shopComplainVO.complainStatus}</span>
						    </c:otherwise>
						</c:choose>
               	                      
                        </td>
                        <td>
                      		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/shopcomplain/shopcomplain.do" name="form1">
                        	<button type="submit" class="btn btn-info edit fa fa-pencil-square-o"></button>
                        	<input type="hidden" name="action"      value="getOne_For_Updat_shop">
                        	<input type="hidden" name="complainNo"  value="${shopComplainVO.complainNo}">
                        	<input type="hidden" name="orderNo"  value="${shopComplainVO.orderno}">
                        	<input type="hidden" name="emp_no"  value="${employeeVO.empId}">
						    <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
						    <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
                        	</FORM>
                        </td>
                            <td>
                      		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/shopcomplain/shopcomplain.do" name="form1">
                        	<button type="submit" class="btn btn-info edit glyphicon glyphicon-remove"></button>
                        	<input type="hidden" name="action"      value="delete">
                        	<input type="hidden" name="complainNo"  value="${shopComplainVO.complainNo}">
						    <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
						    <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
                        	</FORM>
                        </td>
                    </tr>
                 </c:forEach>
                </tbody>
               
            </table>
  <%@ include file="page2.file" %>
		
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
</body>
</html>