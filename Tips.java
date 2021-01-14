package RiotAPI;

import java.sql.*;
import java.util.*;

public class Tips { 
	
	Connection conn = null;
	PreparedStatement pstmt = null;

	/* MariaDB 연결 */
	String DRIVER = "org.mariadb.jdbc.Driver";
    String DB = 
	String USER = 
	String PW =
	
	// DB연결 메서드
	void connect() {
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(DB,USER,PW);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// DB 연결 끊기 메서드
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// 챔피언 팁 정보 가져오기
	public HashMap<String, String> getChampTips(String champ_id) {
		connect();
		HashMap<String, String> tips = new HashMap<String, String>();
		
		String sql = "select * from champion where cham_id=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, champ_id);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tips.put("cham_title", rs.getString("cham_title"));
				tips.put("cham_allytip", rs.getString("cham_allytip"));
				tips.put("cham_enemytip", rs.getString("cham_enemytip"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return tips;
	}
	
}
