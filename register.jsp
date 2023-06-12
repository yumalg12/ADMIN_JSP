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
<title>Member Register</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="./script/execDaumPostcode.js"></script>
<script src="./script/fn_overlapped.js"></script>

</head>
<%@include file="./header.jsp" %>

<body>
<div class="contents">
<h1>회원가입</h1>
<form name="Registerform" action=./admin/register_ok.jsp method="post" onSubmit="return validateForm();">
<div class="item">
    <label>아이디</label>
    <input type="text" class="form-control" id="userID" name="userID" placeholder="user ID" oninput="checkID(this.value)" maxlength="12"> 
    <input type="hidden" id="userIDval" name="userIDval"> 
    <input type="button" class="btn" id="checkIDdup" value="중복확인" onClick="fn_overlapped();" style="display: none;">
    <span class="notice" id="IDNotice" style="display: none;"> ※영문 소문자, 숫자로 이루어진 4~12자</span>
</div>

    <div class="item">
    <label>비밀번호</label>
    <input type="password" class="form-control" name="PW" placeholder="password" oninput="checkPWone(); checkPWtwo()" maxlength="20">
    <input type="password" class="form-control" name="PWcheck" style="display: none;" placeholder="password check" oninput="checkPWtwo()" maxlength="20">
    <span class="notice" id="PWNotice" style="display: none;"> ※영문 소문자, 숫자, 특수문자로 이루어진 4~20자</span>
    </div>
    
    <div class="item">
    <label>이름</label>
    <input type="text" class="form-control" name="userName" placeholder="user name" oninput="checkName()">
    <span class="notice" id="nameNotice" style="display: none;"> ※한글 실명 2~5자</span>
    </div>

    <div class="item">
    <label>부서</label>
    <select class="form-select" name="dept">
		<option value="10">운영/회계</option>
		<option value="20">마케팅</option>
		<option value="30">기술연구소</option>
		<option value="40">개발</option>
		<option value="50">고객지원</option>
	</select>
    </div>
    
<div class="item">
    <label>성별</label>
    <span>여자</span><input type="radio" name="gender" value="female">
    <span> 남자</span><input type="radio" name="gender" value="male">
</div>    
    
    <div class="item">
    <label>생년월일</label>
    <input type="date" class="form-control" name="birthDate" onChange="checkBirth();">
    <span class="notice" id="ageNotice" style="display: none;"> ※만 14세 미만은 가입할 수 없습니다.</span>
    <span class="notice" id="ageNotice2" style="display: none;"> ※미래 날짜는 선택할 수 없습니다.</span>
    </div>

<div class="item">
    <label>전화번호</label> 
    <select class="form-select" name="num1" onchange="phoneInput()">
		<option value="010">010</option>
		<option value="input">직접 입력</option>
	</select> 
	<input type="text" class="form-control" style="display: none; width: 80px;" name="num1" oninput="checkPhoneOne(this.name)" maxlength="3"> 
	<span>-</span> 
	<input type="text" class="form-control" style="width: 80px;" name="num2" oninput="checkPhone(this.name)" maxlength="4"> 
	<span>-</span> 
	<input type="text" class="form-control" style="width: 80px;" name="num3" oninput="checkPhone(this.name)" maxlength="4"> 
	<br>
	<label></label>
	<input type="checkbox" id="SMSYN" name="SMSYN"><span>SMS 수신 동의</span>
</div>
	
	<div class="item">
    <label>이메일</label>
	<input type="text" class="form-control" name="email1" onChange="checkMail1()")> 
	<span>@</span> 
	<select class="form-select" name="email2" style="width: 180px;" onchange="emailInput()">
		<option value="naver.com">naver.com</option>
		<option value="gmail.com">gmail.com</option>
		<option value="input">직접 입력</option>
	</select>
	<input type="text" class="form-control" style="display: none; width: 180px;" name="email2" oninput="checkMail2()"> 
	<br>
	<label></label>
    <input type="checkbox" id="emailYN" name="emailYN"><span>이메일 수신 동의</span>
	</div>

<div class="item">
    <label>주소</label>

	<span class="addressdiv" style="margin-left: 0px;">우편번호: </span><input class="form-control" type="text" id="zipcode" name="zipcode" onInput= checkZipCode() maxlength="5"> 
	<span class="btn" onClick="javascript:execDaumPostcode()">우편번호 검색</span>
	<br>
	<label></label><span class="addressdiv">지번 주소: </span><input class="form-control" type="text" id="jibunAddress" name="jibunAddress" style="width: 300px;" onInput= checkAddress(this.name)>
	<br>
	<label></label><span class="addressdiv">도로명 주소: </span><input class="form-control" type="text" id="roadAddress" name="roadAddress" style="width: 300px;" onInput= checkAddress(this.name)>
	<br>
	<label></label><span class="addressdiv">나머지 주소: </span><input class="form-control" type="text" name="namujiAddress" style="width: 300px;">
</div>    

<div class="item">
    <input type="submit" value="Register">
</div>
</form>

<script src="./script/register.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
</div>
</body>
</html>