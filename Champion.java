 	 package RiotAPI;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;

public class Champion {
	
	private String responseBody;
	
	private ArrayList<String> freeChampions = new ArrayList<String>();
	private ArrayList<String> freeChampionsForNewPlayers = new ArrayList<String>();
	
	
	/* ------------- Get Method ------------- */
	public ArrayList<String> get_FreeChampions() {
		return this.freeChampions;
	}

	
	public ArrayList<String> get_FreeChampionsForNewPlayers() {
		return this.freeChampionsForNewPlayers;
	}
	
	/* ------------- Request Method ------------- */
	public void request_Rotation() throws Exception { // 로테이션 요청
		Request(Header.Champion_Url);
		
		JSONParser parser = new JSONParser();
		Object roation_Obj = parser.parse( responseBody );
		JSONObject rotation_Json = (JSONObject) roation_Obj;
		JSONArray freeChamp = (JSONArray) rotation_Json.get("freeChampionIds");
		JSONArray freeChampForNewPlayer = (JSONArray) rotation_Json.get("freeChampionIdsForNewPlayers");
		
		for (int i = 0; i < freeChamp.size(); i++) {
			this.freeChampions.add(freeChamp.get(i).toString());
		}
		
		for (int i = 0; i < freeChampForNewPlayer.size(); i++) {
			this.freeChampionsForNewPlayers.add(freeChampForNewPlayer.get(i).toString());
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
