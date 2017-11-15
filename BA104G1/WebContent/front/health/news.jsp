<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.healthnewsdetail.model.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	HealthNewsDetailService healthnewsSvc = new HealthNewsDetailService();
	List<HealthNewsDetailVO> list = healthnewsSvc.getAll();
	pageContext.setAttribute("list",list);
	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	pageContext.setAttribute("sdf",sdf);
%>


<html>
<head>
<title>保健資訊</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="http://getbootstrap.com/dist/js/bootstrap.min.js"></script>
<script src="js/news.js"></script>

<!-- 要去下載w3 cdn -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<style type="text/css">

/* 最上面的banner*/
.bannan{
  width: 100%;
  height: 380px;
}


/* 分隔線 */
.media{
  padding: 20px 10px 20px 10px;
}
/* 分隔線 */


/* cp1 大標題第一區 專用 */
.cp1{
    margin-top:1%; 
    margin-left:1.6%; 
    margin-bottom: 1%;
}

#imaginary_container{
   margin-top:8%; 
   margin-bottom: 1%;
}
/* seach bar專用 */
.stylish-input-group .input-group-addon{
    background: white !important; 
}
.stylish-input-group .form-control{
  border-right:0; 
  box-shadow:0 0 0; 
  border-color:#ccc;
}
.stylish-input-group button{
    border:0;
    background:transparent;
}
/* seach bar專用 */

/* breadcrumb 麵包屑專用 */
 .bread_one li:before{
  /*border-left: 1px solid #000;*/
     content: '/';
     color: #fa0;
  }

/* breadcrumb 麵包屑專用 */


/* 隱藏字幕 */

p{
  width:700px;
  white-space:nowrap;
  text-overflow:ellipsis;
  -o-text-overflow:ellipsis;
  overflow: hidden;
}

/* 隱藏字幕 */
 


/* 內容button */

.button {
  display: inline-block;
  border-radius: 2px;
  background-color: #FF8000;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 14px;
  padding: 5px;
  width: 120px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 15px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}

/* 內容button */



/* 內容大標題 */
.chadddd{
  padding-top: 10px;
  color: #FFAF60;
  size:50px;
}
/* 內容大標題 */




/* 標題圖 */
.newsimgs{
	height:160px;
}


</style>










</head>
<body>

<!--======= Banner =================================================-->

<!-- Banner -->
<div class="bg">
  <img src="<%=request.getContextPath()%>/img/health/p3.jpg" class="bannan">
</div>
<!-- Banner -->

<!--======= Banner =================================================-->


<!--======= cp1 :標題區+search bar =================================================-->

<div class="container ">
<div class="row cp1">
  <!-- 標題 -->
  <div class="col-xs-12 col-sm-8">
    <div class="header cp-1">
     <div class="h1">保健資訊</div>
   </div>
  </div>
  <!-- 標題 -->

  <!-- search bar -->
  <div class="col-xs-12 col-sm-4">
    <div class="cp-2" id="imaginary_container"> 
      <div class="input-group stylish-input-group">
        <input type="text" class="form-control"  placeholder="Search" >
        <span class="input-group-addon">
          <button type="submit">
            <span class="glyphicon glyphicon-search"></span>
          </button>  
        </span>
      </div>
    </div>
  </div>
  <!-- search bar -->
</div>

<!--======= cp1: 標題區+search bar =================================================-->



<%@ include file="/front/health/page1.file" %> 
<c:forEach var="healthNewsDetailVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">


<!--======= 內容文章部分 =================================================-->
<div class="w3-container"> 
<div class="row">

  <!-- 右邊文章區 -->
    <div class="col-xs-12 col-sm-12">
    <ul class="media-list main-list">
        <li class="media w3-border-bottom">
          <!-- 圖 -->
          <a class="pull-left" href="#">
           <img class="img-thumbnail newsimgs" src="<%=request.getContextPath()%>/healthnewsdetail/healthnewsshowimage.do?healthNo=${healthNewsDetailVO.healthNo}">
          </a>
          <!-- 圖 -->

          <!-- 內容 -->
          <div class="media-body">
            <h3 class="media-heading chadddd">${healthNewsDetailVO.newsTitle}</h3>
            <p>${sdf.format(healthNewsDetailVO.newsDate)}</p>
            <p>${healthNewsDetailVO.newsIntro}</p>
          </div>
          <!-- 內容 -->

          <!-- Button readmore -->
          <button class="button btn-sm" style="vertical-align:middle"><span>Read more </span></button>
          <!-- Button readmore -->

        </li>
    
    </ul>
  </div>
  <!-- 右邊文章區 -->
  </div>
</div>

<!--======= 內容文章部分 =================================================-->


</c:forEach>
<%@ include file="/front/health/page2.file" %>


		
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>