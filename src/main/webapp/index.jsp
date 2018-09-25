<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<meta content="text/html;charset=utf-8">
<script type="text/javascript">
	function rndNum(n){
	    var rnd="";
	    for(var i=0;i<n;i++)
	        rnd+=Math.floor(Math.random()*10);
	    return rnd;
	}
	var websocket = null;
	var username = rndNum(5);
	//判断当前浏览器是否支持WebSocket  
	if ('WebSocket' in window) {
		websocket = new WebSocket("ws://" + document.location.host
				+ "/java-websocket/websocket/user_" + username);
	} else {
		alert('当前浏览器 Not support websocket')
	}

	//连接发生错误的回调方法  
	websocket.onerror = function() {
		setMessageInnerHTML("WebSocket连接发生错误");
	}

	//连接成功建立的回调方法  
	websocket.onopen = function() {
		setMessageInnerHTML("WebSocket连接成功");
	}

	//接收到消息的回调方法  
	websocket.onmessage = function(event) {
		setMessageInnerHTML(event.data);
	}

	//连接关闭的回调方法  
	websocket.onclose = function() {
		setMessageInnerHTML("WebSocket连接关闭");
	}

	//监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。  
	window.onbeforeunload = function() {
		closeWebSocket();
	}

	//关闭WebSocket连接  
	function closeWebSocket() {
		websocket.close();
	}
	
	function sendMsg(){
		var parm = {"To":document.getElementById("to").value,"msg":document.getElementById("msg").value};
		websocket.send(JSON.stringify(parm))
	}
	
	function setMessageInnerHTML(text){
		var div = document.createElement("div");
		div.innerHTML = text;
		document.body.appendChild(div);
	}
</script>
</head>
<body>
	接收人：<input type="text" id="to" value="">
	<br/>
	消息内容：<input type="text" id="msg">
	<br/>
	<input type="button" id="send" onclick="sendMsg()" value="发送">
</body>
</html>
