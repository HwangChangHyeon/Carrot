<!-- 헤더 템플릿 -->

 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
 <header>
    <!-- 헤더(Navbar) 로고, 이름 -->
    <div class="header__logo">
      <a href="AdminIndex.jsp"><i class="fas fa-carrot"></i>Carrot</a>
    </div>

    <!-- 헤더(Navbar) 메뉴 -->
    <ul class="header__menu">
      <li><a href="AdminController.jsp?action=usernum"><i style="margin-right:10px;" class="fas fa-home"></i>Home</a></li>
      <li><a href="AdminController.jsp?action=list"><i style="margin-right:10px;" class="fas fa-users"></i>Users Info</a></li>
      <li><a href="AdminUseradd.jsp"><i style="margin-right:10px;" class="fas fa-user-plus"></i>User Add</a></li>
      <li><a href="AdminUseredit.jsp"><i style="margin-right:10px;" class="fas fa-user-edit"></i> User Edit</a></li>
      <li><a href="../index.jsp"><i style="margin-right:10px;" class="fas fa-sign-in-alt"></i> 일반 유저 홈페이지로 가기 </a></li>
    </ul>

    <!-- 헤더(Navbar) 회원가입, 로그인 -->
    <ul class="header__signin">
      <!-- adminid 선언 -->
  	  <%! String adminid; %>
  	  
      <%
      	String adminlogin;
      
        // 세션에 저장되어있는 adminlogin이 null이면 로그인 off 상태이고
    	if((String)session.getAttribute("adminlogin")==null)	{
    		adminlogin="off";
    	// 저장된 값이 있으면 로그인 on 상태이니 login 상태와 login id를 불러온다
    	} else {
    		adminlogin = (String)session.getAttribute("adminlogin");
    		adminid = (String)session.getAttribute("adminid");
    	}
    	// 로그인이 on 되어있으면
      	if(adminlogin.equals("on")){
      %>
      	<!-- 관리자 ID를 띄운다 -->
		<li><span style="color:white;">관리자 <%= adminid %>님 </span><button class='logoutbtn' onclick="location.href='AdminController.jsp?action=adminlogout'">로그아웃 하기</button></li>
    </ul>
    <!-- 헤더 토글버튼 반응형으로 모바일상태에서만 뜨게 함 -->
    <a href="#" class="header__toogleBtn"><i class="fas fa-bars"></i></a>
  </header>
  <!-- 만약 로그인 상태가 on이 아니면 로그인 창으로 되돌아가게하기 -->
  <% } else {%>
 		 <script>alert("잘못된 경로로 접근하셨습니다.");location.href = "AdminLogin.jsp";</script>
  <% } %>