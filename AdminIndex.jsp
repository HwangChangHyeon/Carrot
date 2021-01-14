<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title> 관리자 메인 페이지 </title>

  <!-- 폰트 적용 -->
  <link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">

  <!-- 아이콘 적용-->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

  <!-- 부트스트랩 -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
 
  <!--Jquery-->
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.0.min.js" ></script>
  <!-- 사용자 설정 CSS, JS -->
  <link rel="stylesheet" href="../css/adminindex.css">
  
  
</head>
<body>
  <!-- 헤더 -->
  <jsp:include page="AdminHeader.jsp"/>
  <div class="main">
    <!-- 아티클 -->
	<jsp:include page="AdminArticle.jsp"/>
	<!-- 섹션 -->
	
	<%
		Integer usernum = 0;
		Integer adminnum = 0;
		Integer contentnum = 0;
		
		// 관리 현황에 뜰 일반 유저 개수, 관리자 유저 개수, 게시글 개수 받아오기
	    if(session.getAttribute("usernum") != null){
	    	usernum = (Integer)session.getAttribute("usernum");
	    }
	    if(session.getAttribute("adminnum") != null){
	    	adminnum= (Integer)session.getAttribute("adminnum");
	    }
	    if(session.getAttribute("contentnum") != null){
	    	contentnum = (Integer)session.getAttribute("contentnum");
	    }

	%>
  	<section>
  		<!-- 관리 현황에 해당 개수 출력 -->
  		<h1><span>관리 현황</span></h1>
  		<div class="wrapper">
  			<ul class="graph">
  				<li class="user" id="user" value="<%=usernum%>"><h2>Title</h2><Strong></Strong></li>
  				<li class="admin" id="admin" value="<%=adminnum%>"><h2>Title</h2><Strong></Strong></li>
  				<li class="content" id="content" value="<%=contentnum%>"><h2>Title</h2><Strong></Strong></li>
  			</ul>
  		</div>
  	</section>
  </div>
  <!-- 푸터 -->
  <jsp:include page="../Template/C_footer.jsp" flush="true"/>
  <script src="../js/main.js"></script>
  <script src="../js/adminindex.js"></script>
</body>
</html>