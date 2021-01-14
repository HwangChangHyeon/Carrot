package DAODTO;

import java.sql.*;
import java.util.*;

public class AdminDAO { 
	
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
	
	public boolean updateDB(AdminEditDTO admineditdto) {
		connect();
		
		String sql ="update member_tb set member_name=?,member_pw=?,member_email=?,member_phone=?,Member_country=? where member_id=?";		
		 
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1,admineditdto.getEmember_name());
			pstmt.setString(2,admineditdto.getEmember_pw());
			pstmt.setString(3,admineditdto.getEmember_email());
			pstmt.setString(4,admineditdto.getEmember_phone());
			pstmt.setString(5,admineditdto.getEmember_country());
			pstmt.setString(6,admineditdto.getEmember_id());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	
		
	// 회원 탈퇴 메서드
	public boolean deleteDB(String amember_id) {
		connect();
		
		String sql ="delete from member_tb where member_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,amember_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}
	

	
	// 회원가입 정보 추가 메서드(회원이 직접 회원가입 할 때, 관리자가 추가 할 때 동일한 메서드 사용)
	public boolean insertDB(AdminAddDTO adminadddto) {
		connect();
				
		String sql ="insert into member_tb(Member_name,Member_id,Member_pw,Member_email,Member_phone,Member_country) values(?,?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,adminadddto.getAmember_name());
			pstmt.setString(2,adminadddto.getAmember_id());
			pstmt.setString(3,adminadddto.getAmember_pw());
			pstmt.setString(4,adminadddto.getAmember_email());
			pstmt.setString(5,adminadddto.getAmember_phone());
			pstmt.setString(6,adminadddto.getAmember_country());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			disconnect();
		}
		return true;
	}

	
	// 관리자가 관리자 로그인 페이지에 접속 할 때 DB에 ID, 패스워드와 동일한지 확인하는 메서드(일반 DB테이블과 서로 다른 테이블임)
	public boolean AdminMatchIDDB(AdminLoginDTO adminlogindto) {
		connect();
		
		String sql = "select * from admininfo where admin_id=? and admin_pw=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,adminlogindto.getAdid());
			pstmt.setString(2,adminlogindto.getAdpw());
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()==true)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return false;
	}
	
	// 관리자가 회원의 정보를 수정하기 위해서 회원의 ID로만 있는 회원인지 판별 할 때 사용하는 메서드
	public boolean AdminMatchIDDB(String member_id) {
		connect();
		
		String sql = "select * from member_tb where member_id=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,member_id);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()==true)
				return true;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return false;
	}
	
	// 관리자가 직접 회원의 정보를 수정할 때 파리미터를 ID만 넘겨서 해당 회원의 수정할 정보를 불러오는 메서드
	public HashMap<String, String> getMbrDB(String member_id) {
		connect();
		HashMap<String, String> mbr = new HashMap<String, String>();
		
		String sql = "select * from member_tb where member_id=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,member_id);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				mbr.put("member_name", rs.getString("member_name"));
				mbr.put("member_id", rs.getString("member_id"));
				mbr.put("member_email", rs.getString("member_email"));
				mbr.put("member_phone", rs.getString("member_phone"));
				mbr.put("member_country", rs.getString("member_country"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return mbr;
	}
	
	// 관리자 페이지에 회원 목록을 전부 다 띄우기 위해 데이터 베이스에서 멤버 이름 순으로 불러와 배열에 담는 메서드
	public ArrayList<AdminAddDTO> getDBList() {
		connect();
		ArrayList<AdminAddDTO> datas = new ArrayList<AdminAddDTO>();
		
		String sql = "select * from member_tb order by member_name asc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				AdminAddDTO adminadddto = new AdminAddDTO();
				
				adminadddto.setAmember_name(rs.getString("member_name"));
				adminadddto.setAmember_id(rs.getString("member_id"));
				adminadddto.setAmember_email(rs.getString("member_email"));
				adminadddto.setAmember_phone(rs.getString("member_phone"));
				adminadddto.setAmember_country(rs.getString("member_country"));
				datas.add(adminadddto);
			}
			rs.close();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return datas;
	}
	
	// 관리자 페이지에서 일반 회원의 유저 ID 개수를 파악 하는 메서드
	public int getDBListnum() {
		connect();
		int rowCount = 0;
		String sql = "select * from member_tb order by member_name desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			rs.last(); // rs의 인덱스를 맨 마지막으로 가져간다.
			rowCount = rs.getRow(); // rs의 레코드 값을 가져온다.
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return rowCount;
	}
	
	// 관리자 페이지에서 루트 회원의 유저 ID 개수를 파악 하는 메서드
	public int getadminDBListnum() {
		connect();
		int rowCount = 0;
		String sql = "select * from admininfo order by admin_id desc";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			rs.last(); // rs의 인덱스를 맨 마지막으로 가져간다.
			rowCount = rs.getRow(); // rs의 레코드 값을 가져온다.
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return rowCount;
	}
	
	public int getContentListnum() {
		connect();
		int rowCount = 0;
		String sql = "select * from BBS";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			rs.last(); // rs의 인덱스를 맨 마지막으로 가져간다.
			rowCount = rs.getRow(); // rs의 레코드 값을 가져온다.
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return rowCount;
	}
	
	public ArrayList<BbsDTO> getList(){
		connect();
		String SQL = "SELECT * FROM BBS ORDER BY bbsID DESC";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBbsID(rs.getInt("bbsID"));
				bbs.setBbsTitle(rs.getString("bbsTitle"));
				bbs.setUserID(rs.getString("userID"));
				bbs.setBbsDate(rs.getString("bbsDate"));
				bbs.setBbsContent(rs.getString("bbsContent"));
				bbs.setBbsimg(rs.getString("bbsimg"));
				bbs.setBbsPopularity(rs.getInt("bbsPopularity"));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return list; 
	}
	
	public int delete(int bbsID) {
		connect();
		
		String SQL = "DELETE FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			disconnect();
		}
		return -1; //데이터베이스 오류
	}

}
