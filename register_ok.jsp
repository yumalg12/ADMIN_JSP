<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>Register Success</title>
<link rel="stylesheet" href="./css/register.css">
</head>
<body>
<h1>회원가입 완료</h1>

<!-- 결과 표시 -->
    <label>아이디</label>
    <%String userID=request.getParameter("userID");%>
    <input type="text" name="userID" class="normal" placeholder="userID" value="<%=userID%>" disabled> 
    
    <br>
    <label>비밀번호</label>
    <%String PW=request.getParameter("PW");%>
    <input type="password" name="PW" class="normal" placeholder="password" value="<%=PW%>" disabled>
    
    <br>
    <label>이름</label>
    <%String name=request.getParameter("userName");%>
    <input type="text" name="userName" class="normal" placeholder="username" value="<%=name%>" disabled>
    
    <br>
    <label>성별</label>
    <span>여자</span><input type="radio" name="gender" value="female" disabled>
    <span> 남자</span><input type="radio" name="gender" value="male" disabled>
    
    <br>
    <label>생년월일</label>
    <%String birthDate=request.getParameter("birthDate");
    int bYear = Integer.parseInt(birthDate.substring(0,4)); 
    int bMon = Integer.parseInt(birthDate.substring(5,7)); 
    int bDay = Integer.parseInt(birthDate.substring(8,10)); %>
    <input type="text" value="<%=bYear %>" class="normal" style="width: 50px;" disabled><span>년 </span>
    <input type="text" value="<%=bMon %>" class="normal" style="width: 50px;" disabled><span>월 </span>
    <input type="text" value="<%=bDay %>" class="normal" style="width: 50px;" disabled><span>일 </span>
    
    <br>
    <label>전화번호</label>
    <%String num1=request.getParameter("num_1");
    String num2=request.getParameter("num_2");
    String num3=request.getParameter("num_3");
    %>
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
    <%String email1=request.getParameter("email_1");%>
    <input type="text" name="email_1" class="normal" value="<%=email1%>" disabled>
    <span>@</span>
    <%String email2=request.getParameter("email_2");%>
    <input type="text" name="email_2" class="normal" value="<%=email2%>" disabled>
	<br>
	<label></label>
    <input type="checkbox" id="emailYN" disabled><span>이메일 수신 동의</span>
        
    <br>
    <label>주소</label>
    <%String zipcode=request.getParameter("zipcode");%>
	<span>우편번호: </span><input value="<%=zipcode%>" class="normal" type="text" id="zipcode" name="zipcode" disabled> 
	<br>
	<%String jibunAddress=request.getParameter("jibunAddress");%>
	<label></label><span>도로명 주소: </span><input value="<%=jibunAddress%>" class="normal" type="text" id="jibunAddress" name="jibunAddress" style="width: 300px;" disabled>
	<br>
	<%String roadAddress=request.getParameter("roadAddress");%>
	<label></label><span>지번 주소: </span><input value="<%=roadAddress%>" class="normal" type="text" id="roadAddress" name="roadAddress" style="width: 300px;" disabled>
	<br>
	<%String namujiAddress=request.getParameter("namujiAddress");%>
	<label></label><span>나머지 주소: </span><input value="<%=namujiAddress%>" class="normal" type="text" name="namujiAddress" style="width: 300px;" disabled>
    

<script>	
	//gender
	<%String Gender=request.getParameter("gender");%>

	var genval = "<%=Gender%>";

	var genderRadio = document.querySelectorAll('input[name="gender"]');
	for (var i = 0; i < genderRadio.length; i++) {
		if (genderRadio[i].value === genval) {
			genderRadio[i].checked = true;
			break;
		}
	}	
	
	//SMS 수신동의
	<%String SMSYNval = request.getParameter("SMSYN");%>
	if ("<%=SMSYNval%>" == "on"){
		document.getElementById("SMSYN").checked = 'true';
		<%SMSYNval = "true";%>
	} else {
		<%SMSYNval = "false";%>
	}
	
	//이메일 수신동의
	<%String emailYNval = request.getParameter("emailYN");%>
	if ("<%=emailYNval%>" == "on"){
		document.getElementById("emailYN").checked = 'true';
		<%emailYNval = "true";%>
	} else {
		<%emailYNval = "false";%>
	}
</script>


	<%
	// 유저 정보를 DB에 추가
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/register";
	String id = "root"; //MySQL에 접속을 위한 계정의 ID
	String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	PreparedStatement pstmt = null;

	String sql = "insert into t_shopping_member"+
			"(MEMBER_ID, MEMBER_PW, MEMBER_NAME, MEMBER_GENDER, "
			+"TEL1, TEL2, TEL3, SMSSTS_YN, "
			+"EMAIL1, EMAIL2, EMAILSTS_YN, "
			+"ZIPCODE, ROADADDRESS, JIBUNADDRESS, NAMUJIADDRESS, "
			+"MEMBER_BIRTH_Y, MEMBER_BIRTH_M, MEMBER_BIRTH_D) "+
			"values('"
			+userID+"','"+PW+"','"+name+"','"+Gender+"','"
			+num1+"','"+num2+"','"+num3+"','"+SMSYNval+"','"
			+email1+"','"+email2+"','"+emailYNval+"','"
			+zipcode+"','"+roadAddress+"','"+jibunAddress+"','"+namujiAddress+"','"
			+bYear+"','"+bMon+"','"+bDay
			+"');";
	
	pstmt = conn.prepareStatement(sql);

	// 실행 및 연결 종료
	try{
	pstmt.executeUpdate();
	} catch(Exception e) {
	%>
	<br><br>
	<span>잘못된 접근입니다.</span>
	<script>
	setTimeout(function() { window.location.href="./register.jsp";}, 1000);
	</script>
	<%
	}
	conn.close();
	%>

</body>
</html>