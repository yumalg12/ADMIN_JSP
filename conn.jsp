
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

	<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/register";
	String id = "root"; //MySQL에 접속을 위한 계정의 ID
	String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	%>
