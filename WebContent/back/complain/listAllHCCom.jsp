<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.carcomplain.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>


<%  CarComplainService carComplainSvc = new CarComplainService();
	List<CarComplainVO> carlist = carComplainSvc.getAll();
	pageContext.setAttribute("carlist",carlist);
%>


<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>長照申訴</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">  
    <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/back/css/complain/complain.css">

</head>

<body>
        <!-- 派車申訴 ========================================================================== -->
 
           <table class="table table-striped">
                <div class="dropdown">
                    <button class="btn btn-default dropdown-toggle pull-right dropdown" type="button" data-toggle="dropdown">
                    <span class="glyphicon glyphicon-check"></span> &nbsp 全部 / 未處理
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
                    <tr class="row-content">
                        <td><a>a00002</a></td>
                        <td>長照is here</td>
                        <td>FA101</td>
                        <td>Akshay</td>
                        <td>Super...</td>
                        <td>
                            <span class="fa edit label label-danger glyphicon glyphicon-time" style="height: 30px;"> 未處理</span>
                        </td>
                        <td>
                            <a class="btn btn-info edit fa fa-pencil-square-o" href="path/to/settings"></a>
                        </td>
                    </tr>
                    <tr class="row-content">
                        <td><a>a00002</a></td>
                        <td> sh10003-4994</td>
                        <td>FA101</td>
                        <td>Akshay</td>
                        <td>Super...</td>
                        <td>
                            <span class="fa edit label label-default glyphicon glyphicon-ok" style="height: 30px;"> 已完成</span>
                        </td>
                        <td>
                            <a class="btn btn-info edit fa fa-pencil-square-o" href="path/to/settings"></a>
                        </td>
                    </tr>
                </tbody>
            </table>






    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
</body>
</html>