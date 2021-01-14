package RiotAPI;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;

public class Rotation { // 소환사 정보 요청 클래스
	ArrayList<String> Champnum = new ArrayList<String>();
	
	public ArrayList<String> get_Rotation() throws Exception {
		return this.Champnum;
	}
	
	
	public void Request_Rotation() throws Exception {
  	     ArrayList<HashMap<String, String>> Champ = new ArrayList<HashMap<String, String>>();
	  	 ArrayList<String> freeChamp = new ArrayList<String>();
	  	 
	  	 
	  	 Champion Freechampion = new Champion();
	  	 ChampInfo ChampInfo = new ChampInfo();
	  	 
	  	 Freechampion.request_Rotation(); 
	   	 freeChamp = Freechampion.get_FreeChampions();
	   	 
	   	 ChampInfo.request_Champ();
	   	 Champ = ChampInfo.get_Champ();
	   	 
	   	 for(String i : freeChamp){
	   		 for(int k=0 ; k < Champ.size(); k++){
	   			 if(i.equals(Champ.get(k).get("key"))) {
	   				 this.Champnum.add(Champ.get(k).get("id"));
	   			 }
	   		 }
	   	 }
	}
}