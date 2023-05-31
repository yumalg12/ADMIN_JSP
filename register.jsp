<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/register.css">
<script src="http://code.jquery.com/jquery-latest-min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script>
function execDaumPostcode() {
  new daum.Postcode({
    oncomplete: function(data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

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
      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
      document.getElementById('roadAddress').value = fullRoadAddr;
      document.getElementById('jibunAddress').value = data.jibunAddress;

      // 사용자가 '선택 안 함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
      if(data.autoRoadAddress) {
        //예상되는 도로명 주소에 조합형 주소를 추가한다.
        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';

      } else if(data.autoJibunAddress) {
          var expJibunAddr = data.autoJibunAddress;
          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
      } else {
          document.getElementById('guide').innerHTML = '';
      }
    }
  }).open();
}
</script>

</head>
<body>
<h1>회원가입</h1>
<form name="Registerform" action=./register_ok.jsp method="post" onSubmit="return validateForm();">
    <label>아이디</label>
    <input type="text" class="normal" name="userID" placeholder="username" oninput="checkID(this.value)" maxlength="8"> 
    <span class="btn" onClick="isIDexist.jsp">중복확인</span>

    <br>
    <label></label><span id="IDnotice" style="font-size: 0.9rem; font-color: #aaa; display: none;"> ※영문, 숫자, 특수문자로 이루어진 5~8자</span>
    
    <br>
    <label>비밀번호</label>
    <input type="password" class="normal" name="PW" placeholder="password" oninput="checkPW()">
    <input type="password" class="normal" name="PWcheck" placeholder="password check" oninput="checkPW()">
    
    <br>
    <label>이름</label>
    <input type="text" class="normal" name="userName" placeholder="name" oninput="checkName()">
    
    <br>
    <label>성별</label>
    <span>여자</span><input type="radio" name="gender" value="female" onclick="checkSSNlast()">
    <span> 남자</span><input type="radio" name="gender" value="male" onclick="checkSSNlast()">
    
    <br>
    <label>생년월일</label>
    <input type="date" class="normal" name="birthDate">

    <br>
    <label>전화번호</label> 
    <select class="normal" name="num_1" onchange="phoneInput()">
		<option value="010">010</option>
		<option value="input">직접 입력</option>
	</select> 
	<input type="text" class="normal" style="display: none; width: 50px;" name="num_1" oninput="checkNum()"> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num_2" oninput="checkNum()"> 
	<span>-</span> 
	<input type="text" class="normal" style="width: 50px;" name="num_3" oninput="checkNum()"> 
	<br>
	<label></label>
	<input type="checkbox"><span>SMS 수신 동의</span>
	
	<br>
    <label>이메일</label>
	<input type="text" class="normal" name="email_1"> 
	<span>@</span> 
	<select name="email_2" class="normal" style="width: 150px;" onchange="emailInput()">
		<option value="naver.com">naver.com</option>
		<option value="gmail.com">gmail.com</option>
		<option value="input">직접 입력</option>
	</select>
	<input type="text" class="normal" style="display: none; width: 200px;" name="email_2" oninput="checkNum()"> 
	<br>
	<label></label>
    <input type="checkbox"><span>이메일 수신 동의</span>
    
    <br>
    <label>주소</label>

	<span>우편번호: </span><input class="normal" type="text" id="zipcode" name="zipcode"> 
	<a href="javascript:execDaumPostcode()">우편번호 검색</a>
	<br>
	<label></label><span>지번 주소: </span><input class="normal" type="text" id="roadAddress"  name="roadAddress" style="width: 300px;">
	<br>
	<label></label><span>도로명 주소: </span><input class="normal" type="text" id="jibunAddress" name="jibunAddress" style="width: 300px;">
	<br>
	<label></label><span>나머지 주소: </span><input class="normal" type="text" name="namujiAddress" style="width: 300px;">

    <br>
    <input type="submit" value="Register">
</form>

<script src="./script/register.js"></script>

</body>
</html>