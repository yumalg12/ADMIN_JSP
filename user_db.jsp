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

<link rel="stylesheet" href="./css/toggle.css">

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
        document.getElementById("sqlDept").value = queryVal;
    } else {
        document.SearchQueryForm.sqlSelect.value = "MEMBER_ID";
        document.getElementById("sqlInput").value = "";
    }
   
    $("#DetailSearchQueryForm").hide();
    $("#DetailSearchQueryForm").attr("disabled", true);

});

function createDIV(){
	obj = document.getElementById("detailSearch");

	newDiv = document.createElement("div");
	let i = 0;

	newDiv.innerHTML = "<br><select class=\"form-select\" style=\"margin-left: 37px; width: 88px; margin-right: 6px;\"><option name=\"or\" value=\"OR\">OR</option><option value=\"AND\">AND</option></select><select class=\"form-select\" id=\"sqlSelect\" name=\"sqlSelect\" onChange=queryValInput()><option value=\"MEMBER_ID\">ID</option><option value=\"MEMBER_GENDER\">성별</option><option value=\"SMSSTS_YN\">SMS 수신여부</option><option value=\"EMAILSTS_YN\">이메일 수신여부</option><option value=\"DEL_YN\">탈퇴 여부</option></select> <input type=\"text\" class=\"form-control\" id=\"sqlInput\" name=\"queryVal\" placeholder=\"value\" style=\"width: 200px;\"> <select class=\"form-select\" id=\"sqlGender\" name=\"queryVal\" style=\"display: none; width: 200px;\" disabled><option value=\"female\">여자</option><option value=\"male\">남자</option></select> <select class=\"form-control\" id=\"sqlYN\" name=\"queryVal\" style=\"display: none; width: 200px;\" disabled><option value=\"Y\">Y</option><option value=\"N\">N</option></select><img class=\"imgbtn\" src=\"./repo/mathematics-sign-minus-round-icon.svg\" style=\"width: 16px; position: relative; top: -1px;\" onclick=\"javascript:deleteDIV(this)\">";
	newDiv.setAttribute("class", ("detailSearchCount")); // 새롭게 만들어지는 div 태그에 id 값 저장
	newDiv.setAttribute("id", ("detailSearchObj" + i)); // 새롭게 만들어지는 div 태그에 id 값 저장

	obj.appendChild(newDiv);
}

function deleteDIV(obj){
	pp = obj.parentElement.parentElement; //detailSearch div
	p = obj.parentElement; //detailSearchObj div
	pp.removeChild(p); // detailSearchObj div 제거
}

</script>

	<div class="contents">
		<div class="grid" style="grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="./sidebar.jsp"%>
			</div>
			<div class="container"><h1>전체회원조회</h1>
<div class="grid" style="grid-template-columns: 1fr 150px;">
<div class="item">
	<form name="SearchQueryForm" id="SearchQueryForm" method="post" accept-charset="UTF-8" action="./user_db.jsp">
	
	<div id="simpleSearch" style="display: inline;">
		<label style="width: 80px;">검색 조건: </label>
		<select class="form-select" id="sqlSelect" name="sqlSelect" onChange=queryValInput()>
			<option value="MEMBER_ID">ID</option>
			<option value="MEMBER_NAME">이름</option>
			<option value="DEPTNO">부서</option>
			<option value="MEMBER_GENDER">성별</option>
			<option value="SMSSTS_YN">SMS 수신여부</option>
			<option value="EMAILSTS_YN">이메일 수신여부</option>
			<option value="DEL_YN">탈퇴 여부</option>
		</select> 
		<input type="text" class="form-control" id="sqlInput" name="queryVal" placeholder="value" style="width: 200px;"> 
		<select class="form-select" id="sqlGender" name="queryVal" style="display: none; width: 200px;" disabled>
			<option value="female">여자</option>
			<option value="male">남자</option>
		</select> 
		<select class="form-select" id="sqlYN" name="queryVal" style="display: none; width: 200px;" disabled>
			<option value="Y">Y</option>
			<option value="N">N</option>
		</select> 
		<select class="form-select" id="sqlDept" name="queryVal" style="display: none; width: 200px;" disabled>
		<%@include file="./admin/conn.jsp" %>
