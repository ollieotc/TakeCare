<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.carcomplain.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>




<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>申訴管理</title>
    <link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">  
    <link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/back/css/complain/complain.css">

</head>


<body>


    <main>
        <input id="tab1" type="radio" name="tabs" checked>
        <label for="tab1">長照申訴</label>
        <input id="tab2" type="radio" name="tabs">
        <label for="tab2">派車申訴</label>
        <input id="tab3" type="radio" name="tabs">
        <label for="tab3">送餐申訴</label>
        <input id="tab4" type="radio" name="tabs">
        <label for="tab4">商城申訴</label>


        <!-- 長照申訴 ========================================================================== -->

        <section id="content1">
           <jsp:include page="listAllHCCom.jsp" />
        </section>


        <!-- 派車申訴 ========================================================================== -->

        <section id="content2">
          <jsp:include page="listAllCarCom.jsp" />
        </section>

        <!-- 送餐申訴 ========================================================================== -->

        <section id="content3">
            <jsp:include page="listAllMealCom.jsp" />
        </section>

        <!-- 商城申訴 ========================================================================== -->

        <section id="content4">
            <jsp:include page="listAllShopCom.jsp" />
        </section>
    </main>



    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
</body>
</html>