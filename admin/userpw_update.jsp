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
<title>Update Success</title>

</head>
<body>

    <%
	String member_id = (String) session.getAttribute("member_id");

    String PW=request.getParameter("PW");

    %>
    <%@ include file = "./conn.jsp"%>
    <%
	// DB 유저 정보 업데이트
	PreparedStatement pstmt = null;
	
	
	String sql = "update t_shopping_member "+
			"set MEMBER_PW = '"+PW+"' "+
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
	alert("비밀번호 변경이 완료되었습니다. 새로운 비밀번호로 로그인하십시오.");
	setTimeout(function() { window.location.href="./logout.jsp";}, 100);
	</script>
</body>
</html>