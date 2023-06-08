<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member List from DB</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style>
.infobtn{
cursor: pointer;
width: 16px;
height: 16px;
}
</style>

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
	<form name="SearchQueryForm" method="post" style="display: inline;" accept-charset="UTF-8" action="./user_db.jsp">
		<label style="width: 80px;">검색 조건: </label>
		<select class="normal" id="sqlSelect" name="sqlSelect" onChange=queryValInput()>
			<option value="MEMBER_ID">ID</option>
			<option value="MEMBER_GENDER">성별</option>
			<option value="SMSSTS_YN">SMS 수신여부</option>
			<option value="EMAILSTS_YN">이메일 수신여부</option>
			<option value="DEL_YN">탈퇴 여부</option>
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
		<th>탈퇴 여부</th>
		<th>수정/제거</th>
	</tr>	
	
<%@ include file = "./admin/conn.jsp"%>

		<%
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

		String sql = "SELECT MEMBER_ID, MEMBER_NAME, MEMBER_GENDER, TEL1, TEL2, TEL3, SMSSTS_YN, EMAIL1, EMAIL2, EMAILSTS_YN, ZIPCODE, ROADADDRESS, NAMUJIADDRESS, MEMBER_BIRTH_Y, MEMBER_BIRTH_M, MEMBER_BIRTH_D, JOINDATE, DEL_YN FROM `t_shopping_member` "
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
			String delYN = rs.getString("DEL_YN");
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
			<td><%=delYN%></td>			
			<td><img class="infobtn modbtn" src="./repo/modify-icon.svg" onclick="adminmodify(this)">
			<img class="infobtn delbtn" src="./repo/red-x-line-icon.svg" onclick="admindel(this);"></td>
		</tr>
<%
	}
%>

</table>

<form name="adminDelForm" action="./admin/user_admindel.jsp" method="post"><input type="hidden" name="delID"></input></form>
<form name="adminUpdateForm" action="./userinfo_admin.jsp" method="post"><input type="hidden" name="updateID"></input></form>

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
	} else if (selectVal === "DEL_YN"){
		hide("sqlInput");
		hide("sqlGender");
		show("sqlYN");
	} else {
		show("sqlInput");
		hide("sqlGender");
		hide("sqlYN");
	}
}

function admindel(thisobj) {
	  var obj = thisobj;
	  var delID = obj.parentElement.parentElement.children[1].textContent;

	  if (obj.parentElement.parentElement.children[11].textContent == "Y") {
	    alert("이미 삭제된 계정입니다.");
	  } else {
	    var input = prompt("계정을 삭제하시려면 삭제할 계정의 ID를 입력하십시오."+" (" + delID + ")");
	    if (input === null || input !== delID) {
	      alert("계정 삭제가 취소되었습니다.");
	    } else {
	    	document.adminDelForm.delID.value = delID;
	    	document.adminDelForm.submit();
	    }
	  }
	}
	
function adminmodify(thisobj){
	 var obj = thisobj;
	 var updateID = obj.parentElement.parentElement.children[1].textContent;

	  if (obj.parentElement.parentElement.children[11].textContent == "Y") {
		    alert("삭제한 계정 정보는 수정할 수 없습니다.");
		  } else {
			  
			    var input = prompt("확인을 위해 정보를 수정할 계정의 ID를 입력하십시오."+" (" + updateID + ")");
			    if (input === null || input !== updateID) {
			      alert("사용자 정보 수정이 취소되었습니다.");
			    } else {
		    	document.adminUpdateForm.updateID.value = updateID;
		    	document.adminUpdateForm.submit();	
			    }
		    	}
}
</script>

</body>
</html>