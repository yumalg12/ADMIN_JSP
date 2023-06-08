<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="org.json.simple.JSONObject"%>

<%@ include file = "./conn.jsp"%>

<%
	String userID = request.getParameter("userID");

	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "SELECT * FROM T_SHOPPING_MEMBER WHERE MEMBER_ID = '"+userID+"';";
	pstmt = conn.prepareStatement(sql);

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