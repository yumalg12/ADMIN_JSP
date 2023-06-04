<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" href="./css/main.css">

</head>
<%@include file="./header.jsp"%>

<body>
	<script>
	if ("<%=member_id%>" == "null"){
		window.location.href="./login.jsp";
	}
	</script>
	<div class="contents">
		<h1>메인페이지</h1>
		<div class="grid" style="display: grid; grid-template-column: auto;">
			<div class="container">
				<div class="item">
					<a href="./member_db.jsp">가입자 목록 보기</a>
				</div>
				<div class="item">
					<a href="./board.jsp">게시판</a>
				</div>
			</div>
		</div>
	</div>

</body>
</html>