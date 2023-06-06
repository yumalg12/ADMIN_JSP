<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
// 인코딩
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Register</title>
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


function fn_overlapped() {
    var _id = $("#userID").val();
    
    $.ajax({
        type: "post",
        async: false,
        url: "./account/overlapped.jsp",
        dataType: "json",
        data: {userID: _id},
        success: function(data, textStatus) {
            if (data.result == 'false') {
                alert("사용할 수 있는 ID입니다.");
                $('#checkIDdup').prop("disabled", true);
                $('#userID').prop("disabled", true);
                $('#userIDval').val(_id);
            } else {
                alert("사용할 수 없는 ID입니다.");
                falseCSS("userID");
            }
        },
        error: function(data, textStatus) {
            alert("오류가 발생했습니다.");
        },
        complete: function(data, textStatus) {
        }
    });
}

</script>

</head>
<%@include file="./header.jsp" %>

<body>
<div class="contents">
<h1>회원가입</h1>
<form name="Registerform" action=./account/register_ok.jsp method="post" onSubmit="return validateForm();">
<div class="item">
    <label>아이디</label>
    <input type="text" class="normal" id="userID" name="userID" placeholder="user ID" oninput="checkID(this.value)" maxlength="8"> 
    <input type="hidden" id="userIDval" name="userIDval"> 
    <input type="button" class="btn" id="checkIDdup" value="중복확인" onClick="fn_overlapped();" style="display: none;">
    <span class="notice" id="IDNotice" style="display: none;"> ※영문 소문자, 숫자로 이루어진 5~8자</span>
</div>

    <div class="item">
    <label>비밀번호</label>
    <input type="password" class="normal" name="PW" placeholder="password" oninput="checkPWone(); checkPWtwo()" maxlength="20">
    <input type="password" class="normal" name="PWcheck" style="display: none;" placeholder="password check" oninput="checkPWtwo()" maxlength="20">
    <span class="notice" id="PWNotice" style="display: none;"> ※영문 소문자, 숫자, 특수문자로 이루어진 4~20자</span>
    </div>
    
    <div class="item">
    <label>이름</label>
    <input type="text" class="normal" name="userName" placeholder="user name" oninput="checkName()">
    <span class="notice" id="nameNotice" style="display: none;"> ※한글 실명 2~5자</span>
    </div>

<div class="item">
    <label>성별</label>
    <span>여자</span><input type="radio" name="gender" value="female">
    <span> 남자</span><input type="radio" name="gender" value="male">
</div>    
    
    <div class="item">
    <label>생년월일</label>
    <input type="date" class="normal" name="birthDate" onChange="checkBirth();">
    <span class="notice" id="ageNotice" style="display: none;"> ※만 14세 미만은 가입할 수 없습니다.</span>
    <span class="notice" id="ageNotice2" style="display: none;"> ※미래 날짜는 선택할 수 없습니다.</span>
    </div>

<div class="item">
    <label>전화번호</label> 
    <select class="normal" name="num1" onchange="phoneInput()">
		<option value="010">010</option>
		<option value="input">직접 입력</option>
	</select> 
	<input type="text" class="normal" style="display: none; width: 50px;" name="num1" oninput="checkPhoneOne(this.name)" maxlength="3"> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num2" oninput="checkPhone(this.name)" maxlength="4"> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num3" oninput="checkPhone(this.name)" maxlength="4"> 
	<br>
	<label></label>
	<input type="checkbox" id="SMSYN" name="SMSYN"><span>SMS 수신 동의</span>
</div>
	
	<div class="item">
    <label>이메일</label>
	<input type="text" class="normal" name="email1" onChange="checkMail1()")> 
	<span>@</span> 
	<select name="email2" class="normal" style="width: 180px;" onchange="emailInput()">
		<option value="naver.com">naver.com</option>
		<option value="gmail.com">gmail.com</option>
		<option value="input">직접 입력</option>
	</select>
	<input type="text" class="normal" style="display: none; width: 180px;" name="email2" oninput="checkMail2()"> 
	<br>
	<label></label>
    <input type="checkbox" id="emailYN" name="emailYN"><span>이메일 수신 동의</span>
	</div>

<div class="item">
    <label>주소</label>

	<span class="addressdiv" style="margin-left: 0px;">우편번호: </span><input class="normal" type="text" id="zipcode" name="zipcode" onInput= checkZipCode()> 
	<span class="btn" onClick="javascript:execDaumPostcode()">우편번호 검색</span>
	<br>
	<label></label><span class="addressdiv">지번 주소: </span><input class="normal" type="text" id="jibunAddress" name="jibunAddress" style="width: 300px;" onInput= checkAddress(this.name)>
	<br>
	<label></label><span class="addressdiv">도로명 주소: </span><input class="normal" type="text" id="roadAddress" name="roadAddress" style="width: 300px;" onInput= checkAddress(this.name)>
	<br>
	<label></label><span class="addressdiv">나머지 주소: </span><input class="normal" type="text" name="namujiAddress" style="width: 300px;">
</div>    

<div class="item">
    <input type="submit" value="Register">
</div>
</form>

<script src="./script/register.js"></script>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
</div>
</body>
</html>