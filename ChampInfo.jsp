<!-- 모든 챔피언(캐릭터) 정보 출력하는 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<%@ page import="RiotAPI.*" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LOL 챔피언 정보 </title>

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
  <link rel="stylesheet" href="css/Champinfo.css">
</head>

<%  
    // 챔피언(캐릭터) 정보 객체 생성
	ChampInfo Champ = new ChampInfo();

	// 모든 챔피언(캐릭터) 정보가 담긴 JSON 파일을 파싱하는 요청
	Champ.request_Champ();
	
	// 해쉬맵 객체가 담긴 배열리스트 객체 생성
	ArrayList<HashMap<String, String>> champnum = new ArrayList<HashMap<String, String>>();
	
	// 파싱한 데이터를 배열 리스트 객체에 집어넣음
	champnum = Champ.get_Champ();

%>
<body>
  <!-- 헤더 -->
  <jsp:include page="Template/M_header.jsp" flush="true"/>
<section>
  <div class="notuse">
  </div>
  <div class="main">
  	  <!-- 비디오 나오는 부분 -->
  	  <div class="video">
  	  	 <!-- 컨트롤 가능하며 자동으로 틀게함. 자동시작시 음소거로 나올 수 있게함 -->
  	 	 <video controls autoplay muted>
  	  		<source src="img/lol.mp4" type="video/mp4" />
  	  	</video>
  	  </div>
      <div class="allchamp">
        <div class="allchamphead">모든 챔피언</div>
        <div class="allchampmain">
        <!-- 모든 챔피언 출력. 챔피언 클릭시 해당하는 챔피언의 정보로 넘어갈 수 있게함 -->
        <% 
			for(int i = 0; i<champnum.size();i++){
				out.println("<div>");
				out.println("<a href='ChampionInfo.jsp?name=");
				out.println(champnum.get(i).get("id"));
				out.println("'><img src=img/champion/"+champnum.get(i).get("id")+".png></a>");
				out.println("</div>");		
			}	
		%>
		</div>
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