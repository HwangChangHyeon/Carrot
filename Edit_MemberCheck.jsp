<!-- 일반 유저 개인 정보 수정하기 위해서 비밀번호 치는 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<!DOCTYPE html> 
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>개인 정보 수정 확인</title>
    
    
    <!-- 부트스트랩 CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">
    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/sign-in/">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <!-- 부트스트랩 JS, JQUERY -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" ></script>

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>
    
    <!-- 커스텀 CSS -->
    <link href="css/signin.css" rel="stylesheet">
  </head>
  <body class="text-center">
    <form class="form-signin" method="post" action="Controller_Member.jsp">
    <input type=hidden name="action" value="edit">
    	<div class="Carrot"><a href="Index.jsp"><i class="fas fa-carrot"></i></a></div>
  		<h1 class="h3 mb-3 font-weight-normal">Carrot</h1>
  		<h6> 회원 정보 수정을 하기 위해서  </h6>
  		<h6> 본인의 비밀번호를 한 번 더 입력하세요</h6>
  		<label for="inputPassword" class="sr-only">password</label>
  		<input type="password" id="inputPassword" name="edpw" class="form-control" placeholder="패스워드" required>
  		<button class="btn btn-lg btn-primary btn-block" type="submit">확인</button>
  		<p class="mt-5 mb-3 text-muted">&copy; 2020</p>
	</form>
</body>
</html>
