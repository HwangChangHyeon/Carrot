<!-- 회원가입완료 안내 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<%@ page import="java.sql.*,DAODTO.KakaoMemberDAO"%>
<%
	request.setCharacterEncoding("utf-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>회원가입 완료</title>

<!-- 부트스트랩  CSS -->
<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/sign-in/">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

<!-- 부트스트랩 JS, JQUERY -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>

<!-- 커스텀 CSS-->
<link href="css/signupcom.css" rel="stylesheet">

</head>
  <%!
  	 // 카카오톡 관련된 객체 생성 및 키, 리다이렉트 주소 불러오기
  	 KakaoMemberDAO kakao = new KakaoMemberDAO(); 
  	 String key = kakao.getKey();
  	 String url = kakao.getRedirecturl();
   %>

<body class="text-center">
	<div class="align">
	  	<div class="py-5 text-center">
    		<div class="Carrot"><a href="Index.jsp"><i class="fas fa-carrot"></i></a></div>
  		</div>
  		<!-- 회원 가입 안내 -->
		<h2>회원가입을 축하드립니다.</h2>
		<div class="align2">
			<button class="btn btn-lg btn-primary btn-block" type="submit" onclick="location.href='SignIn.jsp'">로그인</button>
		</div>
		<div class="align2">
			<button id="kakaologin" class="btn btn-lg btn-primary btn-block" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=<%=key%>&redirect_uri=<%=url%>?a=login'">카카오톡으로 로그인</button>
		</div>
		<p class="mt-5 mb-3 text-muted">&copy; 2020</p>
	</div>
</body>
</html>