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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<%@include file="./header.jsp" %>

<body>
<%
String sqlSelect = request.getParameter("sqlSelect");
String queryVal = request.getParameter("queryVal");
%>
<script>
$(document).ready(function() {
    var sqlSelect = "<%=sqlSelect%>";
    var queryVal = "<%=queryVal%>";

    if (sqlSelect !== null && queryVal !== null && queryVal !== "") {
        document.SearchQueryForm.sqlSelect.value = sqlSelect;
        queryValInput();
        document.getElementById("sqlInput").value = queryVal;
        document.getElementById("sqlGender").value = queryVal;
        document.getElementById("sqlYN").value = queryVal;
    } else {
        document.SearchQueryForm.sqlSelect.value = "MEMBER_ID";
        document.getElementById("sqlInput").value = "";
    }
});
</script>

	<div class="contents">
		<div class="grid"
			style="display: grid; grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="./sidebar.jsp"%>
			</div>
			<div class="container"><h1>전체회원조회</h1>
<div>
	<form name="SearchQueryForm" method="post" style="display: inline;" accept-charset="UTF-8" action="./member_db.jsp">
		<label style="width: 80px;">검색 조건: </label>
		<select class="normal" id="sqlSelect" name="sqlSelect" onChange=queryValInput()>
			<option value="MEMBER_ID">ID</option>
			<option value="MEMBER_GENDER">성별</option>
			<option value="SMSSTS_YN">SMS 수신여부</option>
			<option value="EMAILSTS_YN">이메일 수신여부</option>
		</select> 
		<input type="text" class="normal" id="sqlInput" name="queryVal" placeholder="value" style="width: 200px;"> 
		<select class="normal" id="sqlGender" name="queryVal" style="display: none; width: 200px;" disabled>
			<option value="female">여자</option>
			<option value="male">남자</option>
		</select> 
		<select class="normal" id="sqlYN" name="queryVal" style="display: none; width: 200px;" disabled>
			<option value="Y">Y</option>
			<option value="N">N</option>
		</select> 

		<input type="submit" value="Submit">
    </form>
        
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

		String sqlSearch = "";
		
		sqlSelect = request.getParameter("sqlSelect");
		queryVal = request.getParameter("queryVal");
		
		if (sqlSelect != null && queryVal != null && queryVal != ""){
			sqlSearch = "where " + sqlSelect + "='" + queryVal + "' ";
		} else {
			sqlSearch = "";
		}

		String sql = "SELECT MEMBER_ID, MEMBER_NAME, MEMBER_GENDER, TEL1, TEL2, TEL3, SMSSTS_YN, EMAIL1, EMAIL2, EMAILSTS_YN, ZIPCODE, ROADADDRESS, NAMUJIADDRESS, MEMBER_BIRTH_Y, MEMBER_BIRTH_M, MEMBER_BIRTH_D, JOINDATE FROM `t_shopping_member` "
				+ sqlSearch
				+"order by JOINDATE DESC;";

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
</div>
</div>

<script>

function show(id){
	var object = document.getElementById(id);
	object.disabled = false;
	object.style.display = "";
}

function hide(id){
	var object = document.getElementById(id);
	object.disabled = true;
	object.style.display = "none";
}

function queryValInput() {
	var selectVal = document.SearchQueryForm.sqlSelect.value;
	for (var i = 0; i < 3; i++){			
		document.SearchQueryForm.queryVal[i].value = "";
	}
	if (selectVal === "MEMBER_GENDER"){
		hide("sqlInput");
		show("sqlGender");
		hide("sqlYN");
	} else if (selectVal === "SMSSTS_YN"){
		hide("sqlInput");
		hide("sqlGender");
		show("sqlYN");
	} else if (selectVal === "EMAILSTS_YN"){
		hide("sqlInput");
		hide("sqlGender");
		show("sqlYN");
	} else {
		show("sqlInput");
		hide("sqlGender");
		hide("sqlYN");
	}
}
</script>

</body>
</html>