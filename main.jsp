<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<%@include file="./header.jsp"%>

<body>

	<div class="contents">
		<div class="grid" style="grid-template-columns: 200px 1fr;">

			<div class="container sidebar">
				<%@include file="./sidebar.jsp"%>
			</div>
			
			<div class="container">
				<h1>메인페이지</h1>
				
				<div class="item">
				<div>
  <canvas id="myChart"></canvas>
</div>

<%@ include file = "./admin/conn.jsp"%>

		<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT DATE(JOINDATE) AS 'DATE', COUNT(*) AS 'COUNT' FROM t_shopping_member GROUP BY DATE(JOINDATE) ORDER BY DATE(JOINDATE);";

		pstmt = conn.prepareStatement(sql);

		// 실행
		rs = pstmt.executeQuery();
		
		String g_labels = "'";
		String g_data = "";

		// 결과
		while (rs.next()) {
			String DATE = rs.getString("DATE");
			String COUNT = rs.getString("COUNT");
			
			g_labels = g_labels + DATE + "','" ;
			g_data = g_data + COUNT + ",";
	}
%>

<script>
  const ctx = document.getElementById('myChart');

  new Chart(ctx, {
    type: 'line',
    data: {    	
      labels: [<%=g_labels.substring(0, g_labels.length() - 2)%>],
      datasets: [{
        label: '일별 가입자 수',
        data: [<%=g_data.substring(0, g_data.length() - 1)%>],
        borderWidth: 1,
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
</script>
				</div>
			</div>
		</div>
	</div>

</body>
</html>