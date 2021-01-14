<!-- 특정 챔피언(캐릭터) 정보 출력하는 페이지 -->

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
  <link rel="stylesheet" href="css/ChampionInfo.css">
</head>

<%  
	// 챔피언(캐릭터) 객체 생성
	ChampInfo Champ = new ChampInfo();
	// 모든 챔피언(캐릭터)정보 파싱하도록 요청
	Champ.request_Champ();
	// 모든 챔피언(캐릭터)정보를 담을 배열 객체 생성		
	ArrayList<HashMap<String, String>> champnum = new ArrayList<HashMap<String, String>>();
	
	// 모든 챔피언(캐릭터)정보를 champnum 객체에 대입
	champnum = Champ.get_Champ();
	
	// 이전 페이지에서 넘겨준 챔피언(캐릭터)의 이름을 확인
	String name = request.getParameter("name");
	
	// 챔피언(캐릭터)팁 객체 생성
	Tips tip = new Tips();
	
	// 팁 객체에 해당 챔피언(캐릭터) 이름을 집어넣어 팁을 불러오기 
	HashMap<String, String> tips = tip.getChampTips(name);
	
	// 챔피언(캐릭터) 스킬 객체 생성
	Skills skill = new Skills();
	
	// 해쉬맵 객체에 해당 챔피언(캐릭터) 이름을 집어넣어 스킬내용을 불러오기
	HashMap<String, HashMap<String, String>> skills = skill.getChampSkills(name);