<% 		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM `t_dept` ORDER BY DEPTNO ASC;";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();
		
		// 결과를 출력
		while (rs.next()) {
			Integer deptno = rs.getInt("DEPTNO");
			String dname = rs.getString("DNAME");%>
		<option value="<%=deptno %>"><%=dname %></option>
		<%} %>
	</select>
	</div>
			<input class="btn btn-primary" type="submit" value="Submit">
	</form>
	
	<form name="DetailSearchQueryForm" id="DetailSearchQueryForm" method="post" accept-charset="UTF-8" action="./user_db.jsp">
	<div id="detailSearch" style="display: inline;">
			<label style="width: 80px;">검색 조건</label>
			<img class="imgbtn" src="./repo/addition-color-icon.svg" style="width: 20px; position: relative; top: -2px;" onclick="javascript:createDIV()">
		<div class="detailSearchCount" id="detailSearchObj0" style="margin-left: 20px;">
			<select class="form-select" id="sqlSelect" name="sqlSelect" onChange=queryValInput()>
			<option value="MEMBER_ID">ID</option>
			<option value="MEMBER_GENDER">성별</option>
			<option value="SMSSTS_YN">SMS 수신여부</option>
			<option value="EMAILSTS_YN">이메일 수신여부</option>
			<option value="DEL_YN">탈퇴 여부</option>
		</select> 
		<input type="text" class="form-control" id="sqlInput" name="queryVal" placeholder="value" style="width: 200px;"> 
		<select class="form-select" id="sqlGender" name="queryVal" style="display: none; width: 200px;" disabled>
			<option value="female">여자</option>
			<option value="male">남자</option>
		</select> 
		<select class="form-select" id="sqlYN" name="queryVal" style="display: none; width: 200px;" disabled>
			<option value="Y">Y</option>
			<option value="N">N</option>
		</select> 
				<select class="form-select" id="sqldept" name="dept" style="display: none; width: 200px;" disabled>
<% 		pstmt = null;
		rs = null;

		sql = "SELECT * FROM `t_dept` ORDER BY DEPTNO ASC;";

		pstmt = conn.prepareStatement(sql);

		rs = pstmt.executeQuery();
		
		// 결과를 출력
		while (rs.next()) {
			Integer deptno = rs.getInt("DEPTNO");
			String dname = rs.getString("DNAME");%>
		<option value="<%=deptno %>"><%=dname %></option>
		<%} %>
	</select>
		</div>
	</div>

		<input class="btn btn-primary" type="submit" value="Submit">
    </form>
</div>
<div class="item" style="text-align: right;">
<div class="togglediv" style="position: relative; top: 1rem; right: 3px;">
  <span>상세검색</span>     
  <input class="toggle" id="detailToggle" role="switch" type="checkbox" onclick="detailToggle()">
  </div>
