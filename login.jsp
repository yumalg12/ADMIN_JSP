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
<title>Member Login</title>
<link rel="stylesheet" href="./css/main.css">

</head>
<%@include file="../header.jsp" %>

<body>
<div class="contents">

<h1>로그인</h1>
<form name="Loginform" action="./account/login_ok.jsp" method="post" style="display: inline;">
    <label>아이디</label>
    <input type="text" class="normal" id="userID" name="userID" placeholder="user ID" maxlength="8"> 
    
    <br>
    <label>비밀번호</label>
    <input type="password" class="normal" name="PW" placeholder="password" maxlength="20">
 
    <br>    
    <input type="submit" value="Login">
</form>
    <input type="submit" value="Register" onClick=(location.href='./register.jsp')>
    
    
<script src="http://code.jquery.com/jquery-latest.js"></script> 
</div>
</body>
</html>