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
<title>Modify Success</title>

</head>
<body>

    <%
	String member_id = (String) session.getAttribute("member_id");

    String num1=request.getParameter("num1");
    String num2=request.getParameter("num2");
    String num3=request.getParameter("num3");
    
    String email1=request.getParameter("email1");
    String email2=request.getParameter("email2");

        
    String zipcode=request.getParameter("zipcode");
	String jibunAddress=request.getParameter("jibunAddress");
	String roadAddress=request.getParameter("roadAddress");
	String namujiAddress=request.getParameter("namujiAddress");

	String SMSYNval = request.getParameter("SMSYN");
	String SMSYN = "N"; // 기본값으로 초기화

	if (SMSYNval != null && SMSYNval.equals("on")) {
	    SMSYN = "Y";
	}

	String emailYNval = request.getParameter("emailYN");
	String emailYN = "N"; // 기본값으로 초기화

	if (emailYNval != null && emailYNval.equals("on")) {
	    emailYN = "Y";
	}

	// DB 유저 정보 업데이트
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/register";
	String id = "root"; //MySQL에 접속을 위한 계정의 ID
	String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(url, id, pwd);
	
	PreparedStatement pstmt = null;
	
	
	String sql = "update t_shopping_member "+
			"set TEL1 = '"+num1+"', "+
			" TEL2 = '"+num2+"', "+
			" TEL3 = '"+num3+"', "+
			" SMSSTS_YN = '"+SMSYN+"', "+
			" EMAIL1 = '"+email1+"', "+
			" EMAIL2 = '"+email2+"', "+
			" EMAILSTS_YN = '"+emailYN+"', "+
			" ZIPCODE = '"+zipcode+"', "+
			" ROADADDRESS = '"+roadAddress+"', "+
			" JIBUNADDRESS = '"+jibunAddress+"', "+
			" NAMUJIADDRESS = '"+namujiAddress+"' "+
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
	//SMS 수신동의
	if ("<%=SMSYNval %>" == "on"){
		document.getElementById("SMSYN").checked = 'true';
	}

	//이메일 수신동의
	if ("<%=emailYNval%>" == "on"){
		document.getElementById("emailYN").checked = 'true';
		}
</script>
	<script>
	setTimeout(function() { window.location.href="../userinfo.jsp";}, 100);
	</script>
</body>
</html>