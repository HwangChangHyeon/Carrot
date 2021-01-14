<!-- 아티클 템플릿 -->

  	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
  	<link href="../css/adminarticle.css" rel="stylesheet">
  	<article>
  		<ul>
  			<li><a href="AdminController.jsp?action=usernum"><i class="fas fa-home"></i> Home </a></li>
  			<li><a href="AdminController.jsp?action=list"><i class="fas fa-users"></i> Users Info </a></li>
  			<li><a href="AdminUseradd.jsp"><i class="fas fa-user-plus"></i> User Add </a></li>
  			<li><a href="AdminUseredit.jsp"><i class="fas fa-user-edit"></i> User Edit </a></li>
  			<li><a href="AdminCommunity.jsp"><i class="fas fa-user-edit"></i> Community </a></li>
  			<li><a href="../Index.jsp" target="_blank"><i class="fas fa-sign-in-alt"></i> 일반 유저 홈페이지로 가기 </a></li>
  		</ul>
  	</article>