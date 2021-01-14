<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
<%@ page import="DAODTO.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title> 관리자 페이지 - 회원 정보 </title>

  <!-- 폰트 적용 -->
  <link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">

  <!-- 아이콘 적용-->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

  <!-- 부트스트랩 -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 
  <!--Jquery-->
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
  <!-- 사용자 설정 CSS, JS -->
  <link href="../css/form-validation.css" rel="stylesheet">
  <link rel="stylesheet" href="../css/adminuserinfo.css">
  <script src="../js/main.js" defer></script>
  
</head>

<body>
  <!-- 헤더 -->
  <jsp:include page="AdminHeader.jsp"/>
  <!-- 틀 잡기 위한 메인 -->
  <div class="main">
  	<!-- 데이터베이스에서 AdminAddDTO 객체 형태의 배열로 가져온 모든 유저들의 정보 -->
  	<%
  		ArrayList<AdminAddDTO> addatas = (ArrayList<AdminAddDTO>)session.getAttribute("addatas");
  	%>
  	<!-- 아티클 -->
	<jsp:include page="AdminArticle.jsp"/>
	<!-- 섹션 -->
  	<section>
      <h2>모든 유저 정보</h2>
      <div class="table-responsive">
        <table class="table table-striped table-sm">
          <thead>
            <tr>
              <th>name</th>
              <th>id</th>
              <th>email</th>
              <th>phone</th>
              <th>country</th>
            </tr>
          </thead>
          <tbody>
          <!-- 데이터베이스에서 가져온 AdminAddDTO 객체 형태의 배열인 addatas에서 a변수로 모든 유저 정보 출력-->
            <%
            	// null 값이 아닐때만 출력
            	if(addatas!=null){
					for(AdminAddDTO  a : (ArrayList<AdminAddDTO>) addatas) {
			%>
			  <tr>
				<td><%=a.getAmember_name() %></td>
				<td><%=a.getAmember_id() %></td>
				<td><%=a.getAmember_email() %></td>
				<td><%=a.getAmember_phone() %></td>
				<td><%=a.getAmember_country() %></td>
			  </tr>
			 <%
					}
				}
			 %>
          </tbody>
        </table>
      </div>
  	</section>
  </div>
  <!-- 푸터 -->
  <jsp:include page="../Template/C_footer.jsp" flush="true"/>
</body>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" ></script>
<script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
<script src="../js/form-validation.js"></script></body>
</html>
