<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>有我罩你聊天室</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front/css/message/message.css">
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <!--[if lt IE 9]>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body  onload="connect();" onunload="disconnect();">
    
	<!--即時訊息-->    
	<div class="container bootstrap snippets">
	<div class="col-md-7 col-xs-12 col-md-offset-2">
	  <!-- Panel Chat -->
	  <div class="panel" id="chat">
	    <div class="panel-heading">
	      <h3 class="panel-title">
	        <i class="icon wb-chat-text fa fa-magnet" aria-hidden="true"></i> 有我罩你-熱線你與我
	      </h3>
	    </div>
	    <div class="panel-body">
	      <div class="chats">
	        <div class="chat">
	          <div class="chat-avatar">
	            <a class="avatar avatar-online" data-toggle="tooltip" href="#" data-placement="right" title="" data-original-title="June Lane">
	              <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="...">
	              <i></i>
	            </a>
	            <h5 id="chat-header-name">EMP0001</h5>
	          </div>
	         
	          <div class="chat-body">
	           <h3 id="chat-header-name">name</h3>
	            <div class="chat-content">
	            <h3 id="chat-header-name">name</h3>
	              <p>
	                Good morning, sir.
	                <br>What can I do for you?
	              </p>
	              <time class="chat-time" datetime="2015-07-01T11:37">11:37:08 am</time>
	            </div>
	          </div>
	        </div>
	        <div class="chat chat-left">
	          <div class="chat-avatar">
	            <a class="avatar avatar-online" data-toggle="tooltip" href="#" data-placement="left" title="" data-original-title="Edward Fletcher">
	              <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="...">
	              <i></i>
	            </a>
	            <h5 id="chat-header-name">會員名</h5>
	          </div>
	          <div class="chat-body messagesArea">
	            <div class="chat-content">
	              <p>Well, I am just looking around.</p>
	              <time class="chat-time">11:39:57 am</time>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    <div class="panel-footer">
	      <form>
	        <div class="input-group">
	          <input type="text" class="form-control" placeholder="請在此輸入文字">
	          <span class="input-group-btn">
	            <input type="submit" id="sendMessage" class="button btn btn-danger" value="送出" onclick="sendMessage();"/>
<!-- 	            <button class="btn btn-danger" type="button">Send</button> -->
	          </span>
	        </div>
	      </form>
	    </div>
	  </div>
	  <!-- End Panel Chat -->
	</div>
	</div>
	
<script>
	var MyPoint = "/AllChatServer/ron";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	// 當客戶點擊聊天室 click事件 onopen
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
		};
		
		webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
	        var message = jsonObj.userName + ": " + jsonObj.message + "\r\n";
	        messagesArea.value = messagesArea.value + message;
	        messagesArea.scrollTop = messagesArea.scrollHeight;
		};

		webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
	}
	
</script>
    
    
    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
  </body>
</html>