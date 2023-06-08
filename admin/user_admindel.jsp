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
<%@ include file = "./conn.jsp"%>

    <%
	String delID = request.getParameter("delID");

	// DB 유저 정보 확인 및 제거
	
	PreparedStatement pstmt = null;
	
	
	//String sql = "delete from t_shopping_member where MEMBER_ID = '"+member_id+"';";//
	String sql = "update t_shopping_member set DEL_YN = 'Y' where MEMBER_ID = '"+delID+"';";
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
	alert("<%=delID%> 계정 삭제가 완료되었습니다.");
	setTimeout(function() { window.location.href="../user_db.jsp";}, 100);
	</script>
</body>
</html>