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
<title>Member List from DB</title>
<link rel="stylesheet" href="./css/main.css">
</head>
<%@include file="./header.jsp" %>

<body>
<div class="contents">
<h1>가입자 정보</h1>
<div>
    <form name="SearchQueryForm" method="post" style="display: inline;">
    <label>SQL Query: </label>
    <input type="text" class="normal" name="query" placeholder="where ..."  value ="" style="width: 300px;">
        <input type="submit" value="Submit">
        </form>
          <input role="switch" type="checkbox" />
        
</div>
<br>
<table>
	<tr>
		<th>Idx</th>
		<th>아이디</th>
		<th>이름</th>
		<th>성별</th>
		<th>연락처</th>
		<th>SMS 수신</th>
		<th>이메일</th>
		<th>이메일 수신</th>
		<th>주소</th>
		<th>생년월일</th>
		<th>가입일</th>
	</tr>	

		<%
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/register";
		String id = "root"; //MySQL에 접속을 위한 계정의 ID
		String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pwd);

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT MEMBER_ID, MEMBER_NAME, MEMBER_GENDER, TEL1, TEL2, TEL3, SMSSTS_YN, EMAIL1, EMAIL2, EMAILSTS_YN, ZIPCODE, ROADADDRESS, NAMUJIADDRESS, MEMBER_BIRTH_Y, MEMBER_BIRTH_M, MEMBER_BIRTH_D, JOINDATE FROM `t_shopping_member` order by JOINDATE DESC;";
		pstmt = conn.prepareStatement(sql);

		// 4) 실행
		rs = pstmt.executeQuery();

		// 5) 결과를 테이블에 출력
int i = 1;
		while (rs.next()) {
			Integer idx = i++;
			String userID = rs.getString("MEMBER_ID");
			String userName = rs.getString("MEMBER_NAME");
			String gender = rs.getString("MEMBER_GENDER");
			String tel1 = rs.getString("TEL1");
			String tel2 = rs.getString("TEL2");
			String tel3 = rs.getString("TEL3");
			String SMSYN = rs.getString("SMSSTS_YN");
			String email1 = rs.getString("EMAIL1");
			String email2 = rs.getString("EMAIL2");
			String emailYN = rs.getString("EMAILSTS_YN");
			String zipcode = rs.getString("ZIPCODE");
			String roadaddress = rs.getString("ROADADDRESS");
			String namujiaddress = rs.getString("NAMUJIADDRESS");
			Integer bYear = rs.getInt("MEMBER_BIRTH_Y");
			Integer bMon = rs.getInt("MEMBER_BIRTH_M");
			Integer bDay = rs.getInt("MEMBER_BIRTH_D");
			String joinDate = rs.getString("JOINDATE").substring(0,10);
		%>

		<tr>
			<td><%=idx%></td>
			<td><%=userID%></td>
			<td><%=userName%></td>
			<td><%=gender%></td>
			<td><%=tel1+"-"+tel2+"-"+tel3%></td>
			<td><%=SMSYN%></td>
			<td><%=email1+"@"+email2%></td>
			<td><%=emailYN%></td>
			<td><%="(우)"+zipcode+" "+roadaddress+" "+namujiaddress%></td>
			<td><%=bYear+"년 "+bMon+"월 "+bDay+"일"%></td>
			<td><%=joinDate%></td>
		</tr>
<%
	}
%>

</table>
</div>

<script>
if ("<%=member_id %>" == "null") {
	alert("잘못된 접근입니다.");
	setTimeout(function() { window.location.href="./login.jsp";}, 100);
}
</script>

</body>
</html>