</div>
</div>
<br>
<table>
	<tr>
		<th>Idx</th>
		<th>아이디</th>
		<th>이름</th>
		<th>부서</th>
		<th>성별</th>
		<th>연락처</th>
		<th>SMS 수신</th>
		<th>이메일</th>
		<th>이메일 수신</th>
		<th>주소</th>
		<th>생년월일</th>
		<th>가입일</th>
		<th>탈퇴</th>
		<th>수정/제거</th>
	</tr>	
	
		<%
		pstmt = null;
		rs = null;

		String sqlSearch = "";
		
		sqlSelect = request.getParameter("sqlSelect");
		queryVal = request.getParameter("queryVal");
		if (sqlSelect != null && queryVal != null && queryVal != ""){
			if (sqlSelect.equals("MEMBER_ID") || sqlSelect.equals("MEMBER_NAME")) {
				sqlSearch = "where t_shopping_member." + sqlSelect + " LIKE '%" + queryVal + "%' ";
			} else {
				sqlSearch = "where t_shopping_member." + sqlSelect + " = '" + queryVal + "' ";
				}
		} else {
			sqlSearch = "";
		}

		sql = "SELECT MEMBER_ID, MEMBER_NAME, t_dept.dname, MEMBER_GENDER, TEL1, TEL2, TEL3, SMSSTS_YN, EMAIL1, EMAIL2, EMAILSTS_YN, ZIPCODE, ROADADDRESS, NAMUJIADDRESS, MEMBER_BIRTH_Y, MEMBER_BIRTH_M, MEMBER_BIRTH_D, JOINDATE, DEL_YN "
				+ "from `t_shopping_member` join `t_dept` on `t_shopping_member`.DEPTNO = `t_dept`.DEPTNO "
				+ sqlSearch
				+"order by JOINDATE DESC;";

		System.out.println(sql);

		pstmt = conn.prepareStatement(sql);

		// 4) 실행
		rs = pstmt.executeQuery();

		// 5) 결과를 테이블에 출력
		int i = 1;
		while (rs.next()) {
			Integer idx = i++;
			String userID = rs.getString("MEMBER_ID");
			String userName = rs.getString("MEMBER_NAME");
			String dept = rs.getString("t_dept.dname");
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
			<td><%=dept%></td>
			<td><%=gender%></td>
			<td><%=tel1+"-"+tel2+"-"+tel3%></td>
			<td><%=SMSYN%></td>
			<td><%=email1+"@"+email2%></td>
			<td><%=emailYN%></td>
			<td><%="(우)"+zipcode+" "+roadaddress+" "+namujiaddress%></td>
			<td><%=bYear+"년 "+bMon+"월 "+bDay+"일"%></td>
			<td><%=joinDate%></td>
			<td><%=delYN%></td>			
			<td><img class="imgbtn infobtn modbtn" src="./repo/modify-icon.svg" onclick="adminmodify(this)">
			<img class="imgbtn infobtn delbtn" src="./repo/red-x-line-icon.svg" onclick="admindel(this);"></td>
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

function objshow(id){
	var object = document.getElementById(id);
	object.disabled = false;
	object.style.display = "";
}

function objhide(id){
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
		objhide("sqlInput");
		objshow("sqlGender");
		objhide("sqlYN");
		objhide("sqlDept");
	} else if (selectVal === "SMSSTS_YN"){
		objhide("sqlInput");
		objhide("sqlGender");
		objshow("sqlYN");
		objhide("sqlDept");
	} else if (selectVal === "EMAILSTS_YN"){
		objhide("sqlInput");
		objhide("sqlGender");
		objshow("sqlYN");
		objhide("sqlDept");
	} else if (selectVal === "DEL_YN"){
		objhide("sqlInput");
		objhide("sqlGender");
		objshow("sqlYN");
		objhide("sqlDept");
	} else if (selectVal === "DEPTNO"){
		objhide("sqlInput");
		objhide("sqlGender");
		objhide("sqlYN");
		objshow("sqlDept");
	} else {
		objshow("sqlInput");
		objhide("sqlGender");
		objhide("sqlYN");
		objhide("sqlDept");
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

function detailToggle() {
    if ($("#detailToggle").prop('checked')) {
        $("#DetailSearchQueryForm").show();
        $("#DetailSearchQueryForm").attr("disabled", false);
        $("#SearchQueryForm").hide();
        $("#SearchQueryForm").attr("disabled", true);
	} else {
    	$("#DetailSearchQueryForm").hide();
 	   $("#DetailSearchQueryForm").attr("disabled", true);
 	   $("#SearchQueryForm").show();
 	   $("#SearchQueryForm").attr("disabled", false);
	}
}

</script>

</body>
</html>