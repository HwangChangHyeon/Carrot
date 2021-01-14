package RiotAPI;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;

public class Match { // 매치 정보 요청 클래스
	
	private String responseBody;
	
	// matches_By_MatchId
	private HashMap<String, String> match = new HashMap<String, String>();
	private HashMap<String, HashMap<String, String>> teams = new HashMap<String, HashMap<String, String>>();
	private HashMap<String, HashMap<String, String>> participants_Info = new HashMap<String, HashMap<String, String>>();
	
	// matchlist_By_Account
	private JSONArray matches;
	private ArrayList<HashMap<String, String>> matchList = new ArrayList<HashMap<String, String>>();
	
	/* ------------- Get Method ------------- */
	public HashMap<String, String> get_Match() {
		return this.match;
	}
	
	public HashMap<String, HashMap<String, String>> get_teams() {
		return this.teams;
	}
	
	public HashMap<String, HashMap<String, String>> get_participants_Info() {
		return this.participants_Info;
	}
	
	public ArrayList<HashMap<String, String>> get_MatchList() {
		return this.matchList;
	}
	
	/* ------------- Request Method ------------- */
	public void matches_By_MatchId(String matchId) throws Exception { // 매치id로 매치 정보 요청
		String encode_MatchId = URLEncoder.encode(matchId, "UTF-8").replace("+", "%20");
		Request(Header.Match_Url + "matches/" + encode_MatchId);
		
		JSONParser parser = new JSONParser();
		Object matches_Obj = parser.parse( responseBody );
		
		/* ---------- match Parsing ---------- */
		JSONObject matches_Json = (JSONObject) matches_Obj;
		match.put("gameId", matches_Json.get("gameId").toString());
		match.put("queueId", matches_Json.get("queueId").toString());
		match.put("gameType", matches_Json.get("gameType").toString());
		match.put("gameCreation", matches_Json.get("gameCreation").toString());
		match.put("gameDuration", matches_Json.get("gameDuration").toString());
		match.put("seasonId", matches_Json.get("seasonId").toString());
		match.put("gameVersion", matches_Json.get("gameVersion").toString());
		match.put("mapId", matches_Json.get("mapId").toString());
		match.put("gameMode", matches_Json.get("gameMode").toString());
		
		/* ---------- teams Parsing ---------- */
		JSONArray teams_Array = (JSONArray) matches_Json.get("teams");
		for (int i = 0; i < teams_Array.size(); i++) {
			HashMap<String, String> t_map = new HashMap<String, String>();
			t_map.put("win", ((JSONObject) teams_Array.get(i)).get("win").toString());
			t_map.put("firstBlood", ((JSONObject) teams_Array.get(i)).get("firstBlood").toString());
			t_map.put("firstTower", ((JSONObject) teams_Array.get(i)).get("firstTower").toString());
			t_map.put("firstInhibitor", ((JSONObject) teams_Array.get(i)).get("firstInhibitor").toString());
			t_map.put("firstBaron", ((JSONObject) teams_Array.get(i)).get("firstBaron").toString());
			t_map.put("firstDragon", ((JSONObject) teams_Array.get(i)).get("firstDragon").toString());
			t_map.put("firstRiftHerald", ((JSONObject) teams_Array.get(i)).get("firstRiftHerald").toString());
			t_map.put("towerKills", ((JSONObject) teams_Array.get(i)).get("towerKills").toString());
			t_map.put("inhibitorKills", ((JSONObject) teams_Array.get(i)).get("inhibitorKills").toString());
			t_map.put("baronKills", ((JSONObject) teams_Array.get(i)).get("baronKills").toString());
			t_map.put("dragonKills", ((JSONObject) teams_Array.get(i)).get("dragonKills").toString());
			t_map.put("riftHeraldKills", ((JSONObject) teams_Array.get(i)).get("riftHeraldKills").toString());
			this.teams.put(((JSONObject) teams_Array.get(i)).get("teamId").toString(), t_map);
		}
		
		/* ---------- participantIdentities & participants & stats Parsing ---------- */
		JSONArray participantIdentities_Array = (JSONArray) matches_Json.get("participantIdentities");
		JSONArray participants_Array = (JSONArray) matches_Json.get("participants");
		
		for (int i = 0; i < 10; i++) {
			HashMap<String, String> p_map = new HashMap<String, String>();
			
			p_map.put("profileIcon", ((JSONObject) ((JSONObject) participantIdentities_Array.get(i)).get("player")).get("profileIcon").toString());
			p_map.put("summonerName", ((JSONObject) ((JSONObject) participantIdentities_Array.get(i)).get("player")).get("summonerName").toString());
			
			p_map.put("championId", ((JSONObject) participants_Array.get(i)).get("championId").toString());
			p_map.put("teamId", ((JSONObject) participants_Array.get(i)).get("teamId").toString());
			p_map.put("spell1Id", ((JSONObject) participants_Array.get(i)).get("spell1Id").toString());
			p_map.put("spell2Id", ((JSONObject) participants_Array.get(i)).get("spell2Id").toString());
			
			p_map.put("win", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("win").toString());
			p_map.put("item0", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("item0").toString());
			p_map.put("item1", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("item1").toString());
			p_map.put("item2", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("item2").toString());
			p_map.put("item3", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("item3").toString());
			p_map.put("item4", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("item4").toString());
			p_map.put("item5", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("item5").toString());
			p_map.put("item6", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("item6").toString());
			p_map.put("kills", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("kills").toString());
			p_map.put("deaths", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("deaths").toString());
			p_map.put("assists", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("assists").toString());
			p_map.put("doubleKills", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("doubleKills").toString());
			p_map.put("tripleKills", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("tripleKills").toString());
			p_map.put("quadraKills", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("quadraKills").toString());
			p_map.put("pentaKills", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("pentaKills").toString());
			p_map.put("totalDamageDealtToChampions", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("totalDamageDealtToChampions").toString());
			p_map.put("visionScore", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("visionScore").toString());
			p_map.put("champLevel", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("champLevel").toString());
			p_map.put("perk0", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perk0").toString());
			p_map.put("perk1", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perk1").toString());
			p_map.put("perk2", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perk2").toString());
			p_map.put("perk3", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perk3").toString());
			p_map.put("perk4", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perk4").toString());
			p_map.put("perk5", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perk5").toString());
			p_map.put("perkPrimaryStyle", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perkPrimaryStyle").toString());
			p_map.put("perkSubStyle", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("perkSubStyle").toString());
			p_map.put("statPerk0", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("statPerk0").toString());
			p_map.put("statPerk1", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("statPerk1").toString());
			p_map.put("statPerk2", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("statPerk2").toString());
			p_map.put("totalMinionsKilled", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("totalMinionsKilled").toString());
			p_map.put("neutralMinionsKilled", ((JSONObject) ((JSONObject) participants_Array.get(i)).get("stats")).get("neutralMinionsKilled").toString());
			
			this.participants_Info.put("" + (i+1), p_map);
		}
	}
	
	public void matchlist_By_Account(String account) throws Exception { // account로 매치 리스트 요청(상위 100개)
		String encode_Account = URLEncoder.encode(account, "UTF-8").replace("+", "%20");
		Request(Header.Match_Url + "matchlists/by-account/" + encode_Account);
		
		JSONParser parser = new JSONParser();
		Object matchlist_Obj = parser.parse( responseBody );
		JSONObject matchlist_Json = (JSONObject) matchlist_Obj;
		matches = (JSONArray) matchlist_Json.get("matches");
		
		/* ---------- matchList Parsing ---------- */
		for (int i = 0; i < matches.size(); i++) {
			JSONObject match = (JSONObject) matches.get(i);
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("gameId", match.get("gameId").toString());
			map.put("champion", match.get("champion").toString());
			map.put("queue", match.get("queue").toString());
			map.put("season", match.get("season").toString());
			map.put("role", match.get("role").toString());
			map.put("lane", match.get("lane").toString());
			this.matchList.add(map);
		}
	}
	
	public void Request(String target_Url) throws Exception {
		URL url = new URL(target_Url);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		
		con.setRequestProperty("User-Agent", Header.User_Agent);
		con.setRequestProperty("Accept-Language", Header.Accept_Language);
		con.setRequestProperty("Accept-Charset", Header.Accept_Charset);
		con.setRequestProperty("Origin", Header.Origin);
		con.setRequestProperty("X-Riot-Token", Header.X_Riot_Token);
		
		
		int responseCode = con.getResponseCode();
		
		if (responseCode != 200) {
			System.out.println(responseCode);
		}
		
		BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		String inputLine;
		StringBuffer response = new StringBuffer();
		while ((inputLine = in.readLine()) != null) {
			response.append(inputLine);
		}
		
		in.close();
		
		this.responseBody = response.toString();
	}

}