%>
<body>
  <!-- 헤더 -->
  <jsp:include page="Template/M_header.jsp" flush="true"/>
  <section>
  <!-- 사용하지 않는 영역 -->
  <div class="notuse">
  </div>
  <div class="main">
      <div class="allchamp">
        <div class="allchamphead">챔피언 정보</div>
        <div class="allchampmain">
        <!-- 모든 챔피언 정보의 이름을 하나씩 확인하면서 이전 페이지에서 받아온 이름과 동일할 경우 관련 내용 출력 -->
        <% 
			for(int i = 0; i<champnum.size();i++){
				if(champnum.get(i).get("id").equals(name)){
				out.println("<div>");
				out.println("<img src=img/champion/"+champnum.get(i).get("id")+".png onmouseenter='zoomIn(event)'onmouseleave='zoomOut(event)''></a>");
				out.println("</div>");	
				out.println("<div>");
				out.println("<b style='color:blue'>챔피언 이름</b>: " + champnum.get(i).get("name"));
				out.println("</div>");
				out.println("<div>");
				out.println("<b style='color:#e97341'>챔피언 타이틀</b> : " + champnum.get(i).get("title"));
				out.println("</div>");
				out.println("<div>");
				out.println(champnum.get(i).get("blurb"));
				out.println("</div>");
				out.println("<div>");
				out.println("<b style='color:#e97341'>챔피언 타입</b> : " + champnum.get(i).get("partype"));
				out.println("</div>");
				}
			}	
		%>
		</div>
		
		<!-- 챔피언 팁 출력 -->
		<div class="allchamphead">챔피언 팁</div>
		<div class="allchampmain">
		    <div id="tipcon" class="tipcontainer" style="display: flex; flex-wrap: wrap;">
		      
				<div class="champtips" style="flex: 1 1 40%; padding-left: 10px; padding-right: 10px; border-left: 5px solid #0000ff;">
					<div><b>아군 팁</b></div>
					
					<div><%= tips.get("cham_allytip") %></div>
				</div>
				  
				<div class="champtips" style="flex: 1 1 40%; padding-left: 10px; padding-right: 10px; border-left : 5px solid #ff0000;">
					<div><b>적군 팁</b></div>
					<div><%= tips.get("cham_enemytip") %></div>
				</div>
			</div>
		</div>
		
		<!-- 챔피언 스킬 내용 출력 -->
		<div class="allchamphead">챔피언 스킬</div>
		<div class="allchampmain">
			<!-- 첫번째 스킬 -->
			<div class="tipcontainer" style="display: flex; flex-wrap: wrap;">
				<div class="champtips" style="flex-shrink: 0; width: 150px;">
					<img src="img/spell/<%= skills.get("0").get("skill_id") + ".png"%>">
				</div>
				<div class="champtips" style="flex-grow: 1; line-height: 1.1;"><b><%= skills.get("0").get("skill_name")%> [Q]</b><br>
					<span style="font-size: 15px;">쿨타임(초) : <%= skills.get("0").get("skill_cooldownburn")%> </span><br>
					<span style="font-size: 15px;">소모 : <%= skills.get("0").get("skill_costburn")%> </span><br>
					<span style="font-size: 15px;">범위 : <%= skills.get("0").get("skill_rangeburn")%> </span>
				</div>
			</div>			
			<div><%= skills.get("0").get("skill_description")%></div>
				
				<!-- ****************************************************** -->
			
			<hr class="hr">
			<!-- 두번째 스킬 -->	
			<div class="tipcontainer" style="display: flex; flex-wrap: wrap;">
				<div class="champtips" style="flex-shrink: 0; width: 150px;">
					<img src="img/spell/<%= skills.get("1").get("skill_id") + ".png"%>">
				</div>
				<div class="champtips" style="flex-grow: 1; line-height: 1.1;"><b><%= skills.get("1").get("skill_name")%> [W]</b> <br>
					<span style="font-size: 15px;">쿨타임(초) : <%= skills.get("1").get("skill_cooldownburn")%> </span><br>
					<span style="font-size: 15px;">소모 : <%= skills.get("1").get("skill_costburn")%> </span><br>
					<span style="font-size: 15px;">범위 : <%= skills.get("1").get("skill_rangeburn")%> </span>
				</div>
			</div>
			<div><%= skills.get("1").get("skill_description")%></div>
				
				<!-- ****************************************************** -->
				
			<hr class="hr">
			<!-- 세번째 스킬 -->
			<div class="tipcontainer" style="display: flex; flex-wrap: wrap;">
				<div class="champtips" style="flex-shrink: 0; width: 150px;">
					<img src="img/spell/<%= skills.get("2").get("skill_id") + ".png"%>">
				</div>
				<div class="champtips" style="flex-grow: 1; line-height: 1.1;"><b><%= skills.get("2").get("skill_name")%> [E]</b> <br>
					<span style="font-size: 15px;">쿨타임(초) : <%= skills.get("2").get("skill_cooldownburn")%> </span><br>
					<span style="font-size: 15px;">소모 : <%= skills.get("2").get("skill_costburn")%> </span><br>
					<span style="font-size: 15px;">범위 : <%= skills.get("2").get("skill_rangeburn")%> </span>
				</div>
			</div>
			<div><%= skills.get("2").get("skill_description")%></div>
				
				<!-- ****************************************************** -->
				
			<hr class="hr">
			<!-- 네번째 스킬 -->
			<div class="tipcontainer" style="display: flex; flex-wrap: wrap;">
				<div class="champtips" style="flex-shrink: 0; width: 150px;">
					<img src="img/spell/<%= skills.get("3").get("skill_id") + ".png"%>">
				</div>
				<div class="champtips" style="flex-grow: 1; line-height: 1.1;"><b><%= skills.get("3").get("skill_name")%> [R]</b> <br>
					<span style="font-size: 15px;">쿨타임(초) : <%= skills.get("3").get("skill_cooldownburn")%> </span><br>
					<span style="font-size: 15px;">소모 : <%= skills.get("3").get("skill_costburn")%> </span><br>
					<span style="font-size: 15px;">범위 : <%= skills.get("3").get("skill_rangeburn")%> </span>
				</div>
			</div>
			<div><%= skills.get("3").get("skill_description")%></div>
		</div>
      </div>
   </div>
   <!-- 사용하지 않는 영역 -->
  <div class="notuse">
  </div>
</section>
  <!-- 푸터 -->
  <jsp:include page="Template/M_footer.jsp" flush="true"/>
</body>
</html>