<!-- 메인 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp" %>
<%@ page import="RiotAPI.*" %>
<%@ page import="CovidApi.*" %>
<%@ page import="Socket.*" %>
<%@ page import="DAODTO.*" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Carrot - LoL 전적 검색 </title>

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
  <link rel="stylesheet" href="css/main.css">
  <script src="js/main.js" defer></script>
  
</head>
<body>
  <!-- 헤더 -->
  <header>
    <!-- 헤더(Navbar) 로고, 이름 -->
    <div class="header__logo">
      <i class="fas fa-carrot"></i>
      <a href="">Carrot</a>
    </div>

    <!-- 헤더(Navbar) 메뉴 -->
    <ul class="header__menu">
      <li><a href="Index.jsp">홈</a></li>
      <li><a href="Ranking.jsp">랭킹</a></li>
      <li><a href="Community/Community.jsp">커뮤니티</a></li>
      <li><a href="Community/CommunitySocket.jsp">실시간 채팅방</a></li>
      <li><a href="ChampInfo.jsp">챔피언 정보</a></li>
    </ul>

    <!-- 헤더(Navbar) 회원가입, 로그인 -->
    <ul class="header__signin">
    
     <!-- 로그인이 Off 일 경우 로그인, 회원가입 아이콘을 띄우고 로그인 상태일 경우 로그인 한 ID와 로그아웃하기 버튼을 띄우기-->
     <% 
        String login;
        String kakaologin;
		
        // 카카오톡 로그인이 안되있는 경우 off로 하고
    	if((String)session.getAttribute("kakaologin")==null)	{
      		kakaologin="off";
      	
      	// 카카오톡 로그인이 되어있는 경우 로그인 상태 담기 
      	} else {
      		kakaologin = (String)session.getAttribute("kakaologin");
      	}
    	
        // 일반 로그인이 안되있는 경우 off로 하고
      	if((String)session.getAttribute("memberlogin")==null)	{
      		login="off";
      	// 일반 로그인이 되어있는 경우 로그인 상태 담기
      	} else {
      		login = (String)session.getAttribute("memberlogin");
      	}
        
        // 로그인되어있는 ID값을 id변수에 대입
    	String id = (String)session.getAttribute("memberid");
        
        // 로그인 상태인 경우
    	if(login.equals("on")){
    		// 로그인 상태인데 카카오톡 로그인 인경우
    		if(kakaologin.equals("on")){
    %>
    			<!-- 카카오톡 전용 로그인 상태 띄우기 -->	
     			<li><span style="color:white"><a href="Edit_KakaoMember.jsp"><%=id%>님</a> 환영합니다 </span><button class='logoutbtn' onclick="location.href='Controller_Member.jsp?action=logout'">로그아웃 하기</button></li>
     			        
      		<% } else { %>
    	  		<!-- 일반 유저 로그인 상태 띄우기 -->
     			<li><span style="color:white"><a href="Edit_MemberCheck.jsp"><%=id%>님</a> 환영합니다 </span><button class='logoutbtn' onclick="location.href='Controller_Member.jsp?action=logout'">로그아웃 하기</button></li> 
     		<% } %>
     	<!-- 로그인 상태가 아닌경우 -->	
     	<% } else { %>
     			<!-- 로그인 가능한 상태로 띄우기 -->
      			<li><a href="SignIn.jsp"><i class="fas fa-sign-in-alt"></i></a></li>
      			<li><a href="SignUp.jsp"><i class="fas fa-user-plus"></i></a></li>
      	<% } %>
    </ul>
	
    <!-- 헤더 토글버튼 반응형으로 모바일상태에서만 뜨게 함 -->
    <a href="#" class="header__toogleBtn"><i class="fas fa-bars"></i></a>

  </header>
  <div class="main">
  	<!-- 사용하지 않는 영역 -->
  	<div class="notuse">
  	</div>
  	<!-- 사용 영역  -->
  	<div class="use">
  		<!-- 섹션 -->
  		<section>
    	<!-- 모바일에서만 뜨는 메인 사진 (부트스트랩 이용) -->
    	<div id="demo" class="carousel slide" data-ride="carousel">
      		<!-- Indicators -->
      		<ul class="carousel-indicators">
        		<li data-target="#demo" data-slide-to="0" class="active"></li>
        		<li data-target="#demo" data-slide-to="1"></li>
        		<li data-target="#demo" data-slide-to="2"></li>
      		</ul>
      		<!-- The slideshow -->
      		<div class="carousel-inner">
       			<div class="carousel-item active">
          			<img src="img/lol.jpg" alt="Los Angeles">
        		</div>
        		<div class="carousel-item">
          			<img src="img/lol2.jpg" alt="Chicago">
        		</div>
        		<div class="carousel-item">
          			<img src="img/lol3.jpg" alt="New York">
        		</div>
      		</div> 
      		<!-- Left and right controls -->
      		<a class="carousel-control-prev" href="#demo" data-slide="prev">
        		<span class="carousel-control-prev-icon"></span>
      		</a>
      		<a class="carousel-control-next" href="#demo" data-slide="next">
        		<span class="carousel-control-next-icon"></span>
      		</a>
    	</div>

	<!-- 코로나 API 관련 기능 -->
	<%
			//코로나 API 객체 생성
			Covid19 covid19 = new Covid19();
		    // 코로나 API 값 불러오기
			covid19.requestAPI();
		    // 각 변수에 값 불러와서 집어넣기
			String Coronadecide = covid19.getCoronadecide();
			String Coronaexam = covid19.getCoronaexam();
			String Coronadeath = covid19.getCoronadeath();
			String Coronanewdecide = covid19.getDecidea();
			String Coronanewexam = covid19.getExama();
			String Coronanewdeath = covid19.getDeatha();
		  	
			// 현재 시간을 알기위해 미리 만들어 놓은 시간 객체 생성
	 		CurrentTime date = new CurrentTime(); 
	
	%>
	
   		<!-- 코로나 정보 (모바일 화면에서만 뜨게 끔 함) -->
    	<div class="weatherheader2">코로나 실시간 정보</div>
    	<div class="today2" style="text-align:center; margin-bottom:10px; font-size:10px;"><%=date.getDate2()%> 10:30분 갱신됨</div>
    		<div class="weather2">
      			<div class="weatherbox2">
					<div class="dust2" style="color:red;"><div>코로나 확진자</div><div><b class="de"><%= Coronadecide %> 명</b></div><div><%=Coronanewdecide %><i class="fas fa-sort-up" style="color:red"></i></div></div>
        			<div class="dust2"><div>코로나 사망자</div><div><b><%= Coronadeath %> 명</b></div><div><%=Coronanewdeath %><i class="fas fa-sort-up" style="color:black"></i></div></div>
        			<div class="dust2" style="color:#f2950f;"><div>코로나 검사중</div><div><b class="ex"><%= Coronaexam %> 명</b></div><div><%=Coronanewexam %><i class="fas fa-sort-up" style="color:#f2950f"></i></div></div>
      			</div>
    		</div>
    		<div class="weatherheader2">코로나 <b style="color:red">급증!</b> 집에서 게임하기 <b>좋은 날</b></div>
    		<hr class="w2">
    		<div class="search__logo">
      			<div>
        			<i class="fas fa-carrot"></i>
        			<a href="">Carrot</a>
      			</div>
    		</div>
    
    		<!-- 소환사 정보 검색 -->
    		<div class="searchname">소환사 정보 입력</div>
    		<form name=searchform class="search" method=get action=SearchResult.jsp style="opacity: 1.0;" >
      			<input class="submit1" placeholder="아이디를 입력하세요" type="search" id="gsearch" name="gsearch">
      			<button type="submit"><i class="fas fa-search" ></i></button>
    		</form>
  		</section>
  		<!-- 아티클 -->
  		<article>
   		<%
   			// 이번주 로테이션 챔피언(캐릭터)정보 불러 오는 객체 생성
   	 		Rotation RotationChamp = new Rotation();
   			
   			// 로테이션 정보 불러와서 파싱요청하기 
     		RotationChamp.Request_Rotation();
   			
   			// 파싱된 데이터 champ 배열 객체에 담기
     		ArrayList<String> champ = RotationChamp.get_Rotation();
 		%>
 	

    		<!-- 코로나 정보 (PC상태에서만 보여지는 DIV)-->
    		<div class="weatherheader">코로나 실시간 정보</div>
    		<div class="today1" style="text-align:center; margin-bottom:10px; font-size:11px;"><%=date.getDate2()%> 10:30분 갱신됨</div>
    			<div class="weather">
      				<div class="weatherbox">
  						<div class="dust2" style="color:red;"><div>코로나 확진자</div><div><b class="de"><%= Coronadecide %> 명</b></div><div><%=Coronanewdecide %><i class="fas fa-sort-up" style="color:red"></i></div></div>
        				<div class="dust2"><div>코로나 사망자</div><div><b><%= Coronadeath %> 명</b></div><div><%=Coronanewdeath %><i class="fas fa-sort-up" style="color:black"></i></div></div>
        				<div class="dust2" style="color:#f2950f;"><div>코로나 검사중</div><div><b class="ex"><%= Coronaexam %> 명</b></div><div><%=Coronanewexam %><i class="fas fa-sort-up" style="color:#f2950f"></i></div></div>
      				</div>
    			</div>
    			<div class="weatherheader">코로나 <b style="color:red">급증!</b> 집에서 게임하기 <b>좋은 날</b></div>
    			<hr>
    			<div class="rot__header">금주의 챔피언</div>
    			<!-- 이번주 로테이션 챔피언(캐릭터)정보 이미지로 불러오기 -->
    			<div class="rot">
       				<%
						for(int i = 0; i<champ.size();i++){
							out.println("<div>");
							out.println("<a href='ChampionInfo.jsp?name=");
							out.println(champ.get(i));
							out.println("'><img src=img/champion/"+champ.get(i)+".png></a>");
							out.println("</div>");		
						}	
       				%>
    			</div>
    			<hr>
    			<!-- 커뮤니티 인기글 -->
    			<h4 class="ho">Carrot Community 인기글</h4>
    			<div class="list">
          			<ul id="list-group1" class="list-group">
  		  			<%
  		  				// 게시글 접근 객체 생성
						BbsDAO bbsDAO = new BbsDAO();
  		  			
  		  				// 게시글 Top10 요청하여 list에 담기  
						ArrayList<BbsDTO> list = bbsDAO.getListpop(1);
  		  				
  		  				// 게시글이 10개가 넘지 않을 때 안내 문구 띄우기
						if(list.size() < 10){
							out.println("<h4 style='text-align:center; padding-top:20px; color:#e97341;'>게시물이 충분하지 않습니다. <br> 10개 이상시 인기글이 생성됩니다<h4>");
						
						// 게시글이 10개가 넘으면 우선 차례대로 5개 띄우기
						} else{
							for(int i = 0; i< 5; i++){
					%>

				        <li class="list-group-item"><a href="Community/CommunityView.jsp?bbsID=<%=list.get(i).getBbsID() %>"><span><%=i+1%></span>
				        
				      <!-- 게시글의 이미지가 없을 경우 공백 이미지 띄우기 -->
		        	<% if(list.get(i).getBbsimg()==null){
		        		  out.println("<img src='img/Communityimg/noimg.gif'>");
		        		  
		        	    // 게시글에 이미지가 있을 때는 해당 이미지 띄우기
		        		} else { %>
		        		<img src="img/Communityimg/<%=list.get(i).getBbsimg()%>">
		        	<% } %>
		        	<%= list.get(i).getBbsTitle() %>
        			<%
        				// 게시글 댓글이 0개 일 경우 아무것도 하지않고
  						if(bbsDAO.count(list.get(i).getBbsID())==0){
  							
  						// 게시글 댓글이 있을 경우 출력한다
  						} else {%>
  						<span style="color:blue; font-size:13px;"> [<%=bbsDAO.count(list.get(i).getBbsID())%>]</span>
 					<% } %>
        				</a><span style="width:20%;text-align:right; font-size:13px;"><%=list.get(i).getUserID() %><i class="far fa-thumbs-up"></i><%=list.get(i).getBbsPopularity()%></span></li>
					<%} %>
      				</ul>
      				<ul id="list-group2" class="list-group">
      				<!-- 나머지 인기글 5개 출력 -->
      				<%
      					for(int i = 5; i< 10; i++){
    	  			%>
  						<li class="list-group-item"><a href="Community/CommunityView.jsp?bbsID=<%=list.get(i).getBbsID() %>"><span><%=i+1%></span>
 					<% if(list.get(i).getBbsimg()==null){
		        		  out.println("<img src='img/Communityimg/noimg.gif'>");
		        		} else { %>
		        		<img src="img/Communityimg/<%=list.get(i).getBbsimg()%>">
		        	<% } %>
  					<%= list.get(i).getBbsTitle() %>
        			<%
  						if(bbsDAO.count(list.get(i).getBbsID())==0){
  						} else {%>
  						<span style="color:blue; font-size:13px;"> [<%=bbsDAO.count(list.get(i).getBbsID())%>]</span>
 					<% } %>
        				</a><span style="width:20%;text-align:right; font-size:13px;"><%=list.get(i).getUserID() %><i class="far fa-thumbs-up"></i><%=list.get(i).getBbsPopularity()%></span></li>
					<% }} %>
      				</ul>
    			</div>
    			<hr>

    			<!-- 추천 영상 -->
    			<h2 class="h3 text-center my-5 font-weight-bold">추천 영상</h2>
    			<div class="container">
      				<div class="card-group card-group-scroll">
        				<div class="card">
          					<iframe width="100%" height="250" src="https://www.youtube.com/embed/hr_wPgME3O4"></iframe>
          					<div class="card-body">
            					<h5 class="card-title">원딜에게 추천 <div class="text-right">hyunwook</div></h5>
            					<p class="card-text">딜 도대체 무엇? 실화냐? '마나무네' 진 </p>
          					</div>
        				</div>
        				<div class="card">
          					<iframe width="100%" height="250" src="https://www.youtube.com/embed/wCyrTik7JoQ"></iframe>
          					<div class="card-body">
            					<h5 class="card-title">서포터에게 추천 <div class="text-right">changhyeon</div></h5>
            					<p class="card-text">서폿으로 티어 못 올린다는 분들 "이게 부족해서 그래요"</p>
          					</div>
        				</div>
				        <div class="card">
          					<iframe width="100%" height="250" src="https://www.youtube.com/embed/59g-rT68yMI"></iframe>
          					<div class="card-body">
            					<h5 class="card-title">미드에게 추천 <div class="text-right">yeongdeok</div></h5>
            					<p class="card-text">미드에서 핫한 Q선마 사일러스강의 OP챔피언 요네를 압살하는 법</p>
          					</div>
        				</div>
      				</div>
    			</div>
  		</article>
  	</div>
  	<div class="notuse">
  	</div>
  </div>
  <!-- 푸터 -->
  <jsp:include page="Template/M_footer.jsp" flush="true"/>
</body>
</html>