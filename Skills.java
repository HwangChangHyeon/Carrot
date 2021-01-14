package RiotAPI;

import java.sql.*;
import java.util.*;

public class Skills { 
	
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
	public HashMap<String, HashMap<String, String>> getChampSkills(String champ_id) {
		connect();
		HashMap<String, HashMap<String, String>> num = new HashMap<String, HashMap<String, String>>();
		
		String sql = "select * from skill where cham_id=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, champ_id);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, String> skills = new HashMap<String, String>();
				skills.put("skill_name", rs.getString("skill_name"));
				skills.put("skill_description", rs.getString("skill_description"));
				skills.put("skill_tooltip", rs.getString("skill_tooltip"));
				skills.put("skill_cooldownburn", rs.getString("skill_cooldownburn"));
				skills.put("skill_costburn", rs.getString("skill_costburn"));
				skills.put("skill_rangeburn", rs.getString("skill_rangeburn"));
				skills.put("skill_id", rs.getString("skill_id"));
				num.put(rs.getString("skill_num"), skills);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return num;
	}
	
}
