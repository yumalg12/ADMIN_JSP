<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 인코딩
request.setCharacterEncoding("UTF-8");
%>    
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Information</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

</head>
<%@include file="./header.jsp" %>

<body>
	<div class="contents">
		<div class="grid"
			style="display: grid; grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="./sidebar.jsp"%>
			</div>
			<div class="container">

<h1>비밀번호 변경</h1>

<%@ include file = "./admin/conn.jsp"%>

<%
// DB에서 정보 가져오기
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT MEMBER_ID, MEMBER_PW FROM `t_shopping_member` where MEMBER_ID = '"+member_id+"';";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();

		String PW = ""; // 자격 확인용
		
		// 결과를 출력
		while (rs.next()) {
			String userID = rs.getString("MEMBER_ID");
			PW = rs.getString("MEMBER_PW");
		%>

<!-- 결과 표시 -->
<form name="Registerform" action=./admin/userpw_update.jsp method="post" onSubmit="return changePW();">


    <div class="item">
    <label>아이디</label>
    <input type="text" name="userID" class="normal" placeholder="userID" value="<%=userID%>" maxlength="8" disabled> 
</div>

    <div class="item">
    <label>기존 비밀번호</label>
    <input type="password" name="PWold" class="normal" placeholder="Enter password" value="" maxlength="20">
    </div>
    
    <div class="item">
    <label>신규 비밀번호</label>
    <input type="password" name="PW" class="normal" placeholder="Enter password" value="" onInput="checkPWone(); checkPWtwo()" maxlength="20">
    <input type="password" class="normal" name="PWcheck" style="display: none;" placeholder="password check" oninput="checkPWtwo()" maxlength="20">
    <span class="notice" id="PWNotice" style="display: none;"> ※영문 소문자, 숫자, 특수문자로 이루어진 4~20자</span>
    </div>

<%} %>

<input type="submit" value="Save" id="save" name="save">
</form>
		</div>
</div>
	</div>

<script>

function changePW() {
	if(document.Registerform["PWold"].value == ""){
		alert("기존 비밀번호를 입력하십시오.");
		setTimeout(function() { (document.Registerform.PWold).focus(); }, 100);
		return false;
	} else if(document.Registerform["PW"].value == ""){
		alert("변경할 새 비밀번호를 입력하십시오.");
		setTimeout(function() { (document.Registerform.PW).focus(); }, 100);
		return false;
	} else if (!checkPWone() || !checkPWtwo()) {
		alert("비밀번호를 확인하십시오.");
		setTimeout(function () {document.Registerform.PWcheck.focus();}, 100);
		return false;
	} else if (!('<%=PW%>' === document.Registerform["PWold"].value)){
		setTimeout(function() { (document.Registerform.PWold).focus(); }, 100);
		alert("비밀번호가 틀렸습니다.");
		return false;
	} else if ("<%=PW%>" === document.Registerform["PW"].value){
		alert("변경할 비밀번호가 기존 비밀번호와 동일합니다.");
		setTimeout(function() { (document.Registerform.PW).focus(); }, 100);
		return false;
	} else {
		if ("<%=PW%>" === document.Registerform["PWold"].value) {
				return true;
			} else {
				alert("비밀번호 변경에 실패했습니다.");
				return false;
			}
		}
	}
</script>
<script src="./script/register.js"></script>
</body>


</html>