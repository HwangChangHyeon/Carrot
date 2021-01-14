package RiotAPI;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class League {
	
	private String responseBody;
	
	private HashMap<String, String> challengerLeague = new HashMap<String, String>();
	private HashMap<String, String> grandmasterLeague = new HashMap<String, String>();
	private HashMap<String, String> masterLeague = new HashMap<String, String>();
	private List<HashMap<String, String>> challengerEntries = new ArrayList<HashMap<String, String>>();
	private List<HashMap<String, String>> grandmasterEntries = new ArrayList<HashMap<String, String>>();
	private List<HashMap<String, String>> masterEntries = new ArrayList<HashMap<String, String>>();
	private HashMap<String, String> rankSolo = new HashMap<String, String>();
	private HashMap<String, String> rankFlex = new HashMap<String, String>();
	public boolean unrankSolo = false;
	public boolean unrankFlex = false;
	
	/* ------------- Get Method ------------- */
	public HashMap<String, String> get_ChallengerLeague() {
		return this.challengerLeague;
	}
	
	public HashMap<String, String> get_GrandmasterLeague() {
		return this.grandmasterLeague;
	}
	
	public HashMap<String, String> get_MasterLeague() {
		return this.masterLeague;
	}
	
	public List<HashMap<String, String>> get_ChallengerEntries() {
		return this.challengerEntries;
	}
	
	public List<HashMap<String, String>> get_GrandmasterEntries() {
		return this.grandmasterEntries;
	}
	
	public List<HashMap<String, String>> get_MasterEntries() {
		return this.masterEntries;
	}
	
	public HashMap<String, String> get_RankSolo() {
		return this.rankSolo;
	}
	
	public HashMap<String, String> get_RankFlex() {
		return this.rankFlex;
	}
	
	/* ------------- Request Method ------------- */
	public void request_Challenger() throws Exception { // 첼린저 리그
		Request(Header.League_Url + "challengerleagues/by-queue/RANKED_SOLO_5x5");
		
		JSONParser parser = new JSONParser();
		Object challenger_Obj = parser.parse( responseBody );
		JSONObject challenger_Json = (JSONObject) challenger_Obj;
		JSONArray challengerEntries_Array = (JSONArray) challenger_Json.get("entries");
		
		this.challengerLeague.put("tier", challenger_Json.get("tier").toString());
		this.challengerLeague.put("name", challenger_Json.get("name").toString());
		this.challengerLeague.put("queue", challenger_Json.get("queue").toString());
		this.challengerLeague.put("leagueId", challenger_Json.get("leagueId").toString());
		
		for (int i = 0; i < challengerEntries_Array.size(); i++) {
			HashMap<String, String> challEntrie_map = new HashMap<String, String>();
			challEntrie_map.put("summonerId", ((JSONObject) challengerEntries_Array.get(i)).get("summonerId").toString());
			challEntrie_map.put("summonerName", ((JSONObject) challengerEntries_Array.get(i)).get("summonerName").toString());
			challEntrie_map.put("leaguePoints", ((JSONObject) challengerEntries_Array.get(i)).get("leaguePoints").toString());
			challEntrie_map.put("rank", ((JSONObject) challengerEntries_Array.get(i)).get("rank").toString());
			challEntrie_map.put("wins", ((JSONObject) challengerEntries_Array.get(i)).get("wins").toString());
			challEntrie_map.put("losses", ((JSONObject) challengerEntries_Array.get(i)).get("losses").toString());
			this.challengerEntries.add(challEntrie_map);
		}
		
		Collections.sort(this.challengerEntries, new Comparator<HashMap<String, String>>() {
			@Override
			public int compare(HashMap<String, String> o1, HashMap<String, String> o2) {
				Integer age1 = (Integer) Integer.parseInt(o1.get("leaguePoints"));
				Integer age2 = (Integer) Integer.parseInt(o2.get("leaguePoints"));
				return age2.compareTo(age1);
			}
		});
	}
	
	public void request_Grandmaster() throws Exception { // 그랜드마스터 리그
		Request(Header.League_Url + "grandmasterleagues/by-queue/RANKED_SOLO_5x5");
		
		JSONParser parser = new JSONParser();
		Object grandmaster_Obj = parser.parse( responseBody );
		JSONObject grandmaster_Json = (JSONObject) grandmaster_Obj;
		JSONArray grandmasterEntries_Array = (JSONArray) grandmaster_Json.get("entries");
		
		this.grandmasterLeague.put("tier", grandmaster_Json.get("tier").toString());
		this.grandmasterLeague.put("name", grandmaster_Json.get("name").toString());
		this.grandmasterLeague.put("queue", grandmaster_Json.get("queue").toString());
		this.grandmasterLeague.put("leagueId", grandmaster_Json.get("leagueId").toString());
		
		for (int i = 0; i < grandmasterEntries_Array.size(); i++) {
			HashMap<String, String> grandEntrie_map = new HashMap<String, String>();
			grandEntrie_map.put("summonerId", ((JSONObject) grandmasterEntries_Array.get(i)).get("summonerId").toString());
			grandEntrie_map.put("summonerName", ((JSONObject) grandmasterEntries_Array.get(i)).get("summonerName").toString());
			grandEntrie_map.put("leaguePoints", ((JSONObject) grandmasterEntries_Array.get(i)).get("leaguePoints").toString());
			grandEntrie_map.put("rank", ((JSONObject) grandmasterEntries_Array.get(i)).get("rank").toString());
			grandEntrie_map.put("wins", ((JSONObject) grandmasterEntries_Array.get(i)).get("wins").toString());
			grandEntrie_map.put("losses", ((JSONObject) grandmasterEntries_Array.get(i)).get("losses").toString());
			this.grandmasterEntries.add(grandEntrie_map);
		}
		
		Collections.sort(this.grandmasterEntries, new Comparator<HashMap<String, String>>() {
			@Override
			public int compare(HashMap<String, String> o1, HashMap<String, String> o2) {
				Integer age1 = (Integer) Integer.parseInt(o1.get("leaguePoints"));
				Integer age2 = (Integer) Integer.parseInt(o2.get("leaguePoints"));
				return age2.compareTo(age1);
			}
		});
	}
	
	public void request_Master() throws Exception { // 마스터 리그
		Request(Header.League_Url + "masterleagues/by-queue/RANKED_SOLO_5x5");
		
		JSONParser parser = new JSONParser();
		Object master_Obj = parser.parse( responseBody );
		JSONObject master_Json = (JSONObject) master_Obj;
		JSONArray masterEntries_Array = (JSONArray) master_Json.get("entries");
		
		this.masterLeague.put("tier", master_Json.get("tier").toString());
		this.masterLeague.put("name", master_Json.get("name").toString());
		this.masterLeague.put("queue", master_Json.get("queue").toString());
		this.masterLeague.put("leagueId", master_Json.get("leagueId").toString());
		
		for (int i = 0; i < masterEntries_Array.size(); i++) {
			HashMap<String, String> masterEntrie_map = new HashMap<String, String>();
			masterEntrie_map.put("summonerId", ((JSONObject) masterEntries_Array.get(i)).get("summonerId").toString());
			masterEntrie_map.put("summonerName", ((JSONObject) masterEntries_Array.get(i)).get("summonerName").toString());
			masterEntrie_map.put("leaguePoints", ((JSONObject) masterEntries_Array.get(i)).get("leaguePoints").toString());
			masterEntrie_map.put("rank", ((JSONObject) masterEntries_Array.get(i)).get("rank").toString());
			masterEntrie_map.put("wins", ((JSONObject) masterEntries_Array.get(i)).get("wins").toString());
			masterEntrie_map.put("losses", ((JSONObject) masterEntries_Array.get(i)).get("losses").toString());
			this.masterEntries.add(masterEntrie_map);
		}
		
		Collections.sort(this.masterEntries, new Comparator<HashMap<String, String>>() {
			@Override
			public int compare(HashMap<String, String> o1, HashMap<String, String> o2) {
				Integer age1 = (Integer) Integer.parseInt(o1.get("leaguePoints"));
				Integer age2 = (Integer) Integer.parseInt(o2.get("leaguePoints"));
				return age2.compareTo(age1);
			}
		});
	}
	
	public void request_League(String id) throws Exception {
		String encode_Id = URLEncoder.encode(id, "UTF-8").replace("+", "%20");
		Request(Header.League_Url + "entries/by-summoner/" + encode_Id);
		
		JSONParser parser = new JSONParser();
		Object league_Obj = parser.parse( responseBody );
		JSONArray league_Array = (JSONArray) league_Obj;
		JSONObject rankSolo_Json;
		JSONObject rankFlex_Json;
		
		if (league_Array.size() == 0) { /* 자랭. 개인랭 모두 언랭 */
			unrankSolo = true;
			unrankFlex = true;
		}
		else if (league_Array.size() == 1) { /* 자랭 혹은 개인랭 기록이 있을 때 */
			if (((JSONObject) league_Array.get(0)).get("queueType").toString().equals("RANKED_SOLO_5x5")) {
				rankSolo_Json = (JSONObject) league_Array.get(0);
				
				this.rankSolo.put("leagueId", rankSolo_Json.get("leagueId").toString());
				this.rankSolo.put("queueType", rankSolo_Json.get("queueType").toString());
				this.rankSolo.put("tier", rankSolo_Json.get("tier").toString());
				this.rankSolo.put("rank", rankSolo_Json.get("rank").toString());
				this.rankSolo.put("summonerId", rankSolo_Json.get("summonerId").toString());
				this.rankSolo.put("summonerName", rankSolo_Json.get("summonerName").toString());
				this.rankSolo.put("leaguePoints", rankSolo_Json.get("leaguePoints").toString());
				this.rankSolo.put("wins", rankSolo_Json.get("wins").toString());
				this.rankSolo.put("losses", rankSolo_Json.get("losses").toString());
				
				unrankFlex = true;
			}
			else if (((JSONObject) league_Array.get(0)).get("queueType").toString().equals("RANKED_FLEX_SR")) {
				rankFlex_Json = (JSONObject) league_Array.get(0);
				
				this.rankFlex.put("leagueId", rankFlex_Json.get("leagueId").toString());
				this.rankFlex.put("queueType", rankFlex_Json.get("queueType").toString());
				this.rankFlex.put("tier", rankFlex_Json.get("tier").toString());
				this.rankFlex.put("rank", rankFlex_Json.get("rank").toString());
				this.rankFlex.put("summonerId", rankFlex_Json.get("summonerId").toString());
				this.rankFlex.put("summonerName", rankFlex_Json.get("summonerName").toString());
				this.rankFlex.put("leaguePoints", rankFlex_Json.get("leaguePoints").toString());
				this.rankFlex.put("wins", rankFlex_Json.get("wins").toString());
				this.rankFlex.put("losses", rankFlex_Json.get("losses").toString());
				
				unrankSolo = true;
			}
		}
		else if (league_Array.size() == 2) { /* 자랭, 개인랭 모두 기록이 있을 때 */
			if (((JSONObject) league_Array.get(0)).get("queueType").toString().equals("RANKED_SOLO_5x5")) {
				rankSolo_Json = (JSONObject) league_Array.get(0);
				rankFlex_Json = (JSONObject) league_Array.get(1);
			}
			else {
				rankSolo_Json = (JSONObject) league_Array.get(1);
				rankFlex_Json = (JSONObject) league_Array.get(0);
			}
			
			this.rankSolo.put("leagueId", rankSolo_Json.get("leagueId").toString());
			this.rankSolo.put("queueType", rankSolo_Json.get("queueType").toString());
			this.rankSolo.put("tier", rankSolo_Json.get("tier").toString());
			this.rankSolo.put("rank", rankSolo_Json.get("rank").toString());
			this.rankSolo.put("summonerId", rankSolo_Json.get("summonerId").toString());
			this.rankSolo.put("summonerName", rankSolo_Json.get("summonerName").toString());
			this.rankSolo.put("leaguePoints", rankSolo_Json.get("leaguePoints").toString());
			this.rankSolo.put("wins", rankSolo_Json.get("wins").toString());
			this.rankSolo.put("losses", rankSolo_Json.get("losses").toString());
			
			this.rankFlex.put("leagueId", rankFlex_Json.get("leagueId").toString());
			this.rankFlex.put("queueType", rankFlex_Json.get("queueType").toString());
			this.rankFlex.put("tier", rankFlex_Json.get("tier").toString());
			this.rankFlex.put("rank", rankFlex_Json.get("rank").toString());
			this.rankFlex.put("summonerId", rankFlex_Json.get("summonerId").toString());
			this.rankFlex.put("summonerName", rankFlex_Json.get("summonerName").toString());
			this.rankFlex.put("leaguePoints", rankFlex_Json.get("leaguePoints").toString());
			this.rankFlex.put("wins", rankFlex_Json.get("wins").toString());
			this.rankFlex.put("losses", rankFlex_Json.get("losses").toString());
			
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
