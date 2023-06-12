<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h2 onClick="location.href='./main.jsp'">Dashboard</h2>
<label>마이페이지</label>
	<div class="item">
		<a href="./myinfo.jsp">내 정보 수정</a><br> 
		<a href="./mypw.jsp">비밀번호 변경</a>
	</div>
	<br>
	<label>DB</label>
	<div class="item">
		<a href="./user_db.jsp">전체회원조회</a><br>
		<a href="./dept.jsp">부서 관리</a><br>
		<a href="./log.jsp">변경 내역</a>
	</div>

	
	<script>
if ("<%=member_id %>" == "null") {
	alert("잘못된 접근입니다.");
	setTimeout(function() { window.location.href="./login.jsp";}, 100);
}
</script>