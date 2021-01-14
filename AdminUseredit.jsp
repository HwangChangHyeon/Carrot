<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title> 관리자 페이지 - 회원 수정 </title>

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
  <link rel="stylesheet" href="../css/adminuseredit.css">
  <link href="../css/form-validation.css" rel="stylesheet">
  <script src="../js/main.js" defer></script>
  
</head>
<body>
  <!-- 헤더 -->
  <jsp:include page="AdminHeader.jsp"/>
  <!-- 틀잡기위한 메인 -->
  <div class="main">
  	<!-- 아티클 -->
	<jsp:include page="AdminArticle.jsp"/>
	<!-- 섹션 -->
  	<section>
  	<!-- 회원 정보 변경할 ID 폼 -->
  	<div class="form">
    	<form class="form-signin" method="post" action="AdminController.jsp">
    		<!-- 컨트롤러에 넘길 파라미터  -->
    		<input type=hidden name="action" value="adminedit">
      		<div class="center1">
	      		<div class="Carrot"><a href="AdminController.jsp?action=usernum"><i class="fas fa-carrot"></i></a></div>
     		</div>
      		<div class="center2">
	 	 		<h1 class="h3 mb-3 font-weight-normal">Carrot</h1>
 	 		</div>
 	 		<div class="center3">
	 	 		<h5>변경하고자 하는 회원의 ID를 입력하세요</h5>
 	 		</div>
 	 		<div class="center4">
	 	 		<label for="inputEmail" class="sr-only">id</label>
 	 			<input type="text" id="inputEmail" name="edit_id" class="form-control" placeholder="아이디" required autofocus>
 	 		</div>
 	 		<div class="center5">
 	 			<button class="btn btn-lg btn-primary btn-block" type="submit">확인</button>
 	 		</div>
		</form>
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