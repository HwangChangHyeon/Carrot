package RiotAPI;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class Spectator {
	
	public String activeGame_By_SummonerId(String id) throws Exception { // 특정 소환사가 진행중인 게임 정보 요청
		String encode_Id = URLEncoder.encode(id, "UTF-8").replace("+", "%20");
		return Request(Header.Spectator_Url + "active-games/by-summoner/" + encode_Id);
	}
	
	public String featured_Games() throws Exception { // 진행중인 게임 정보 요청
		return Request(Header.Spectator_Url + "featured-games");
	}
	
	public String Request(String target_Url) throws Exception {
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
		
		String body = response.toString();
		return body;
	}

}
