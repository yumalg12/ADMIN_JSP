<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONObject"%>

<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/register";
	String id = "root";                     //MySQL에 접속을 위한 계정의 ID
	String pwd = "mysql";            //MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);

	String userID = request.getParameter("userID");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM T_SHOPPING_MEMBER WHERE MEMBER_ID = '"+userID+"';";
	pstmt = conn.prepareStatement(sql);
	//out.print(sql);

	rs = pstmt.executeQuery();
	
	response.setContentType("application/json");
	PrintWriter outt = response.getWriter();
	
	JSONObject resultObj = new JSONObject();
	
	if(rs.next()){
		resultObj.put("result","true");
		//out.print("true");
	} else {
		resultObj.put("result","false");
		//out.print("false");
	}
	
	outt.print(resultObj.toString());
	
%>