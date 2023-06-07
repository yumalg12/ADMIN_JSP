<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<h2 onClick="location.href='./main.jsp'">Dashboard</h2>
<label>마이페이지</label>
	<div class="item">
		<a href="./myinfo.jsp">내 정보 수정</a><br> 
		<a href="./mypw.jsp">비밀번호 변경</a>
	</div>
	<br>
	<label>회원관리</label>
	<div class="item">
		<a href="./user_db.jsp">전체회원조회</a>
	</div>
	<br>
	<label>게시글 관리</label>
	<div class="item">
		<a href="javascript:alert('개발 예정입니다.');">게시판</a>
	</div>
	
	<script>
if ("<%=member_id %>" == "null") {
	alert("잘못된 접근입니다.");
	setTimeout(function() { window.location.href="./login.jsp";}, 100);
}
</script>