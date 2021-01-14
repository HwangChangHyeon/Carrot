<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp"%>
<%@ page import="RiotAPI.*" %>
<%@ page import="DAODTO.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
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
  <link rel="stylesheet" href="../css/Community.css">
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
        // 카카오 로그인 확인
    	if((String)session.getAttribute("kakaologin")==null)	{
      		kakaologin="off";
      	} else {
      		kakaologin = (String)session.getAttribute("kakaologin");
      	}
    	// 일반 멤버 로그인 확인
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
     		 <%} %>
     	<% } else { %>
     					<div style="display:flex;justify-content:center;align-item:center;">
						<button type="submit" onclick="location.href='../SignIn.jsp'">로그인</button>
						</div>
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
  						<h4>TOP10</h4>
  						<% if(login.equals("on")){%>
  						<div><a href="CommunityWrite.jsp"><i class="fas fa-pencil-alt"></i></a></div>
  						<% } %>
  					</div>
  					<hr>
  					<div class="ul-1">
  						<div class="ul"><a href="Community.jsp">전체</a></div>
  						<div class="ul"><a href="CommunityPop.jsp">TOP 10</a></div>
  						<div class="ul"><a href="Community.jsp">최신</a></div>
  						<div class="se">
  							<div class="Searchc">
				   				<form name=searchform class="search3" method=get action="CommunityControl.jsp" style="opacity: 1.0;" >
				   					<input type="hidden" name="action" value="searchbbs"> 
				      				<input class="submit1" placeholder="찾고자하는 글의 제목을 검색하세요" type="search" id="gsearch" name="sbbs">
				      				<button type="submit"><i class="fas fa-search" ></i></button>
				    			</form>
		  					</div>
		  				</div>
  					</div>
  				</div>
  				<div class="story">
  					<%
						BbsDAO bbsDAO = new BbsDAO();
									ArrayList<BbsDTO> list = bbsDAO.getListpop(1);
									for(int i = 0; i< list.size(); i++){
					%>
  					<div class="content1">	
  						<div class="up">
  							<div>
  								<%=list.get(i).getBbsID() %>
  							</div>
  						</div>
  						<div class="contenttext">
  							<a href="CommunityView.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %>
  							<%
  							if(bbsDAO.count(list.get(i).getBbsID())==0){
  								
  							}else {%>
  							<span style="color:blue;"> [<%=bbsDAO.count(list.get(i).getBbsID())%>]</span>
  							
  							<%} %>
  							</a>
  						</div>
  						<div class="nickname">
  							<%=list.get(i).getUserID() %>
  						</div>
  						  						<div class="pop">
  							<i class="far fa-thumbs-up"></i><span><%=list.get(i).getBbsPopularity()%></span>
  						</div>
  						<div class="contentimg">
  						<% if(list.get(i).getBbsimg()==null){
		        				  out.println("<img src='../img/Communityimg/noimg.gif'>");
		    			    }
		
						else { %>
		       	 	<img src="../img/Communityimg/<%=list.get(i).getBbsimg()%>">
		        <% } %>
  							
  						</div>

  					</div>
  					<hr>
  					<%} %>
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