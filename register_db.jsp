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
</head>
<body>
<table border=1>
		<tr>
	<td>User ID</td>
	<td>Gender</td>
	<td>Birth Month</td>	
	<td>SSN</td>
</tr>

		<%
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/campusdb";
		String id = "root"; //MySQL에 접속을 위한 계정의 ID
		String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pwd);

		out.println("<h1>MySQL DB 연동</h1>");

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT userID, gender, birthMonth, SSN FROM register.users;";
		pstmt = conn.prepareStatement(sql);

		// 4) 실행
		rs = pstmt.executeQuery();

		// 5) 결과를 테이블에 출력
		while (rs.next()) {
			String userID = rs.getString("userID");
			String gender = rs.getString("gender");
			int birthMonth = rs.getInt("birthMonth");
			String SSN = rs.getString("SSN");
		%>

		<tr>
	<td><%=userID%></td>
	<td><%=gender%></td>
	<td><%=birthMonth%></td>	
	<td><%=SSN%></td>
</tr>
<%
	}
%>

</table>
	
</body>
</html>