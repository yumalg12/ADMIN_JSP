<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 인코딩
request.setCharacterEncoding("UTF-8");
%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Department Adding Success</title>
<link rel="stylesheet" href="../css/main.css">
</head>
<%@include file="../header.jsp" %>

<body>
<div class="contents">

    <%String deptnoInput=request.getParameter("deptno");
    int deptno = Integer.parseInt(deptnoInput); 
   
    String dname=request.getParameter("dname");%>

<%@ include file = "./conn.jsp"%>
<%
	// 유저 정보를 DB에 추가
	PreparedStatement pstmt = null;

	String sql = "insert into t_dept"+
			"(DEPTNO, DNAME) "+
			"values('"
			+deptno+"','"+dname+"');";
	
	pstmt = conn.prepareStatement(sql);

	// 실행 및 연결 종료
	try{
	pstmt.executeUpdate();
	%>
	<script>
	setTimeout(function() { window.location.href="../dept.jsp";}, 100);
	</script>
	<%
	} catch(Exception e) {
	%>
	<br><br>
	<span style="color: red;">잘못된 접근입니다.</span>
	<script>
	setTimeout(function() { window.location.href="history.back(1)";}, 100);
	</script>
	<%
	}
	conn.close();
	%>

</div>
</body>
</html>