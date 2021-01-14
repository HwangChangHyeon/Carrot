<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>관리자 페이지 로그인</title>

<!-- 부트스트랩 CSS -->
<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/sign-in/">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap" rel="stylesheet">
<link rel="stylesheet"	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

<!-- 부트스트랩 자바스크립트, JQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- 사용자 설정 CSS -->
<link href="../css/signin.css" rel="stylesheet">
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
</head>

<body class="text-center">
	<!-- 로그인 폼 -->
	<form class="form-signin" method="post"	action="AdminController.jsp">
		<input type=hidden name="action" value="adminsignin">
		<div class="Carrot">
			<a href="../index.jsp"><i class="fas fa-carrot"></i></a>
		</div>
		<h1 class="h3 mb-3 font-weight-normal">Carrot 관리자 페이지</h1>
		<h6>관리자 페이지 입니다.</h6>
		<h6>
			일반 유저들은 로그인 시도시 <b style="color: red">법적 처벌</b>을 받을 수 있습니다.
		</h6>
		<label for="inputEmail" class="sr-only">email</label> 
		<input type="text" id="inputEmail" name="adid" class="form-control"	placeholder="아이디" required autofocus> 
		<label for="inputPassword" class="sr-only">password</label> 
		<input type="password" id="inputPassword" name="adpw" class="form-control" placeholder="패스워드" required>
		<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
		<p class="mt-5 mb-3 text-muted">&copy; 2020</p>
	</form>
</body>
</html>
