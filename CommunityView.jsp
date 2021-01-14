<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="../ErrorPage.jsp"%>
<%@ page import="RiotAPI.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="DAODTO.*" %>
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
  <link rel="stylesheet" href="../css/CommunityView.css">
</head>
<body>
<%
	int bbsID = 0;
	if (request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if(bbsID == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'Community.jsp'");
		script.println("</script>");
	}
	BbsDTO bbs = new BbsDAO().getBbs(bbsID);
%>
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
  						<h4>게시판 글보기</h4>
  					</div>
  				</div>
  				<div class="container">
			<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
					<thead>
						<tr>
							<td style = "width: 20%;">글 번호</td>
							<th colspan="3" style="text-align: center;color:#e97341;"><%=bbs.getBbsID() %></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style = "width: 20%;">글 제목</td>
							<td colspan="2"><%=bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="2"><%=bbs.getUserID() %></td>
						</tr>
						<tr>
							<td>작성일자</td>
							<td colspan="2"><%=bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
						</tr>
						<tr>
							<td>내용</td>
							
							<td colspan="2" style="height: 400px; text-align : left;"><%=bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> 
							<br><div><img style='width:80%; height:80%;' src="../img/Communityimg/<%=bbs.getBbsimg()%>"></div>
							</td>
						</tr>
						<tr>
							<td>추천 수</td>
							<td colspan="1" style="text-align : left;"><%=bbs.getBbsPopularity()%></td>
							<td style="text-align : right; margin-right:20px;"><a onclick="checkon()" href="#"><i class="far fa-thumbs-up"></i></a></td>
						</tr>
					</tbody>
				</table>
				
				 <div class="story">
  					<form method="get" action="CommunityControl.jsp">
  					<input type="hidden" name="action" value="reply">
  					<input type="hidden" name="bbsID" value=<%=bbsID %>>
  					<div class="form-group">
  						 <div class="form-group" id="abc">
    						<label for="exampleFormControlTextarea1">댓글</label>
 						</div>
  						<div class="form-group" id="bbc">
    						<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="bbsContent" placeholder="내용을 입력하세요"></textarea>
 						</div>
 						 <div class="form-group" id="aaa">
    						<input type="submit" value="제출">
 						</div>
 					</div>
  					</form>
  				</div>
  				  					<%
						BbsDAO bbsDAO = new BbsDAO();
									ArrayList<BbsReplyDTO> list = bbsDAO.getReplyList(bbsID);
    								
									for(int i = 0; i< list.size(); i++){
										 
					%>
				<!-- 댓글 --> 
				<div class="content1" id="ddd" style="background-color:white;">	
					<div class="contenttext">
  							<%= list.get(i).getBbsContent() %>
  							
  					</div>
  					<div class="nickname">
  							<%= list.get(i).getUserID() %>
  					</div>
  					<div class="contentimg">
  							<span><%= list.get(i).getBbsDate() %></span>
  							<% String a = list.get(i).getBbsDate(); %>
  					</div>
  					 <div class="pop">
  							<div class=content1>
						<%
							if(id != null && id.equals(list.get(i).getUserID())){
								
						%>
							<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="CommunityControl.jsp?bbsID=<%=bbsID%>&action=deletereply&content=<%=a%>"><i class="far fa-trash-alt"></i></a>
						<%
							}
						%>
						</div>
  					</div>
  				</div>
  				<%} %>
				<div class=content1>
				<a href="Community.jsp" class="btn btn-primary">목록</a>
				<%
					if(id != null && id.equals(bbs.getUserID())){
				%>
					<a href="CommunityUpdate.jsp?bbsID=<%=bbsID%>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="CommunityControl.jsp?bbsID=<%=bbsID%>&action=delete" class="btn btn-primary">삭제</a>
					
				<%
					}
				%>
				</div>

		</div>
	</div>
  			</div>
  			<div class="cnotuse"></div>
  		</div>
  		     <!-- 푸터 -->

  	</div>
   </div>

</section>
  <jsp:include page="../Template/C_footer.jsp" flush="true"/>
  	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>		
	<script>
		function checkon(){
			if("on"=="<%=login%>"){
				location.href="CommunityControl.jsp?bbsID=<%=bbsID%>&action=up";
			}else{
				alert("로그인 후 이용 가능합니다."); return false;
			}
		}
	</script>
</body>
</html>