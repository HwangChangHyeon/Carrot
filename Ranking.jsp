<!-- 게임 랭킹 정보 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<%@ page import="RiotAPI.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LoL 랭킹 순위 </title>

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
  <link rel="stylesheet" href="css/Ranking.css">
</head>
<%  
	// 랭킹 정보를 가져올 리스트 만들기
	List<HashMap<String, String>> challengerEntries = new ArrayList<HashMap<String, String>>();

	// 랭킹 정보를 가져올 객체 만들기
	League rank = new League();
	
	// 챌린저 등급을 라이엇 회사에 API로 요청하여 받아오기
	rank.request_Challenger();
	
	// 받아온 API 데이터를 파싱하여 리스트에 담기
	challengerEntries = rank.get_ChallengerEntries();

%>
<body>
  <!-- 헤더 -->
  <jsp:include page="Template/M_header.jsp" flush="true"/>
<section>
  <div class="notuse">
  </div>
  <div class="main">
      <div class="allchamp">
      	<div class="allchamphead">
      		소환사 랭킹
      	</div>
      	<!-- 랭킹 출력 -->
        <ul class="list-group">    
    	<% 
    		// 1위부터 30위까지 출력
			for(int i = 0; i<30;i++){
				out.println("<li class='list-group-item'>");
				out.println("<div class='all'>");
				out.println("<div class='num'>");
				out.println(i+1);
				out.println("</div>");
				out.print("<div class='rankn'>");
				out.print("<div class='rankname'><a href='SearchResult.jsp?gsearch=");
				// 아이디 출력
				out.print(challengerEntries.get(i).get("summonerName"));
				out.println("'>");
				out.println(challengerEntries.get(i).get("summonerName"));
				out.println("</a></div>");
				out.println("<div class='rank'>");
				out.println("<img src='img/tier/CHALLENGER.png'>");
				out.println("Challenger ");
				// 리그 순위 출력
				out.println(challengerEntries.get(i).get("rank"));
				// 리그 포인트 출력
				out.println(challengerEntries.get(i).get("leaguePoints"));
				out.println("</div>");
				out.println("</div>");
				out.println("<div class='win'>");
				out.println("<div class='wins'>");
				
				// 리그 승리 수 출력
				out.println(challengerEntries.get(i).get("wins"));
				out.println("승</div>");
				out.println("<div class='losses'>");
				
				// 리그 패배 수 출력
				out.println(challengerEntries.get(i).get("losses"));
				out.println("패</div>");
				out.println("</div>");
				out.println("</div>");
				out.println("</li>");		
			}	
		%>
		</ul>
      </div>
   </div>
  <div class="notuse">
  </div>
</section>
<article>
</article>
  <!-- 푸터 -->
  <jsp:include page="Template/M_footer.jsp" flush="true"/>
</body>
</html>