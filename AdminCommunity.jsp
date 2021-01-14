<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="../ErrorPage.jsp" %>
<%@ page import="DAODTO.*"%>
<%@ page import="java.util.ArrayList"%>

<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 메인 페이지</title>

<!-- 폰트 적용 -->
<link href="https://fonts.googleapis.com/css2?family=Yeon+Sung&display=swap"	rel="stylesheet">

<!-- 아이콘 적용-->
<link rel="stylesheet" 	href="https://use.fontawesome.com/releases/v5.14.0/css/all.css">

<!-- 부트스트랩 -->
<link rel="stylesheet"	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!--Jquery-->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.2.0.min.js"></script>
<!-- 사용자 설정 CSS, JS -->
<link rel="stylesheet" href="../css/adminindex.css">

</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="AdminHeader.jsp" />
	<div class="main">
		<!-- 아티클 -->
		<jsp:include page="AdminArticle.jsp" />
		<!-- 섹션 -->
		<section>
			<!-- 제목 -->
			<h1>
				<span>게시판 관리 현황</span>
			</h1>
			<!-- 내용 -->
			<div class="wrapper">
				<%
					BbsDAO bbsDAO = new BbsDAO();
					AdminDAO adminDAO = new AdminDAO();
					
					// 게시판 글 ArrayList 형태로 불러와서 list에 담기 
					ArrayList<BbsDTO> list = adminDAO.getList();
					
					// 반복문을 통해 list의 사이즈 만큼 출력하기
					for(int i = 0; i< list.size(); i++){
				%>
				<div class="content1">
					<!-- 게시글 번호 -->
					<div class="up">
						<div>
							<%=list.get(i).getBbsID() %>
						</div>
					</div>
					<!-- 게시글 제목 -->
					<div class="contenttext">
						<!-- 게시글 제목 클릭시 해당하는 게시물로 넘어감 -->
						<a href="../Community/CommunityView.jsp?bbsID=<%=list.get(i).getBbsID() %>"><%=list.get(i).getBbsTitle() %> 
							<%
								// 게시글의 댓글 수가 0일 경우 아무것도 출력하지 않고
  								if(bbsDAO.count(list.get(i).getBbsID())==0){
  								
  								// 게시글의 댓글 수가 0이 아닐 경우 제목 옆에 댓글 개수를 출력
  								} else {%>
  							
  								<span style="color:blue;"> [<%=bbsDAO.count(list.get(i).getBbsID())%>]</span>
  							
  							<% } %>
						</a>
					</div>
					<!-- 게시글 작성한 사람의 이름 -->
					<div class="nickname">
						<%=list.get(i).getUserID() %>
					</div>
					<!-- 게시글에 포함된 이미지 출력 -->
					<div class="contentimg">
						<!-- 게시글에 포함된 이미지가 없을 경우 빈 이미지 출력-->
						<% if(list.get(i).getBbsimg()==null){
		        				  out.println("<img src='../img/Communityimg/noimg.gif'>");
		        		// 게시글에 포함된 이미지가 있을 경우 그 이미지 출력
		    			   } else { %>
		       	 			<img src="../img/Communityimg/<%=list.get(i).getBbsimg()%>">
		        		<% } %>
					</div>
					<!-- 게시글 삭제 할 수 있는 버튼 생성, 버튼 클릭시 컨트롤러로 넘어가서 삭제처리  -->
					<div class="pop">
						<button onclick="location.href='AdminController.jsp?action=contentdelete&bbsid=<%=list.get(i).getBbsID()%>'">삭제</button>
					</div>
				</div>
				<% } %>
			</div>
		</section>
	</div>
	<!-- 푸터 -->
	<jsp:include page="../Template/C_footer.jsp" flush="true" />
	<script src="../js/main.js"></script>
	<script src="../js/adminindex.js"></script>
</body>
</html>