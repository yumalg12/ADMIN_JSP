<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="./css/main.css">
<title>My Information</title>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
      
      // 우편번호와 주소 정보를 초기화한다.
      document.getElementById('zipcode').value = "";
      document.getElementById('roadAddress').value = "";
      document.getElementById('jibunAddress').value = "";
      
      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기한다.
      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
      var extraRoadAddr = ''; // 도로명 조합형 주소 변수

      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
        extraRoadAddr += data.bname;
      }
      // 건물명이 있고, 공동주택일 경우 추가한다.
      if(data.buildingName !== '' && data.apartment === 'Y'){
        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
      }
      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
      if(extraRoadAddr !== ''){
        extraRoadAddr = ' (' + extraRoadAddr + ')';
      }
      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
      if(fullRoadAddr !== ''){
        fullRoadAddr += extraRoadAddr;
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('zipcode').value = data.zonecode; //5자리 새 우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;

      window.close();
    }
  }).open();
}
</script>
</head>
<%@include file="./header.jsp" %>

<body>
	<div class="contents">
		<div class="grid"
			style="display: grid; grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="../sidebar.jsp"%>
			</div>
			<div class="container">

<h1>내 정보 수정</h1>

<%
// DB에서 정보 가져오기
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/register";
		String id = "root"; //MySQL에 접속을 위한 계정의 ID
		String pwd = "mysql"; //MySQL에 접속을 위한 계정의 암호
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, id, pwd);

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `t_shopping_member` where MEMBER_ID = '"+member_id+"' order by JOINDATE DESC;";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();

		String PW = ""; // 자격 확인용
		
		// 결과를 출력
		while (rs.next()) {
			String userID = rs.getString("MEMBER_ID");
			PW = rs.getString("MEMBER_PW");
			String userName = rs.getString("MEMBER_NAME");
			String gender = rs.getString("MEMBER_GENDER");
			String num1 = rs.getString("TEL1");
			String num2 = rs.getString("TEL2");
			String num3 = rs.getString("TEL3");
			String SMSYN = rs.getString("SMSSTS_YN");
			String email1 = rs.getString("EMAIL1");
			String email2 = rs.getString("EMAIL2");
			String emailYN = rs.getString("EMAILSTS_YN");
			String zipcode = rs.getString("ZIPCODE");
			String roadAddress = rs.getString("ROADADDRESS");
			String jibunAddress = rs.getString("JIBUNADDRESS");
			String namujiAddress = rs.getString("NAMUJIADDRESS");
			Integer bYear = rs.getInt("MEMBER_BIRTH_Y");
			Integer bMon = rs.getInt("MEMBER_BIRTH_M");
			Integer bDay = rs.getInt("MEMBER_BIRTH_D");
		%>

<!-- 결과 표시 -->
<form name="Registerform" action=./account/userinfo_update.jsp method="post" onSubmit="return checkPW();">


    <div class="item">
    <label>아이디</label>
    <input type="text" name="userID" class="normal" placeholder="userID" value="<%=userID%>" maxlength="8" disabled> 
</div>

    <div class="item">
    <label>비밀번호</label>
    <input type="password" name="PW" class="normal" placeholder="Enter password" value="1q2w3e4r5t6y7u8i9o0p" onInput="checkPWone()" disabled maxlength="20">
    <span class="notice" id="PWNotice" style="display: none;"> ※영문 소문자, 숫자, 특수문자로 이루어진 4~20자</span>
    </div>

    <div class="item">
        <label>이름</label>
    <input type="text" name="userName" class="normal" placeholder="username" value="<%=userName%>" maxlength="5" disabled>
</div>

    <div class="item">
    <label>성별</label>
    <span>여자</span><input type="radio" name="gender" value="female" <%if (gender.equals("female")) out.print("checked");%> disabled>
    <span> 남자</span><input type="radio" name="gender" value="male" <%if (gender.equals("male")) out.print("checked");%> disabled>
</div>

    <div class="item">
    <label>생년월일</label>
    <input type="text" value="<%=bYear %>" class="normal" style="width: 50px;" maxlength="4" disabled><span>년 </span>
    <input type="text" value="<%=bMon %>" class="normal" style="width: 50px;" maxlength="2" disabled><span>월 </span>
    <input type="text" value="<%=bDay %>" class="normal" style="width: 50px;" maxlength="2" disabled><span>일 </span>
</div>

    <div class="item">
    <label>전화번호</label>
    <input type="text" class="normal" style="width: 50px;" name="num1" value="<%=num1%>" onInput="checkPhone(this.name)" disabled maxlength="3"> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num2" value="<%=num2%>" onInput="checkPhone(this.name)" disabled maxlength="4"> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num3" value="<%=num3%>" onInput="checkPhone(this.name)" disabled maxlength="4"> 
	<br>
	<label></label>
	<input type="checkbox" id="SMSYN" name="SMSYN" <%if (SMSYN.equals("Y")) out.print("checked");%> disabled><span>SMS 수신 동의</span>
</div>

    <div class="item">
    <label>이메일</label>
    <input type="text" name="email1" class="normal" value="<%=email1%>" onInput="checkMail1()" disabled>
    <span>@</span>
    <input type="text" name="email2" class="normal" value="<%=email2%>" onInput="checkMail2()" disabled>
	<br>
	<label></label>
    <input type="checkbox" id="emailYN" name="emailYN" <%if (emailYN.equals("Y")) out.print("checked");%> disabled><span>이메일 수신 동의</span>
</div>

    <div class="item">
    <label>주소</label>
	<span class="addressdiv" style="margin-left: 0px;">우편번호: </span><input value="<%=zipcode%>" class="normal" type="text" id="zipcode" name="zipcode" disabled> 
	<span class="btn" onClick="javascript:execDaumPostcode()" id="adrsSearchBtn" style="display: none;">우편번호 검색</span>
	<br>
	<label></label><span class="addressdiv">지번 주소: </span><input value="<%=jibunAddress%>" class="normal" type="text" id="jibunAddress" name="jibunAddress" style="width: 300px;" disabled>
	<br>
	<label></label><span class="addressdiv">도로명 주소: </span><input value="<%=roadAddress%>" class="normal" type="text" id="roadAddress" name="roadAddress" style="width: 300px;" disabled>
	<br>
	<label></label><span class="addressdiv">나머지 주소: </span><input value="<%=namujiAddress%>" class="normal" type="text" name="namujiAddress" style="width: 300px;" disabled>
</div>

<%} %>
<div id="infobtns" style="display: none;">
<input type="submit" value="Save" id="save" name="save">
<span class="btn" onClick="history.go(0)">Cancel</span>
</div>
</form>
<div id="deletebtn" style="display: none;">
<button onClick="if(checkPW()) { confirmDelete(); }" style="background: red; border: none;">Delete Account</button>

