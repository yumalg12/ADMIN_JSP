<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script>
	<%session.removeAttribute("member_id");%>
	alert("로그아웃에 성공하였습니다.");
	setTimeout(function() { window.location.href="./login.jsp";}, 100);
</script>
</body>
</html>