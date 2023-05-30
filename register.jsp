<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/register.css">
</head>
<body>
<h1>회원가입</h1>
<form name="Registerform" action=./regist_ok.jsp method="post" onSubmit="return validateForm();">
    <label>ID</label>
    <input type="text" class="normal" name="userID" placeholder="username" oninput="checkID(this.value)" maxlength="8"> 
    <span id="IDnotice" style="display: none;"> ※영문, 숫자, 특수문자로 이루어진 5~8자</span>
    <br>
    <label>Password</label>
    <input type="password" class="normal" name="PW" placeholder="password" oninput="checkPW()">
    <input type="password" class="normal" name="PWcheck" placeholder="password check" oninput="checkPW()">
    
    <br>
    <label>Gender</label>
    <span>Female</span><input type="radio" name="gender" value="female" onclick="checkSSNlast()">
    <span> Male</span><input type="radio" name="gender" value="male" onclick="checkSSNlast()">
    
    <br>
    <label>Birth Month</label>
    <select name="month" onChange="checkSSNfirst()">
  <option value="01">1월</option>
  <option value="02">2월</option>
  <option value="03">3월</option>
  <option value="04">4월</option>
  <option value="05">5월</option>
  <option value="06">6월</option>
  <option value="07">7월</option>
  <option value="08">8월</option>
  <option value="09">9월</option>
  <option value="10">10월</option>
  <option value="11">11월</option>
  <option value="12">12월</option>
    </select>
    
    <br>
    <label>SSN</label>
    <input type="text" class="normal" name="ssnFirst" placeholder="First part" maxlength="6" oninput="checkSSNfirst()">
    <span>-</span>
    <input type="password" class="normal" name="ssnLast" placeholder="Last part" maxlength="7" oninput="checkSSNlast()">

    <br>
    <input type="submit" value="Register">
</form>

<script src="./script/register.js"></script>

</body>
</html>