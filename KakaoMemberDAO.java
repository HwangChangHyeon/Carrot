
package DAODTO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import org.json.simple.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;

public class KakaoMemberDAO {
	

private String responseBody;
private String b;
// 카카오에서 로그인시 서버로 전달 받을 ID
private String c;
// 카카오 RESTAPI KEY
private String key = 
// 카카오에서 리다이렉트 시킬 URL 주소
private String redirecturl =
// 카카오에서 로그인 시 서버로 전달 받을 EMAIL
private String email;
// 카카오에서 로그인 시 서버로 전달 받을 닉네임
private String nickname;


public String getKey() {
	return key;
}

public String getRedirecturl() {
	return redirecturl;
}

public String getC() {
	return c;
}

public String getB() {
	return b;
}

public String getEmail() {
	return email;
}

public String getNickname() {
	return nickname;
}


// 카카오 프로필 가져오는 메서드
public void request_profile() throws Exception { 
	
	String a = "https://kapi.kakao.com/v2/user/me";
	// 카카오에 요청하여 프로필 정보 responseBody로 가져오기
	Requesta(a);
	System.out.println(responseBody);
	JSONParser parser = new JSONParser();
	
	// responseBody를 JsonObject로 파서하기
	Object matches_Obj = parser.parse( responseBody );
	JSONObject matches_Json = (JSONObject) matches_Obj;
	// 카카오 계정 프로필 ID를 c에 담기
	c = matches_Json.get("id").toString();
	
	// kakao_account를 파서하기
	String d = matches_Json.get("kakao_account").toString();
	Object nickname2 = parser.parse( d );
	JSONObject nickname1 = (JSONObject) nickname2;
	
	// email 변수에 email 담기
	if(nickname1.get("email")==null) {
		email="";
	}else {
		email=nickname1.get("email").toString();
	}
	
	// profile 파서하여 nickname 변수에 담기
	String e = nickname1.get("profile").toString();
	Object h = parser.parse( e );
	JSONObject f= (JSONObject) h;
	nickname = f.get("nickname").toString();
	
	// 아이디, 이메일, 닉네임 전역변수에 담기
	this.c = c;
	this.email = email;
	this.nickname = nickname;
}


// 카카오 API에 요청하여 프로필 접근에 필요한 엑세스 토큰 받아오기
public void request_Rotation() throws Exception { // 로테이션 요청
	JSONParser parser = new JSONParser();
	Object matches_Obj = parser.parse( responseBody );
	JSONObject matches_Json = (JSONObject) matches_Obj;
	b = matches_Json.get("access_token").toString();
	
	this.b=b;
}

// 카카오 API에 POST 방식으로 URL 요청하여 responseBody 응답 메시지 담기
public void Request(String target_Url) throws Exception {
	URL url = new URL(target_Url);
	HttpURLConnection con = (HttpURLConnection) url.openConnection();
	con.setRequestMethod("POST");
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


// 카카오 API에 POST 방식으로 URL 요청하여 responseBody에 응답 메시지 담기
// 위와 다르게 여기선 Authorization과 Bearer 그리고 토큰을 프로퍼티로 설정한다
public void Requesta(String target_Url) throws Exception {
	URL url = new URL(target_Url);
	HttpURLConnection con = (HttpURLConnection) url.openConnection();
	con.setRequestMethod("POST");
	
	con.setRequestProperty("Authorization", "Bearer " + b);
	int responseCode = con.getResponseCode();
	
	if (responseCode != 200) {
		System.out.println("responseCode : " + responseCode);
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

// 카카오 API에서 로그아웃 하는 메서드
public void kakaoLogout(String access_Token, String kid) {
    String reqURL = "https://kapi.kakao.com/v1/user/logout?target_id_type=user_id&target_id="+kid;
    try {
        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
        
        int responseCode = conn.getResponseCode();
        System.out.println("responseCode : " + responseCode);
        
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        
        String result = "";
        String line = "";
        
        while ((line = br.readLine()) != null) {
            result += line;
        }
    } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
}

// 카카오 API에서 토큰 삭제하는 메서드
public void kakaodelete(String access_Token) {
    String reqURL = "https://kapi.kakao.com/v1/user/unlink";
    try {
        URL url = new URL(reqURL);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Authorization", "Bearer " + access_Token);
        
        int responseCode = conn.getResponseCode();
        System.out.println("responseCode : " + responseCode);
        
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        
        String result = "";
        String line = "";
        
        while ((line = br.readLine()) != null) {
            result += line;
        }
        System.out.println(result);
    } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
}


}


