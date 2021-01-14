<!-- 커뮤니티 글 작성하는 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp"%>
<%@ page import="RiotAPI.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>커뮤니티</title>

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
  <link rel="stylesheet" href="../css/write.css">
</head>
<body>
  <!-- 헤더 -->
  <jsp:include page="../Template/C_header.jsp" flush="true"/>
<section>
  <div class="main">
  	<div class="content">
  		<div class="topbackground">
  			<div class="notuse"></div>
  			<div class="top-name"><img src="../img/lo.png"></div>
  			<div class="aa">
  			<div class="Searcha">
   				<form name=searchform class="search2" method=get action=../SearchResult.jsp style="opacity: 1.0;" >
      			<input class="submit1" placeholder="아이디를 입력하세요" type="search" id="gsearch" name="gsearch">
      			<button type="submit"><i class="fas fa-search" ></i></button>
    			</form>
  			</div>
  			</div>
  			<div class="notuse"></div>
  		</div>
  		<div class="community">	
  			<div class="cnotuse"></div>
  			<div class="user_category">
  				<div class="uc">
  					<div class="userlogin">
  					 <% 
        				String login;
        				String kakaologin;
        
				    	if((String)session.getAttribute("kakaologin")==null)	{
      						kakaologin="off";
      					} else {
      						kakaologin = (String)session.getAttribute("kakaologin");
      					}
    	
      					if((String)session.getAttribute("memberlogin")==null)	{
      						login="off";
      					} else {
      						login = (String)session.getAttribute("memberlogin");
      					}
    					
      					String id = (String)session.getAttribute("memberid");
    					if(login.equals("on")){
    						if(kakaologin.equals("on")){
    					%>	
     	     	<div class="userlogin2"><a href="../Edit_KakaoMember.jsp"><%=id%>님</a> 환영합니다 </div>
     			<div class="userlogin3"><button class='logoutbtn' onclick="location.href='../Controller_Member.jsp?action=logout'">로그아웃 하기</button></div>    
      		<%}else {%>
    	  
     			<div class="userlogin2"><a href="../Edit_MemberCheck.jsp"><%=id%>님</a> 환영합니다 </div>
     			<div class="userlogin3"><button class='logoutbtn' onclick="location.href='../Controller_Member.jsp?action=logout'">로그아웃 하기</button></div>
     		 			<% } %>
     					<% } else { %>
						<script>alert("로그인 하셔야합니다."); location.href="../SignIn.jsp";</script>
						<%} %>
  					</div>
  					<hr>  				
  					<div class="category">
  						<ul>
  							<li class="b">홈</li>
  								<ul class="text">
  									<li><a href="Community.jsp">전체</a></li>
  								</ul>
  							<hr>
  							<li class="b">구분</li>
  								<ul class="text">
  									<li><a href="Community.jsp">전체</a></li>
  									<li><a href="CommunityPop.jsp">TOP 10</a></li>
  									<li><a href="Community.jsp">최신</a></li>
  								</ul>
  							<hr>
  						</ul>
  					</div>
  				</div>
  			</div>
  			<div class="write">
  				<div class="writeheader">
  					<div class="writer1">
  						<h4>글 작성</h4>
  					</div>
  				</div>
  				<div class="story">
  					<form method="post" action="CommunityControl.jsp" enctype="multipart/form-data">
  					<input type="hidden" name="action" value="write">
  					<div class="form-group">
    						<label for="inputAddress2">제목</label>
  						</div>
  						 <div class="form-group">
   							 <input type="text" class="form-control" id="inputAddress2" name="bbsTitle" placeholder="제목을 입력하세요">
  						</div>
  						 <div class="form-group">
    						<label for="exampleFormControlTextarea1">내용</label>
 						</div>
  						<div class="form-group">
    						<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="bbsContent" placeholder="내용을 입력하세요"></textarea>
 						</div>
 						 <div class="form-group">
    						<input type="file" name="uploadFile">
 						</div>
 						<div class="form-group" id="aaa">
    						<input type="submit" value="제출">
 						</div>
  					</form>
  				</div>
  			</div>
  			<div class="cnotuse"></div>
  		</div>
  	</div>
   </div>
</section>
  <!-- 푸터 -->
  <jsp:include page="../Template/C_footer.jsp" flush="true"/>
</body>
</html>