<!-- 일반 유저 본인 수정 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>개인 정보 수정</title>


    <!-- 부트스트랩 CSS -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" >
    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/checkout/">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" >
    <link rel="stylesheet" href="../assets/dist/css/bootstrap.min.css">
    
    <!-- 부트스트랩 JS, JQUERY -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" ></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
  
  
  <!-- 회원 정보 수정창에 회원의 정보를 뜨게 하기위해서 회원의 정보가 담긴 해쉬맵 mbr의 값을 getAttribute로 불러온 후 아래서 get으로 가져온다   -->
  <% 
	  HashMap<String, String> mbr = new HashMap<String, String>();
  	  mbr=(HashMap<String, String>)session.getAttribute("mbr");
  %>
  <body class="bg-light">
    <div class="container">
  <div class="py-5 text-center">
    <div class="Carrot"><a href="Index.jsp"><i class="fas fa-carrot"></i></a></div>
    <h3>본인 수정</h3>
  </div>
  <div class="row">
    <div class="col-md-8 order-md-1">
      <form class="needs-validation" novalidate method="post" action="Controller_Member.jsp">
        <div class="mb-3">
        <input type=hidden name="action" value="mbrupdate">
        <label for="lastName">이름</label>
          
        <input type="text" class="form-control" name="eemember_name" id="name" placeholder="이름을 적으세요" value="<%=mbr.get("member_name")%>" required>
        <div class="invalid-feedback">
          	  이름을 적으셔야 합니다.
        </div>
        <input type=hidden name="eemember_id" value="<%= mbr.get("member_id") %>">
        </div>
        <label for="pwd" class="mr-sm-2">패스워드</label>
        <input type="password" name="eemember_pw" class="form-control mb-2 mr-sm-2" placeholder="패스워드를 입력하세요" id="pwd" required>
        <div class="invalid-feedback" style="width: 100%;">
        	  패스워드를 적으셔야 합니다.
        </div>
        <label for="pwd2" class="mr-sm-2">패스워드 확인</label>
        <input type="password" name="eemember_pw2" class="form-control mb-2 mr-sm-2" placeholder="패스워드를 다시 한 번 입력하세요" id="pwd2" required> 
        <div class="invalid-feedback" style="width: 100%;">
     	     패스워드를 적으셔야 합니다.
        </div>
        <div class="mb-3">
          <label for="email">이메일</label>
          <input type="email" name="eemember_email" class="form-control" id="email" placeholder="you@example.com" value="<%=mbr.get("member_email")%>" required>
          <div class="invalid-feedback">
        	    이메일을 적으셔야 합니다.
          </div>
        </div>
        <div class="mb-3">
          <label for="tel">연락처</label>
          <input type="tel" name="eemember_phone" class="form-control" id="tel" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="010-0000-0000 형식으로 적으세요"  value="<%=mbr.get("member_phone")%>" required>
          <div class="invalid-feedback">
            	연락처를 적으셔야합니다.
          </div>
        </div>
        <div class="row">
          <div class="col-md-12 mb-3">
            <label for="country">국가</label>
            <select class="custom-select d-block w-100" name="eemember_country" id="country" required>
              <option value="<%=mbr.get("member_")%>">Choose...</option>
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
        <button class="btn btn-primary btn-lg btn-block" type="submit">수정 신청</button>
      </form>
       <button style='margin-top:10px' class="btn btn-primary btn-lg btn-block" type="submit" onclick="location.href='Controller_Member.jsp?action=delete'">회원 탈퇴 신청</button>
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
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script>window.jQuery || document.write('<script src="../assets/js/vendor/jquery.slim.min.js"><\/script>')</script><script src="../assets/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/form-validation.js"></script></body>
</html>
