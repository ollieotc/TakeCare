<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
    <head>
        <title>有我罩你-聊天室</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
		<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/front/css/message/chat2.css" rel="stylesheet">
    </head>
    
    <body onload="connect();" onunload="disconnect();">
    
    
<!-- 測試用 -->
<h1> Chat Room test!!</h1>
<h3 id="statusOutput" class="statusOutput"></h3>
<hr>
<!-- 使用者名稱 -->
<input id="userName" class="text-field" type="text" placeholder="User name"/>
<!-- HTML -->
<div class="container">
    <div class="col-md-12 col-lg-6">
        <div class="panel chatsize">
			
			<!--============ 這裡是標頭 Heading =================-->
    		<div class="panel-heading">
    			<div class="panel-control">
    				<div class="btn-group">
    					<button class="btn btn-default" type="button" data-toggle="collapse" data-target="#demo-chat-body"><i class="fa fa-chevron-down"></i></button>
    					<button type="button" class="btn btn-default" data-toggle="dropdown"><i class="fa fa-gear"></i></button>
    				</div>
    			</div>
    			<h3 class="panel-title"><i class="fa fa-user-o"></i>  有我罩你 聊天室</h3>
    		</div>
    		<!--============ 這裡是標頭 Heading =================-->

<!--===========  聊天訊息框本體在這 Widget body =================-->
<div id="chat-body" class="collapse in"> 
<div class="nano-content pad-all" id="textArea" tabindex="0"> 
 
</div> 
<div class="panel-footer">
<div class="row">
<div class="col-xs-12 col-sm-1">
<label>
<input type="file" style="display:none;" >
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Picture_font_awesome.svg/512px-Picture_font_awesome.svg.png" class="imgupload">
<!-- <img src="data:image/gif; " class="imgupload"> -->
</label>
</div>

<!-- ==== 打字訊息框 ===== -->
<div class="col-xs-12 col-sm-8">
<input type="text" placeholder="Enter your text" class="text-field form-control chat-input" id="message" onkeydown="if (event.keyCode == 13) sendMessage();" />
</div>
<!-- ==== 打字訊息框 ===== -->

<!-- ==== 送出訊息button ===== -->
<div class="col-xs-3">
<input class="btn btn-danger btn-block btnfont" type="submit" class="button" value="送出" id="sendMessage" onclick="sendMessage();" />
</div>
<!-- ==== 送出訊息button ===== -->

</div>
</div>
<input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
<input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>

<!-- <textarea id="messagesArea" class="panel message-area" readonly >
</textarea> -->


</div>

<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


</body>
 
 
 
