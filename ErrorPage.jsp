<!-- 에러 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
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
  <link rel="stylesheet" href="../css/errorpage.css">
  <link rel="stylesheet" href="css/errorpage.css">
</head>
<body>
  <!-- 헤더 -->
  <jsp:include page="Template/M_header.jsp" flush="true"/>
  <section>
  	<div class="main">
	  	<div class="content">
  			<div class="topbackground">
  				<div class="notuse"></div>
  				<div class="top-name"><img src="img/lo.png"></div>
  				<div class="aa">
  					<div class="Searcha">
   						<form name=searchform class="search2" method="get" action="SearchResult.jsp" style="opacity: 1.0;" >
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
  					<!-- 예외처리 값이 null이 아닐 때 -->
  					<% 
  						if(exception!=null){
  					%>
  						<div>
  						<!-- 에러 타입들까지 출력 -->
  							<div><div class="ab">ID가 존재하지 않거나 잘못된 요청입니다.</div></div>
  							<div><div class="cd">빠른 시간 내에 문제를 해결하도록 하겠습니다.</div></div>
  							<div>에러타입 : <%=exception.getClass().getName() %></div>
  							<div>에러타입 : <%=exception.getMessage() %></div>
  						</div>
  					<!-- 예외처리 값이 null인 경우 -->
  					<%} else { %>
  						<div>
  							<div><div class="ab">ID가 존재하지 않거나 잘못된 요청입니다.</div></div>
  							<div><div class="cd">빠른 시간 내에 문제를 해결하도록 하겠습니다.</div></div>
  						</div>
  					<% } %>
  				</div>
  			</div>
  			<div class="cnotuse"></div>
  		</div>
  	</div>
  </div>
</section>
  <!-- 푸터 -->
  <jsp:include page="Template/M_footer.jsp" flush="true"/>
</body>
</html>