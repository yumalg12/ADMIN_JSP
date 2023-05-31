<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/register.css">
</head>
<body>
<h1>회원가입 완료</h1>

<!-- 결과 표시 -->
    <label>ID</label>
    <%String userID=request.getParameter("userID");%>
    <input type="text" name="userID" placeholder="username" value="<%=userID%>" disabled> 
    
    <br>
    <label>Password</label>
    <%String PW=request.getParameter("PW");%>
    <input type="password" name="PW" placeholder="password" value="<%=PW%>" disabled>
    
    <br>
    <label>Gender</label>
    <span>Female</span><input type="radio" name="gender" value="female" disabled>
    <span> Male</span><input type="radio" name="gender" value="male" disabled>
    
    <br>
    <label>Birth Month</label>
    <%String birthMonth=request.getParameter("month");
      int convertedMonth = Integer.parseInt(birthMonth);%>
    <select name="month" disabled>
  <option value="<%=birthMonth%>"><%=convertedMonth%>월</option>
    </select>
    
    <br>
    <label>SSN</label>
    <%String ssnFirst=request.getParameter("ssnFirst");%>
    <input type="text" name="ssnFirst" placeholder="First part" value="<%=ssnFirst%>" disabled>
    <span>-</span>
    <%String ssnLast=request.getParameter("ssnLast");%>
    <input type="password" name="ssnLast" placeholder="Last part" value="<%=ssnLast%>" disabled>
    
    <%String SSN = ssnFirst + "-" + ssnLast; %>
    <br>

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

	String sql = "insert into users(userID,PW,gender,birthMonth,SSN) "+
			"values('"+userID+"','"+PW+"','"+Gender+"','"+convertedMonth+"','"+SSN+"');";
	System.out.println(sql);
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