<!-- webSocket從這裡開始 -->    
<script>
    
    var MyPoint = "/MessageServlet/peter/309";
    console.log(MyPoint);
    var host = window.location.host;
    console.log(host);
    var path = window.location.pathname;
    console.log(path);
    var webCtx = path.substring(0, path.indexOf('/', 1));
    console.log(webCtx);
    
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint; /* Websocket路徑 */
    console.log(endPointURL);
    var statusOutput = document.getElementById("statusOutput"); /* 測試連線顯示 */
	var webSocket;
	
	
	/* 網頁一開始load or 點擊button連線觸發 connect() */
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		
		/* 與servlet onOpen方法 */
		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
		};
		
		/* 發送訊息 與servlet onMessage方法  */
		webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
			// 設置一個變數 data, 將剛剛 JSON 的資料存入
	        var jsonObj = JSON.parse(event.data);
	        var userName = jsonObj.userName;
	        var message = jsonObj.message + "\r\n";
	  console.log('message :'+message );
	        
	        var nowdate = jsonObj.time;
	   console.log('nowdate:'+nowdate);
	        console.log('比對名字userName:'+userName+'比對名字jsonObj.userName:'+jsonObj.userName);
	        if(userName == jsonObj.userName ){
	        	control = '<ul class="list-unstyled media-block"> '+
	        		'<li class="mar-btm">' +
	        		'<div class="media-right">'+ 
	        		'<img src="http://assets.iing.tw/official/assets/policies_image/geriatric_care/gc4_2-97e801b020ad7c7b0cc664c83c502eca.png" class="img-circle img-sm" alt="Profile Picture"> ' +
	        		'<p href="#" class="media-heading">'+jsonObj.userName+'</p>' +
	        		'</div>'+ 
	        		'<div class="media-body pad-hor speech-right">'+
	        		'<div class="speech">'+
	        		'<p >'+message+'</p>'+ 
	        		'</div>'+
	        		'<div>'+ 
	        		'<p class="speech-time">'+
	        		'<i class="fa fa-check fa-fw"></i>&nbsp&nbsp<i class="fa fa-clock-o fa-fw"></i>'+nowdate + 
	        		'</p>'+
	        		'</div>'+
	        		'</div>'+
	        		'</li>'+
	        		'</ul>';
	        		
	        }else{ 
	        	control='<ul class="list-unstyled media-block"> '+
	        	'<li class="mar-btm">'+
	        	'<div class="media-left"> '+
	        	'<img src="https://bootdey.com/img/Content/avatar/avatar1.png" class="img-circle img-sm" alt="Profile Picture"> '+
	        	'<p class="media-heading">'+jsonObj.userName+'</p>'+
	        	'</div>'+
	        	'<div class="media-body pad-hor">'
	        	'<div class="speech">'+
	        	'<p>'+message+'</p> ' +
        		'</div>'+
        		'<div>'+
	        	'<p class="speech-time">'+
	        	'<i class="fa fa-clock-o fa-fw"></i>&nbsp'+jsonObj.nowdate+'&nbsp&nbsp' +
	        	'<i class="fa fa-check fa-fw"></i>'+ 
	        	'</p>'+
	        	'</div>'+
        		'</div>'+
        		'</li>'+
        		'</ul>';
	        	
	        }
	        $("#textArea").append(control);
	        $("#textArea").scrollTop($("#textArea")[0].scrollHeight);
	        /* messagesArea.scrollTop = messagesArea.scrollIntoView(); */ 
		};
		
		/* 關閉觸發 與servlet onClose方法  */
		webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
	}
	
	
	var inputUserName = document.getElementById("userName");
	inputUserName.focus();
	
	function sendMessage() {
	    var userName = inputUserName.value.trim();
	    var date = new Date();
	    var nowdate = date.getFullYear() + "-" + (date.getMonth()+1) + "-"
			+ date.getDate() + " " + date.getHours()+":"+
			+ date.getMinutes() + ":" + date.getSeconds();
			console.log('時間：'+nowdate);	
	    if (userName === ""){
	        alert ("使用者名稱請勿空白!");
	        inputUserName.focus();	
			return;
	    }
	    
	    var inputMessage = document.getElementById("message");
	    var message = inputMessage.value.trim();
	    if (message === ""){
	        alert ("訊息請勿空白!");
	        inputMessage.focus();	
	        
	    }else{ 
	    		if(userName.indexOf("1")==0){
		    		console.log('第一次名字'+userName.indexOf);
		    		var jsonObj = {
		    				"userName" : userName,
		    				"message" : message,
							"time" : nowdate
							};
		    		
		    		// 利用 JSON 將資料送給 WebSocket：
		    		webSocket.send(JSON.stringify(jsonObj));
					inputMessage.value = "";
					inputMessage.focus();
		   		 }else{
			    	console.log('第二次名字'+userName);
			    	var jsonObj = {
		    				"userName" : userName,
		    				"message" : message,
							"time" : nowdate
							};
			    	
			    	webSocket.send(JSON.stringify(jsonObj));
			        inputMessage.value = "";
			        inputMessage.focus();
		 	  	 }
	   		 }
		}

	
	function disconnect () {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}

	
	function updateStatus(newStatus) {
		statusOutput.innerHTML = newStatus;
	}
	
    
</script>
<!-- webSocket從這裡結束 -->
<!--======= 對方的對話框  =======-->

<li class="mar-btm">
<div class="media-left"> 
<img src="https://bootdey.com/img/Content/avatar/avatar1.png" class="img-circle img-sm" alt="Profile Picture"> 
</div> 
 <div class="media-body pad-hor"> 
 <div class="speech"> 
<p class="media-heading">John Doe</p> 
<p>Hello Lucy, how can I help you today ?</p> 
<p class="speech-time"> 
<i class="fa fa-clock-o fa-fw"></i>&nbsp09:23AM&nbsp&nbsp 
<i class="fa fa-check fa-fw"></i> 
</p> 
</div> 
</div> 
</li> 

<!--======= 對方的對話框  =======-->


</html>
