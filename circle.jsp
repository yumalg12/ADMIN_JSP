<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
// 인코딩
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Circle Drawing</title>

<script>
var circle = {
		area:function(radius){
			return Math.PI * radius * radius;
		},
		draw: function(radius, color1, color2) {
			  let canvas = document.getElementById("canvas");
			  let ctx = canvas.getContext("2d");
			  ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear the canvas before drawing
			  
			  ctx.beginPath();
			  ctx.arc(canvas.width / 2, canvas.height / 2, radius, 0, 2 * Math.PI);
			  ctx.strokeStyle = color1;
			  ctx.lineWidth = 1;
			  ctx.stroke();
			  ctx.fillStyle = color2;
			  ctx.fill();
			}
};

function calArea(){
	let radius = document.getElementById('circleradius').value;
	let decimal = 4;
	let result = Math.round(circle.area(radius) * (10 ** decimal) ) / (10 ** decimal);
	var area = document.getElementById('circlearea');
	
	document.getElementById('circlearea').value = result;
}

</script>
</head>
<%@include file="./header.jsp" %>

<body>
<div class="contents">

<h1>원</h1>
    
    <div>
<label>Radius: </label><input type="text" class="normal" id="circleradius" oninput="circle.draw(this.value, 'skyblue', 'aliceblue'); calArea()"><span>px</span><br>
<label>Area: </label><input type="text" class="normal" id="circlearea"><span>px<sup>2</sup></span>
<br>
<canvas id="canvas" class="normal"></canvas>
    </div>
</div>

</body>
</html>