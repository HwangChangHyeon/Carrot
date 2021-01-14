package RiotAPI;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.ArrayList;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

public class ChampInfo { // 소환사 정보 요청 클래스

	private ArrayList<HashMap<String, String>> champ = new ArrayList<HashMap<String, String>>();

	/* ------------- Get Method ------------- */
	public ArrayList<HashMap<String, String>> get_Champ() {
		return this.champ;
	}

	/* ------------- Request Method ------------- */
	public void request_Champ() throws Exception { // account로 요청

		JSONParser parser = new JSONParser();
		Object obj = parser.parse(new FileReader("c:\\champion.json"));

		JSONObject jsonObject = (JSONObject) obj;
		JSONObject data = (JSONObject) jsonObject.get("data");
		Set<String> key = data.keySet();
		Iterator<String> iter = key.iterator();

		while (iter.hasNext()) {
			HashMap<String, String> championInfo = new HashMap<String, String>();
			
			String keyname = iter.next();
			JSONObject champion = (JSONObject) data.get(keyname);

			championInfo.put("id",(String) champion.get("id"));
			championInfo.put("key",(String) champion.get("key"));
			championInfo.put("name",(String) champion.get("name"));
			championInfo.put("title",(String) champion.get("title"));
			championInfo.put("blurb",(String) champion.get("blurb"));
			championInfo.put("partype",(String) champion.get("partype"));
			this.champ.add(championInfo);
		}
	}
}
