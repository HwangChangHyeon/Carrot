package RiotAPI;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class Summoner { // 소환사 정보 요청 클래스
	
	private String responseBody;
	
	private HashMap<String, String> summoner = new HashMap<String, String>();
	
	/* ------------- Get Method ------------- */
	public HashMap<String, String> get_Summoner() {
		return this.summoner;
	}
	
	/* ------------- Request Method ------------- */
	public void by_Account(String account) throws Exception { // account로 요청
		String encode_Account = URLEncoder.encode(account, "UTF-8").replace("+", "%20");
		Request(Header.Summoner_Url + "by-account/" + encode_Account);
		
		JSONParser parser = new JSONParser();
		Object sommoner_Obj = parser.parse( responseBody );
		JSONObject sommoner_Json = (JSONObject) sommoner_Obj;
		
		summoner.put("accountId", sommoner_Json.get("accountId").toString()); 
		summoner.put("id", sommoner_Json.get("id").toString());
		summoner.put("name", sommoner_Json.get("name").toString());
		summoner.put("profileIconId", sommoner_Json.get("profileIconId").toString());
		summoner.put("puuid", sommoner_Json.get("puuid").toString());
		summoner.put("summonerLevel", sommoner_Json.get("summonerLevel").toString());
	}
	
	public void by_Name(String name) throws Exception { // name로 요청
		String encode_Name = URLEncoder.encode(name, "UTF-8").replace("+", "%20");
		Request(Header.Summoner_Url + "by-name/" + encode_Name);
		
		JSONParser parser = new JSONParser();
		Object sommoner_Obj = parser.parse( responseBody );
		JSONObject sommoner_Json = (JSONObject) sommoner_Obj;
		
		summoner.put("accountId", sommoner_Json.get("accountId").toString()); 
		summoner.put("id", sommoner_Json.get("id").toString());
		summoner.put("name", sommoner_Json.get("name").toString());
		summoner.put("profileIconId", sommoner_Json.get("profileIconId").toString());
		summoner.put("puuid", sommoner_Json.get("puuid").toString());
		summoner.put("summonerLevel", sommoner_Json.get("summonerLevel").toString());
	}
	
	public void by_Puuid(String puuid) throws Exception { // puuid로 요청
		String encode_Puuid = URLEncoder.encode(puuid, "UTF-8").replace("+", "%20");
		Request(Header.Summoner_Url + "by-puuid/" + encode_Puuid);
		
		JSONParser parser = new JSONParser();
		Object sommoner_Obj = parser.parse( responseBody );
		JSONObject sommoner_Json = (JSONObject) sommoner_Obj;
		
		summoner.put("accountId", sommoner_Json.get("accountId").toString()); 
		summoner.put("id", sommoner_Json.get("id").toString());
		summoner.put("name", sommoner_Json.get("name").toString());
		summoner.put("profileIconId", sommoner_Json.get("profileIconId").toString());
		summoner.put("puuid", sommoner_Json.get("puuid").toString());
		summoner.put("summonerLevel", sommoner_Json.get("summonerLevel").toString());
	}
	
	public void by_Id(String id) throws Exception { // id로 요청 (잘못된 정보로 계속 조회시 제한걸림 사용 시 주의)
		String encode_Id = URLEncoder.encode(id, "UTF-8").replace("+", "%20");
		Request(Header.Summoner_Url + encode_Id);
		
		JSONParser parser = new JSONParser();
		Object sommoner_Obj = parser.parse( responseBody );
		JSONObject sommoner_Json = (JSONObject) sommoner_Obj;
		
		summoner.put("accountId", sommoner_Json.get("accountId").toString()); 
		summoner.put("id", sommoner_Json.get("id").toString());
		summoner.put("name", sommoner_Json.get("name").toString());
		summoner.put("profileIconId", sommoner_Json.get("profileIconId").toString());
		summoner.put("puuid", sommoner_Json.get("puuid").toString());
		summoner.put("summonerLevel", sommoner_Json.get("summonerLevel").toString());
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
