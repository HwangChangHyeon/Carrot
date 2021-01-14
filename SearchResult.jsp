<!-- 게임 유저 ID 검색결과 창(해당 유저의 게임 전적 불러오는 창) -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="ErrorPage.jsp"%>
<%@ page import="RiotAPI.*"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Carrot - 검색 결과</title>

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
<link rel="stylesheet" href="css/SearchResult.css">
<script src="js/main2.js" defer></script>
</head>

<body>
	<%
	
	HashMap<String, String> SummonerName = new HashMap<String, String>();
	HashMap<String, String> tier = new HashMap<String, String>();
	HashMap<String, String> rankSolo = new HashMap<String, String>();
	HashMap<String, String> itemtest = new HashMap<String, String>();
	HashMap<String, String> spellinfo = new HashMap<String, String>();
	HashMap<String, String> matcht = new HashMap<String, String>();
	ArrayList<HashMap<String, String>> matchList = new ArrayList<HashMap<String, String>>();
	ArrayList<HashMap<String, String>> matchgame = new ArrayList<HashMap<String, String>>();
	HashMap<String, HashMap<String, String>> participants_Info = new HashMap<String, HashMap<String, String>>();
	ArrayList<HashMap<String, String>> champ = new ArrayList<HashMap<String, String>>();
	ArrayList<ArrayList<HashMap<String, String>>> anotheru = new ArrayList<ArrayList<HashMap<String, String>>>();
	String[] game = new String[5];
	
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY-MM-dd HH:mm");
	
	
	Date date = new Date();
	Summoner SummonerInfo = new Summoner();
	League TierInfo = new League();
	Match match = new Match();
	ChampInfo champid = new ChampInfo();
	Item item = new Item();
	Spell spell = new Spell();

	

	SummonerInfo.by_Name(request.getParameter("gsearch"));
	SummonerName = SummonerInfo.get_Summoner();

	String profileIconId = SummonerName.get("profileIconId");
	String name = SummonerName.get("name");
	String summonerLevel = SummonerName.get("summonerLevel");
	String summonerid = SummonerName.get("id");
	String accountid = SummonerName.get("accountId");

	TierInfo.request_League(summonerid);
	rankSolo = TierInfo.get_RankSolo();

	String Tier = rankSolo.get("tier");
	String win = rankSolo.get("wins");
	String lose = rankSolo.get("losses");
	String rank = rankSolo.get("rank");

	if (Tier == null) {
		Tier = "UNRANKED";
		win = "";
		lose = "";
		rank = "";
	}


	
	match.matchlist_By_Account(accountid);
	matchList = match.get_MatchList();

	champid.request_Champ();
	champ = champid.get_Champ();

	for (int i = 0; i < 5; i++) {
		game[i] = matchList.get(i).get("gameId");
	}

	for (int i = 0; i < 5; i++) {
		match.matches_By_MatchId(game[i]);
		matcht = match.get_Match();
		participants_Info = match.get_participants_Info();
		HashMap<String, String> mgame = new HashMap<String, String>();
		ArrayList<HashMap<String, String>> anotheruser = new ArrayList<HashMap<String, String>>();
		ArrayList<HashMap<String, String>> itemget = new ArrayList<HashMap<String, String>>();

		for (int k = 1; k <= 10; k++) {
			if (participants_Info.get(String.valueOf(k)).get("summonerName").equals(name)) {
		if (participants_Info.get(String.valueOf(k)).get("win").equals("true")) {
			mgame.put("win", "승리");
			mgame.put("winbox", "gamewin");
		} else {
			mgame.put("win", "패배");
			mgame.put("winbox", "gamelose");
		}
		long time = Long.valueOf((matcht.get("gameCreation")));
		date.setTime(time);
		String dateString = simpleDateFormat.format(date);
		mgame.put("creation", dateString);
		mgame.put("id", participants_Info.get(String.valueOf(k)).get("summonerName"));
		mgame.put("kills", participants_Info.get(String.valueOf(k)).get("kills"));
		mgame.put("deaths", participants_Info.get(String.valueOf(k)).get("deaths"));
		mgame.put("assists", participants_Info.get(String.valueOf(k)).get("assists"));
		mgame.put("champLevel", participants_Info.get(String.valueOf(k)).get("champLevel"));
		for (int j = 0; j < 6; j++) {
			mgame.put("item" + j, participants_Info.get(String.valueOf(k)).get("item" + j));
			item.request_item(participants_Info.get(String.valueOf(k)).get("item" + j));
			itemtest = item.get_item();
			mgame.put("item" + j + "list", itemtest.get("item"));
			mgame.put("itemplain" + j, itemtest.get("plain"));
		}
		mgame.put("spell1", participants_Info.get(String.valueOf(k)).get("spell1Id"));
		spell.request_spell(participants_Info.get(String.valueOf(k)).get("spell1Id"));
		spellinfo = spell.get_spell();
		mgame.put("spell1_name", spellinfo.get("spell"));
		mgame.put("spell1_des", spellinfo.get("spell_des"));
		mgame.put("spell2", participants_Info.get(String.valueOf(k)).get("spell2Id"));
		spell.request_spell(participants_Info.get(String.valueOf(k)).get("spell2Id"));
		spellinfo = spell.get_spell();
		mgame.put("spell2_name", spellinfo.get("spell"));
		mgame.put("spell2_des", spellinfo.get("spell_des"));

		mgame.put("totalMinionsKilled", participants_Info.get(String.valueOf(k)).get("totalMinionsKilled"));
		mgame.put("neutralMinionsKilled", participants_Info.get(String.valueOf(k)).get("neutralMinionsKilled"));
		for (int j = 0; j < champ.size(); j++) {
			if (participants_Info.get(String.valueOf(k)).get("championId").equals(champ.get(j).get("key"))) {
				mgame.put("champimg", champ.get(j).get("id"));
				mgame.put("champname", champ.get(j).get("name"));
			}
		}
			} else {
		HashMap<String, String> auser = new HashMap<String, String>();
		if (participants_Info.get(String.valueOf(k)).get("win").equals("true")) {
			auser.put("win", "승리");
			auser.put("winbox", "gamewin");
		} else {
			auser.put("win", "패배");
			auser.put("winbox", "gamelose");
		}
		auser.put("id", participants_Info.get(String.valueOf(k)).get("summonerName"));
		auser.put("kills", participants_Info.get(String.valueOf(k)).get("kills"));
		auser.put("deaths", participants_Info.get(String.valueOf(k)).get("deaths"));
		auser.put("assists", participants_Info.get(String.valueOf(k)).get("assists"));
		auser.put("champLevel", participants_Info.get(String.valueOf(k)).get("champLevel"));

		for (int j = 0; j < 6; j++) {
			auser.put("item" + j, participants_Info.get(String.valueOf(k)).get("item" + j));
		}
		auser.put("totalMinionsKilled", participants_Info.get(String.valueOf(k)).get("totalMinionsKilled"));
		auser.put("neutralMinionsKilled", participants_Info.get(String.valueOf(k)).get("neutralMinionsKilled"));
		for (int j = 0; j < champ.size(); j++) {
			if (participants_Info.get(String.valueOf(k)).get("championId").equals(champ.get(j).get("key"))) {
				auser.put("champimg", champ.get(j).get("id"));
				auser.put("champname", champ.get(j).get("name"));
			}
		}
		anotheruser.add(auser);
			}
		}
		anotheru.add(anotheruser);
		matchgame.add(mgame);
	}
	%>
	<!-- 헤더 -->
	<jsp:include page="Template/M_header.jsp" flush="true" />
	<section>
		<div class="notuse">
		</div>
		<div class="main">
			
			<div class="pnamed2"><%=name%></div>
			<div class="profile">
				<div class="profileimg">
					<img src="img/profileicon/<%=profileIconId%>.png">
				</div>
				<div class="profilename">
					<div class="pnamed">
						<span class="pname"><%=name%></span>
					</div>
					<div class="plvd">
						<span class="plv">Lv.<%=summonerLevel%></span>
					</div>
					<div class="pstatd">
						<span class="pwin"><%=win%>승</span>
					</div>
					<div class="pstatd">
						<span class="plose"><%=lose%>패</span>
					</div>
				</div>
				<div class="profiletier">
					<div class="tname">Tier.</div>
					<div class="trank">솔로랭크</div>
					<div class="ttier"><%=Tier%></div>
					<div class="trank"><%=rank%></div>
				</div>
				<div class="tierimage">
					<img src="img/tier/<%=Tier%>.png">
				</div>
			</div>

			<div class="gamehistory">
				<div class="gamehead">매치 히스토리</div>
				<ul class="list-group">
					<%
						for (int i = 0; i < 5; i++) {
						out.println("<li class='list-group-item'>");
						out.println("<div class='maindiv'>");
						out.println("<div>");
						out.println("<div class='" + matchgame.get(i).get("winbox") + "'>" + matchgame.get(i).get("win") + "</div>");
						out.println("</div>");
						out.println("<div class='gamechamp'>");
						out.println("<a href='ChampionInfo.jsp?name=" + matchgame.get(i).get("champimg") + "'><img src='img/champion/"+ matchgame.get(i).get("champimg") + ".png'></a>");
						out.println("<div class='gamename'>" + matchgame.get(i).get("champname") + "</div>");
						out.println("</div>");
						out.println("<div class='games'>");
						out.println("<div class='gamestat'>");
						out.println("<span>" + matchgame.get(i).get("kills") + "</span>");
						out.println("<span>/</span>");
						out.println("<span class='lose'>" + matchgame.get(i).get("deaths") + "</span>");
						out.println("<span>/</span>");
						out.println("<span>" + matchgame.get(i).get("assists") + "</span>");
						out.println("</div>");
						out.println("<div class='spell'>");
						out.println("<span data-tooltip-text='" + matchgame.get(i).get("spell1_name") + "&#xa"
						+ matchgame.get(i).get("spell1_des") + "'><img src='img/spell/" + matchgame.get(i).get("spell1")
						+ ".png'></span>");
						out.println("<span data-tooltip-text='" + matchgame.get(i).get("spell2_name") + "&#xa"
						+ matchgame.get(i).get("spell2_des") + "'><img src='img/spell/" + matchgame.get(i).get("spell2")
						+ ".png'></span>");
						out.println("</div>");
						out.println("</div>");
						out.println("<div class='gameitem'>");
						for (int k = 0; k < 6; k++)
							out.println("<span data-tooltip-text='" + matchgame.get(i).get("item" + k + "list") + "&#xa"
							+ matchgame.get(i).get("itemplain" + k) + "'><img src='img/item/"
							+ matchgame.get(i).get("item" + String.valueOf(k)) + ".png'/></span>");
						out.println("</div>");
						out.println("<div class='gamelv'>");
						out.println("<div>Lv. " + matchgame.get(i).get("champLevel") + "</div>");
						out.println("<div>Cs. " + String.valueOf(Integer.parseInt(matchgame.get(i).get("totalMinionsKilled"))
						+ Integer.parseInt(matchgame.get(i).get("neutralMinionsKilled"))) + "</div>");
						out.println("</div>");
						out.println("<div class='time'>" + matchgame.get(i).get("creation") + "</div>");
						out.println("<div class='button'>");
						out.println("<b class='buttona" + String.valueOf(i) + "'><i class='fas fa-angle-down'></i></b>");
						out.println("</div>");
						out.println("</div>");
						// 서브 시작
						out.println("<div class='subdiv" + String.valueOf(i) + "'>");
						out.println("<div class='subname'> 함께 플레이한 소환사</div>");
						for (int j = 0; j < 9; j++) {
							out.println("<div class='subdiva" + String.valueOf(i) + "'>");
							out.println("<div>");
							out.println("<div class='" + anotheru.get(i).get(j).get("winbox") + "'>" + anotheru.get(i).get(j).get("win")
							+ "</div>");
							out.println("</div>");
							out.println("<div class='gamechamp'>");
							out.println("<a href='ChampionInfo.jsp?name=" + anotheru.get(i).get(j).get("champimg")
							+ "'><img src='img/champion/" + anotheru.get(i).get(j).get("champimg") + ".png'></a>");
							out.println("<div class='gamename'><a href='http://119.196.106.125/RiotApi/SearchResult.jsp?gsearch="
							+ anotheru.get(i).get(j).get("id") + "'>" + anotheru.get(i).get(j).get("id") + "</a></div>");
							out.println("</div>");
							out.println("<div class='gamestat'>");
							out.println("<span>" + anotheru.get(i).get(j).get("kills") + "</span>");
							out.println("<span>/</span>");
							out.println("<span class='lose'>" + anotheru.get(i).get(j).get("deaths") + "</span>");
							out.println("<span>/</span>");
							out.println("<span>" + anotheru.get(i).get(j).get("assists") + "</span>");
							out.println("</div>");
							out.println("<div class='gameitem'>");
							for (int k = 0; k < 6; k++)
								out.println("<img src='img/item/" + anotheru.get(i).get(j).get("item" + String.valueOf(k)) + ".png'/>");
							out.println("</div>");
							out.println("<div class='gamelv'>");
							out.println("<div>Lv. " + anotheru.get(i).get(j).get("champLevel") + "</div>");
							out.println("<div>Cs. " + String.valueOf(Integer.parseInt(anotheru.get(i).get(j).get("totalMinionsKilled"))
							+ Integer.parseInt(anotheru.get(i).get(j).get("neutralMinionsKilled"))) + "</div>");
							out.println("</div>");
							out.println("</div>");
						}
						out.println("</div>");
						out.println("</li>");
					}
					%>
				</ul>
			</div>
		</div>
		<div class="notuse"></div>
	</section>
	<article></article>
	<!-- 푸터 -->
	<jsp:include page="Template/M_footer.jsp" flush="true" />
	<script>
	$("#sidebar-toggle").click(function(){
		  $("html").toggleClass("open");
		});
	</script>
</body>
</html>