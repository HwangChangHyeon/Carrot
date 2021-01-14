<!-- 회원가입 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>회원가입</title>

	<!--  부트스트랩 JS, JQuery -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
    <!-- 부트스트랩 CSS -->
    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/checkout/">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">
	<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet">

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
    <link href="css/form-validation.css" rel="stylesheet">
    
  </head>
  <body class="bg-light">
    <div class="container">
  <div class="py-5 text-center">
    <div class="Carrot"><a href="Index.jsp"><i class="fas fa-carrot"></i></a></div>
    <h3>회원가입</h3>
  </div>
  <div class="row">
    <div class="col-md-8 order-md-1">
      <form class="needs-validation" novalidate method="post" action="Controller_Member.jsp">
        <div class="mb-3">
        	<input type=hidden name="action" value="insert">
        	<label for="lastName">이름</label>
        	<input type="text" class="form-control" name="member_name" id="name" placeholder="이름을 적으세요"required>
        	<div class="invalid-feedback">
          	  이름을 적으셔야 합니다.
         	</div>
        </div>
        <div class="mb-3">
          <label for="username">아이디</label>
          <div class="input-group">
            <input type="text" class="form-control" name="member_id" id="username" placeholder="아이디를 적으세요" required><button id="button" onclick="match()">중복확인</button>
            <div class="invalid-feedback" style="width: 100%;">
             	 아이디를 적으셔야 합니다.
            </div>
          </div>
        </div>
        <label for="pwd" class="mr-sm-2">패스워드</label>
        <input type="password" name="member_pw" class="form-control mb-2 mr-sm-2" placeholder="패스워드를 입력하세요" id="pwd" required>
        <div class="invalid-feedback" style="width: 100%;">
        	  패스워드를 적으셔야 합니다.
        </div>
        <label for="pwd2" class="mr-sm-2">패스워드 확인</label>
        <input type="password" name="member_pw2" class="form-control mb-2 mr-sm-2" placeholder="패스워드를 다시 한 번 입력하세요" id="pwd2" required> 
        <div class="invalid-feedback" style="width: 100%;">
     	     패스워드를 적으셔야 합니다.
        </div>
        <div class="mb-3">
          <label for="email">이메일</label>
          <input type="email" name="member_email" class="form-control" id="email" placeholder="you@example.com" required>
          <div class="invalid-feedback">
        	    이메일을 적으셔야 합니다.
          </div>
        </div>
        <div class="mb-3">
          <label for="tel">연락처</label>
          <input type="tel" name="member_phone" class="form-control" id="tel" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-0000-0000 형식으로 적으세요" required>
          <div class="invalid-feedback">
            	연락처를 적으셔야합니다.
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 mb-3">
            <label for="country">국가</label>
            <select class="custom-select d-block w-100" name="member_country" id="country" required>
              <option value="">Choose...</option>
              <option>Korea</option>
              <option>United State</option>
              <option>China</option>
              <option>Japanese</option>
            </select>
            <div class="invalid-feedback">
           	   국가를 선택하세요.
            </div>
          </div>
        </div>
        <hr class="mb-4">
        <button class="btn btn-primary btn-lg btn-block" type="submit">회원가입 신청</button>
      </form>
    </div>
  </div>
  <footer class="my-5 pt-5 text-muted text-center text-small">
    <p class="mb-1">&copy; 2020 Carrot</p>
    <ul class="list-inline">
      <li class="list-inline-item"><a href="#">Privacy</a></li>
      <li class="list-inline-item"><a href="#">Terms</a></li>
      <li class="list-inline-item"><a href="#">Support</a></li>
    </ul>
  </footer>
</div>
<!-- 부트스트랩 -->
<script>
	// ID 중복체크
	function match(){
		var id = document.getElementById("username").value;
		location.href="Controller_Member.jsp?action=Match&matchid="+id;
	}
</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/form-validation.js"></script></body>
</html>
