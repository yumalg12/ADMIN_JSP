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
<title>User Account Delete</title>

</head>
<body>

    <%
	String member_id = (String) session.getAttribute("member_id");

	// DB 유저 정보 확인 및 제거
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/register";
	String id = "root"; //MySQL에 접속을 위한 계정의 ID
	String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	PreparedStatement pstmt = null;
	
	
	String sql = "delete from t_shopping_member "+
			"where MEMBER_ID = '"+member_id+"';";

	pstmt = conn.prepareStatement(sql);

	// 실행 및 연결 종료
	try{
	pstmt.executeUpdate();
	} catch(Exception e) {
	%>
	<br><br>
	<span>잘못된 접근입니다.</span>

	<%
	}
	conn.close();
	%>

	<script>
	<%session.removeAttribute("member_id");%>
	alert("계정 삭제가 완료되었습니다.");
	setTimeout(function() { window.location.href="../main.jsp";}, 100);
	</script>
</body>
</html>