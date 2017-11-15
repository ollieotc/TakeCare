<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.newsdetail.model.*"%>

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	NewsdetailService newsdetailSvc = new NewsdetailService();
	List<NewsdetailVO> list = newsdetailSvc.getAll();
	pageContext.setAttribute("list",list);
%>	
<%	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	pageContext.setAttribute("sdf",sdf);
%>


<html>
<head>
<title>最新消息</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/news.css">
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
.stylish-input-group .button{
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
<jsp:include page="/front/navbar.jsp" />
<!-- Banner -->
<div class="bg">
  <img src="<%=request.getContextPath()%>/img/news/001.jpg" class="bannan">
</div>
<!-- Banner -->

<!--======= Banner =================================================-->


<!--======= cp1 :標題區+search bar =================================================-->

<div class="container ">
<div class="row cp1">
  <!-- 標題 -->
  <div class="col-xs-12 col-sm-8">
    <div class="header cp-1">
     <div class="h1">最新消息</div>
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



<%@ include file="/front/newsdetail/page1.file" %> 
<c:forEach var="newsdetailVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">


<!--======= 內容文章部分 =================================================-->
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/newsdetail/newsdetail.do" name="form1">
<div class="container">
    <div class="well"> 
        <div class="row">
             <div class="col-md-12">
                 <div class="row hidden-md hidden-lg">
                  <h1 class="text-center" >${newsdetailVO.newstitle}</h1></div>
                     
                  <div class="pull-left col-md-4 col-xs-12 thumb-contenido">
                  <img class="center-block img-responsive" src="<%=request.getContextPath()%>/newsdetail/newsimgread.do?newsno=${newsdetailVO.newsno}" style= max-width:310px; /></div>
               
                  <div class="">
                     <h1  class="hidden-xs hidden-sm">${newsdetailVO.newstitle}</h1>
                     <small>${sdf.format(newsdetailVO.newsdate)}</small>
                     <hr>
                     <p class="text-justify">${newsdetailVO.newsintro}</p>
                     <br>
                     <!-- Button readmore -->
<!-- 			      <button class="button btn-sm" style="vertical-align:middle"><span>Read more </span></button> -->
					  <input type="hidden" name="newsno" value="${newsdetailVO.newsno}">
					  <input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
				 	  <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:lisAllOrder.jsp-->
			          <input type="hidden" name="action" value="getOne_For_Display_Front">
					  <input type="submit" value="Read more" class="button btn-sm" style="vertical-align:middle"></FORM>
			          <!-- Button readmore -->
                     
                </div>
             </div>
        </div>
    </div>
</div>


<!--======= 內容文章部分 =================================================-->
</c:forEach>
<%@ include file="/front/newsdetail/page2.file" %>


		
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
<jsp:include page="/front/footerbar.jsp" />
</html>