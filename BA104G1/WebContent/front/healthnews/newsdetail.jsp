<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.newsdetail.model.*"%>


<%
	NewsdetailVO newsdetailVO = (NewsdetailVO) request.getAttribute("newsdetailVO");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	pageContext.setAttribute("sdf",sdf);
%>


<html>
<head>
<title>�̷s����</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/news.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="http://getbootstrap.com/dist/js/bootstrap.min.js"></script>
<script src="js/news.js"></script>

<!-- �n�h�U��w3 cdn -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<style type="text/css">

/* �̤W����banner*/
.bannan{
  width: 100%;
  height: 380px;
}


/* ���j�u */
.media{
  padding: 20px 10px 20px 10px;
}
/* ���j�u */


/* cp1 �j���D�Ĥ@�� �M�� */
.cp1{
    margin-top:1%; 
    margin-left:1.6%; 
    margin-bottom: 1%;
}

#imaginary_container{
   margin-top:8%; 
   margin-bottom: 1%;
}
/* seach bar�M�� */
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
/* seach bar�M�� */

/* breadcrumb �ѥ]�h�M�� */
 .bread_one li:before{
  /*border-left: 1px solid #000;*/
     content: '/';
     color: #fa0;
  }

/* breadcrumb �ѥ]�h�M�� */



 


/* ���ebutton */

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

/* ���ebutton */



/* ���e�j���D */
.chadddd{
  padding-top: 10px;
  color: #FFAF60;
  size:50px;
}
/* ���e�j���D */

/* ���e�j�� */

.imgbig{
 height:80%;
}
/* ���e�j�� */

/* ���D�� */
.newsimgs{
	height:160px;
	vertical-align : middle;
}

/* ���D�� */

/* �峹���e*/



</style>










</head>
<body>

<!--======= Banner =================================================-->

<!-- Banner -->
<div class="bg">
  <img src="<%=request.getContextPath()%>/img/news/001.jpg" class="bannan">
</div>
<!-- Banner -->

<!--======= Banner =================================================-->


<!--======= cp1 :���D��+search bar =================================================-->

<div class="container ">
<div class="row cp1">
  <!-- ���D -->
  <div class="col-xs-12 col-sm-8">
    <div class="header cp-1">
     <div class="h1">�O����T</div>
   </div>
  </div>
  <!-- ���D -->

  <!-- search bar -->
<!--   <div class="col-xs-12 col-sm-4"> -->
<!--     <div class="cp-2" id="imaginary_container">  -->
<!--       <div class="input-group stylish-input-group"> -->
<!--         <input type="text" class="form-control"  placeholder="Search" > -->
<!--         <span class="input-group-addon"> -->
<!--           <button type="submit"> -->
<!--             <span class="glyphicon glyphicon-search"></span> -->
<!--           </button>   -->
<!--         </span> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
  <!-- search bar -->
</div>

<!--======= cp1: ���D��+search bar =================================================-->

<!--======= ���e�峹���� =================================================-->
<!-- <div class="container"> -->
<!--     <div class="well">  -->
<!--         <div class="row"> -->
<!--              <div class="col-md-12"> -->
<!--                  <div class="row hidden-md hidden-lg"> -->
<%--                   <h1 class="text-center" >${newsdetailVO.newstitle}</h1></div> --%>
                     
<!--                   <div class="pull-left col-md-12 thumb-contenido"> -->
<%--                   <h1  class="hidden-xs hidden-sm">${newsdetailVO.newstitle}</h1> --%>
<%--                   <small>${sdf.format(newsdetailVO.newsdate)}</small> --%>
<!--                    <hr>  -->
<%--                   <img class="center-block img-responsive imgbig" src="<%=request.getContextPath()%>/newsdetail/newsshowimage.do?newsno=${newsdetailVO.newsno}" /></div> --%>
               
<!--                   <div class=""> -->
                     
<!--                      <hr> -->
<!--                      <br> -->
<%--                      <p class="text-justify">${newsdetailVO.newsintro}</p> --%>
<!--                      <br> -->
                     
<%--                       <input type="hidden" name="newsno" value="${newsdetailVO.newsno}"> --%>
<!-- 					  <input type="submit" value="�^�̷s��T" class="button btn-sm" style="vertical-align:middle" href="/allnews.jsp" ></FORM> -->
<!-- <a src=""></a> -->
<!--                 </div> -->
<!--              </div> -->
<!--         </div> -->
<!--     </div> -->
<!-- </div> -->




<div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-12">
					<img alt="Bootstrap Image Preview" src="<%=request.getContextPath()%>/healthnewsdetail/healthimgread.do?healthNo=${healthNewsDetailVO.healthNo}" class="img-thumbnail center-block img-responsive imgbig" />
					<div class="page-header">
						<h1>
							${healthNewsDetailVO.newsTitle}</h1>
							<small>${sdf.format(healthNewsDetailVO.newsDate)}</small>
					</div>
					<p class="lead text-muted text-left">${healthNewsDetailVO.newsIntro}</p> 
					<a class="button btn-sm" style="vertical-align:middle" href="<%=request.getContextPath()%>/front/healthnews/allnews.jsp" >�^�O����T</a>

<%-- 					<button type="button" class="btn btn-warning" href="<%=request.getContextPath()%>/front/newsdetail/allnews.jsp"> --%>
<!-- 						&lt;�^�W�@�� -->
<!-- 					</button> -->
				</div>
			</div>
		</div>
	</div>
</div>









<!--======= ���e�峹���� =================================================-->


		
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
</html>