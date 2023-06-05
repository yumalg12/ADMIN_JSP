<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" href="./css/main.css">

</head>
<%@include file="../header.jsp"%>

<body>
	<script>
	if ("<%=member_id%>" == "null") {
			window.location.href = "./login.jsp";
		}
	</script>
	<div class="contents">
		<div class="grid"
			style="display: grid; grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="../sidebar.jsp"%>
			</div>
			<div class="container">
			<h1>메인페이지</h1>
			</div>
			</div>
			</div>

</body>
</html>