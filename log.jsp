<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>DB Log</title>

<style>
.smallth{
width: 20%; 
min-width: 80px;
}

.smalltd{
text-align:center;}
</style>
</head>
<%@include file="./header.jsp"%>

<body>
	<div class="contents">
		<div class="grid" style="grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="./sidebar.jsp"%>
			</div>
			<div class="container">

				<h1>변경 내역</h1>
				<table>
<tr>
						<th class="smallth">Idx</th>
						<th>로그 내역</th>
						<th>발생 시각</th>
					</tr>

					<%@ include file="./admin/conn.jsp"%>

					<%
					// DB에서 정보 가져오기
					PreparedStatement pstmt = null;
					ResultSet rs = null;

					String sql = "SELECT * FROM t_shopping_log ORDER BY idx desc;";

					pstmt = conn.prepareStatement(sql);

					rs = pstmt.executeQuery();

					// 결과를 출력
					while (rs.next()) {
						Integer idx = rs.getInt("idx");
						String log = rs.getString("log");
						String timestamp = rs.getString("timestamp").substring(0,19);
					%>

					<tr>
						<td class="smalltd"><%=idx%></td>
						<td><%=log%></td>
						<td><%=timestamp%></td>
					</tr>
					<%
					}
					%>
				</table>
				<br>

			</div>
		</div>
	</div>
<script>
function checkDept () {
	var deptno = document.Registerform.deptno.value;
	var dname =  document.Registerform.dname.value;
	
	var regex = /^[0-9]{2,5}$/;
	
		if (deptno == null || deptno == "") {
			alert("부서 번호를 입력하십시오.");
			  setTimeout(function () { document.Registerform.deptno.focus(); }, 100);
			return false;
		} else if (!regex.test(deptno)) {
			alert("부서 번호는 2자리 이상의 숫자여야 합니다.");
			  setTimeout(function () { document.Registerform.deptno.focus(); }, 100);
			return false;
		} else if (regex.test(deptno)) {
			if (dname == null || dname == "") {
				alert("부서 이름을 입력하십시오.");
				  setTimeout(function () { document.Registerform.dname.focus(); }, 100);
				return false;
			} else if (dname.length < 2) {
				alert("부서 이름은 2글자 이상이어야 합니다.");
				  setTimeout(function () { document.Registerform.dname.focus(); }, 100);
				return false;
			} else if (dname.length >= 2) {
				return true;
			} else {
				alert("오류가 발생했습니다.");
				  setTimeout(function () { document.Registerform.dname.focus(); }, 100);
				return false;
			}
		} else {
			alert("오류가 발생했습니다..");
			  setTimeout(function () { document.Registerform.deptno.focus(); }, 100);
			return false;
		}
	}
</script>
</body>
</html>