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
<link rel="stylesheet" href="./css/register.css">
<title>My Information</title>
</head>
<body>
<%
String member_id = (String) session.getAttribute("member_id");
%>
<span>사용자: <%=member_id %> </span>
<input type="submit" value="Logout" onClick="location.href='./logout.jsp';">

<h1>내 정보 확인</h1>
<!-- DB에서 정보 가져오기 -->

<%
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/register";
		String id = "root"; //MySQL에 접속을 위한 계정의 ID
		String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pwd);

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `t_shopping_member` where MEMBER_ID = '"+member_id+"' order by JOINDATE DESC;";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();

		// 결과를 출력
		while (rs.next()) {
			String userID = rs.getString("MEMBER_ID");
			String PW = rs.getString("MEMBER_PW");
			String userName = rs.getString("MEMBER_NAME");
			String gender = rs.getString("MEMBER_GENDER");
			String num1 = rs.getString("TEL1");
			String num2 = rs.getString("TEL2");
			String num3 = rs.getString("TEL3");
			String SMSYN = rs.getString("SMSSTS_YN");
			String email1 = rs.getString("EMAIL1");
			String email2 = rs.getString("EMAIL2");
			String emailYN = rs.getString("EMAILSTS_YN");
			String zipcode = rs.getString("ZIPCODE");
			String roadAddress = rs.getString("ROADADDRESS");
			String jibunAddress = rs.getString("JIBUNADDRESS");
			String namujiAddress = rs.getString("NAMUJIADDRESS");
			Integer bYear = rs.getInt("MEMBER_BIRTH_Y");
			Integer bMon = rs.getInt("MEMBER_BIRTH_M");
			Integer bDay = rs.getInt("MEMBER_BIRTH_D");
		%>

<!-- 결과 표시 -->
    <label>아이디</label>
    <input type="text" name="userID" class="normal" placeholder="userID" value="<%=userID%>" disabled> 
    
    <br>
    <label>비밀번호</label>
    <input type="password" name="PW" class="normal" placeholder="password" value="<%=PW%>" disabled>
    
    <br>
    <label>이름</label>
    <input type="text" name="userName" class="normal" placeholder="username" value="<%=userName%>" disabled>
    
    <br>
    <label>성별</label>
    <span>여자</span><input type="radio" name="gender" value="female" <%if (gender.equals("female")) out.print("checked");%> disabled>
    <span> 남자</span><input type="radio" name="gender" value="male" <%if (gender.equals("male")) out.print("checked");%> disabled>
    
    <br>
    <label>생년월일</label>
    <input type="text" value="<%=bYear %>" class="normal" style="width: 50px;" disabled><span>년 </span>
    <input type="text" value="<%=bMon %>" class="normal" style="width: 50px;" disabled><span>월 </span>
    <input type="text" value="<%=bDay %>" class="normal" style="width: 50px;" disabled><span>일 </span>
    
    <br>
    <label>전화번호</label>
    <input type="text" class="normal" style="width: 50px;" name="num_1" value="<%=num1%>" disabled> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num_2" value="<%=num2%>" disabled> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num_3" value="<%=num3%>" disabled> 
	<br>
	<label></label>
	<input type="checkbox" id="SMSYN" disabled><span>SMS 수신 동의</span>

    <br>
    <label>이메일</label>
    <input type="text" name="email_1" class="normal" value="<%=email1%>" disabled>
    <span>@</span>
    <input type="text" name="email_2" class="normal" value="<%=email2%>" disabled>
	<br>
	<label></label>
    <input type="checkbox" id="emailYN" disabled><span>이메일 수신 동의</span>
        
    <br>
    <label>주소</label>
	<span>우편번호: </span><input value="<%=zipcode%>" class="normal" type="text" id="zipcode" name="zipcode" disabled> 
	<br>
	<label></label><span>도로명 주소: </span><input value="<%=roadAddress%>" class="normal" type="text" id="jibunAddress" name="jibunAddress" style="width: 300px;" disabled>
	<br>
	<label></label><span>지번 주소: </span><input value="<%=jibunAddress%>" class="normal" type="text" id="roadAddress" name="roadAddress" style="width: 300px;" disabled>
	<br>
	<label></label><span>나머지 주소: </span><input value="<%=namujiAddress%>" class="normal" type="text" name="namujiAddress" style="width: 300px;" disabled>

<%} %>

<div>
<input type="submit" value="Modify" onClick="modifyInfo()">
</div>

<script>
function modifyInfo() {
	  var elements = document.getElementsByTagName("*");
	  for (var i = 0; i < elements.length; i++) {
	    elements[i].removeAttribute("disabled");
	  }
	}
</script>
</body>


</html>