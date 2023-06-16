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
<title>Member Login</title>
</head>

<body>

<%
//form 정보 가져오기
String inputID = request.getParameter("userID");
String inputPW = request.getParameter("PW");
%>

<%@ include file = "conn.jsp"%>
<%
PreparedStatement pstmt = null;
ResultSet rs = null;

String sql = "SELECT MEMBER_ID, MEMBER_PW, DEL_YN FROM `t_shopping_member` where MEMBER_ID = '" + inputID + "';";
pstmt = conn.prepareStatement(sql);

rs = pstmt.executeQuery();

String userID = null;
String userPW = null;
String delYN = null;
while (rs.next()) {
	userID = rs.getString("MEMBER_ID");
	userPW = rs.getString("MEMBER_PW");
	delYN = rs.getString("DEL_YN");
}
%>
<script>
if ("<%=userID%>" == "null" || "<%=delYN%>" == "Y"){
	alert("가입된 ID가 없습니다.");
	history.back();
} else if ("<%=userPW%>" != "<%=inputPW%>") {
	alert("PW가 틀렸습니다.");
	history.back();
} else if ("<%=userPW%>" == "<%=inputPW%>"){
	<%
	// 세션에 ID 정보 저장
	String member_id = userID;
	session.setAttribute("member_id", member_id);
	%>
	setTimeout(function() { window.location.href="../main.jsp";}, 100);
} else {
	alert("오류가 발생했습니다.");
	setTimeout(function() { window.location.href="../login.jsp";}, 100);
}
</script>
</body>
</html>