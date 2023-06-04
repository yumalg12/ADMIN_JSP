
<style>
#header {
	width: 100%;
	margin: 0px !important;
	height: 50px;
	color: white;
	background: cornflowerblue;
	position: sticky;
	top: 0;
	box-shadow: 0px 3px 10px rgb(0,0,0,0.3);
	filter: opacity(0.8);
}

#header:hover{
	animation: opacity 0.3s forwards;
}

@keyframes opacity{
	0%{filter: opacity(0.8);}
	100%{filter: opacity(1.0);}
	
}
	.headerbtn{
	padding: 5px 10px !important;
    background: white !important;
    color: cornflowerblue !important;
    border: none !important;
    font-size: 0.9rem;
}
</style>
<body style="margin: 0px;">
<div id="header">
		<div class="headerContainer" style="display: grid; grid-template-columns: 1fr 1fr">
		<div class="headerItem" style="
    padding-top: 9px;
    margin-left: 30px;
" onClick="location.href='./main.jsp'">
		<span style="font-size: 16pt; font-weight: bold;">JSP Admin Page</span>
		</div>
		<div class="headerItem" id="headerUserInfo" style="
    text-align: right;
    margin-right: 30px;
    margin-top: -4px;
">
<%
String member_id = (String) session.getAttribute("member_id");
%>
<span style="
    font-weight: bold;
    margin-right: 8px;
">User: <%=member_id %> </span>
<input type="submit" class="headerbtn" value="MyInfo" onClick="location.href='./userinfo.jsp';">
<input type="submit" class="headerbtn" value="Logout" onClick="location.href='./logout.jsp';">
</div>
		</div>
	</div>
	 
	<script>
	if ("<%=member_id %>" == "null"){
		document.getElementById("headerUserInfo").style.display = "none";
	}
	</script>
</body>