<script>
function confirmDelete() {
  var input = prompt("계정을 삭제하시려면 'Delete' 를 입력하십시오.");
  if (input !== 'Delete') {
	alert("계정 삭제가 취소되었습니다.");
    return false;
  }
	setTimeout(function() { window.location.href="./account/user_delete.jsp";}, 100);
}
</script>
</div>
<div id="modifybtn">
<button onClick="modifyInfo()">Modify</button>
			</div>
		</div>
	</div>
</div>
<script>
function modifyInfo() {
	var names = [ "PW", "num1", "num2", "num3", "SMSYN", "email1", "email2",
				"emailYN", "zipcode", "jibunAddress", "roadAddress",
				"namujiAddress" ];
		for (var i = 0; i < names.length; i++) {
			var elements = document.getElementsByName(names[i])[0];
			if (elements) {
				elements.removeAttribute("disabled");
			}
		}
		document.Registerform["PW"].value = "";
		document.getElementById("modifybtn").style.display = "none";
		document.getElementById("infobtns").style.display = "";
		document.getElementById("adrsSearchBtn").style.display = "";
		document.getElementById("deletebtn").style.display = "";
	}
	
function checkPW() {
	if(document.Registerform["PW"].value == ""){
		alert("비밀번호를 입력하십시오.");
		setTimeout(function() { (document.Registerform.PW).focus(); }, 100);
		return false;
	} else if (!('<%=PW%>' === document.Registerform["PW"].value)){
		alert("올바른 비밀번호를 입력하십시오.");
		return false;
	} else if ('<%=PW%>' === document.Registerform["PW"].value){
		return true;
	} else {
		alert("오류가 발생했습니다.");
		return false;
	}
}

</script>
<script src="./script/register.js"></script>
</body>


</html>