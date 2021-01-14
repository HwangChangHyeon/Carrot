<!-- 로그인 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%> 
<%@ page import="DAODTO.KakaoMemberDAO" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <title>Carrot 로그인</title>
    
   <!-- 부트스트랩 CSS -->
    <link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/sign-in/">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">
    
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
  
  <%!
  	 // 카카오 관련 객체 생성, 키, 리다이렉트 주소 받아오기
  	 KakaoMemberDAO kakao = new KakaoMemberDAO(); 
  	 String key = kakao.getKey();
  	 String url = kakao.getRedirecturl();%>
  
  <%
    // 비밀번호 저장 관련하여 필요한 스크립트 릿
 	 String checkid = (String)session.getAttribute("checkid");
     String checkpw = (String)session.getAttribute("checkpw");
     String check = (String)session.getAttribute("check");
     String idstr=null, pwstr=null, checkstr=null;
    		
  	if(check==null){
  		idstr=""; pwstr=""; checkstr="";
  	} else{
  		idstr=checkid; pwstr=checkpw; checkstr="checked";
  	}
  
  %>
  <body class="text-center">
    <form class="form-signin" method="post" action="Controller_Member.jsp">
    	<input type=hidden name="action" value="signin">
      	<div class="Carrot"><a href="Index.jsp"><i class="fas fa-carrot"></i></a></div>
  		<h1 class="h3 mb-3 font-weight-normal">Carrot</h1>
  		<label for="inputEmail" class="sr-only">email</label>
  		<input type="text" id="inputEmail" name="id" value="<%=idstr%>"class="form-control" placeholder="아이디" required autofocus>
  		<label for="inputPassword" class="sr-only">password</label>
  		<input type="password" id="inputPassword" name="pw" value="<%=pwstr%>" class="form-control" placeholder="패스워드" required>
  		<div class="checkbox mb-3">
    		<label>
      			<input type="checkbox" name="check" value="checked" <%=checkstr%> > 비밀번호 저장
    		</label>
  		</div>
  		<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
  		<button class="btn btn-lg btn-primary btn-block" onclick="location.href='SignUp.jsp'">회원가입</button>
  		<button id="kakaologin" class="btn btn-lg btn-primary btn-block" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=<%=key%>&redirect_uri=<%=url%>?a=login'">카카오톡으로 로그인</button>
  		<button id="kakaosignup" class="btn btn-lg btn-primary btn-block" onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=<%=key%>&redirect_uri=<%=url%>?a=no'">카카오톡으로 회원가입</button>
  		<p class="mt-5 mb-3 text-muted">&copy; 2020</p>
	</form>
</body>
</html>
