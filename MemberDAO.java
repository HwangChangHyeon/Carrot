package DAODTO;

import java.sql.*;
import java.util.*;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;



public class MemberDAO { 
	
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
	
	// 회원 본인이 본인 정보를 수정하기 위한 업데이트 메서드
	public boolean updateDB(MemberEditDTO membereditdto) {
		connect();
		
		String sql ="update member_tb set Member_name=?,Member_pw=?,Member_email=?,Member_phone=?,Member_country=? where member_id=?";		
		 
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,membereditdto.getEemember_name());
			pstmt.setString(2,membereditdto.getEemember_pw());
			pstmt.setString(3,membereditdto.getEemember_email());
			pstmt.setString(4,membereditdto.getEemember_phone());
			pstmt.setString(5,membereditdto.getEemember_country());
			pstmt.setString(6,membereditdto.getEemember_id());
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
	public boolean deleteDB(String member_id) {
		connect();
		
		String sql ="delete from member_tb where member_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,member_id);
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
	public boolean insertDB(MemberAddDTO memberadddto) {
		connect();
				
		String sql ="insert into member_tb(Member_name,Member_id,Member_pw,Member_email,Member_phone,Member_country) values(?,?,?,?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memberadddto.getMember_name());
			pstmt.setString(2,memberadddto.getMember_id());
			pstmt.setString(3,memberadddto.getMember_pw());
			pstmt.setString(4,memberadddto.getMember_email());
			pstmt.setString(5,memberadddto.getMember_phone());
			pstmt.setString(6,memberadddto.getMember_country());
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
	
	// 카카오 회원가입 정보 추가 메서드
	public boolean kakaoinsertDB(KakaoMemberDTO kakaomemberdto) throws UnsupportedEncodingException {
		connect();
				
		String sql ="insert into member_tb(Member_name,Member_id,Member_email,Member_pw) values(?,?,?,?)";
	
	
	    String text = URLDecoder.decode(kakaomemberdto.getNickname(), "UTF-8") ;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,text);
			pstmt.setString(2,kakaomemberdto.getId());
			pstmt.setString(3,kakaomemberdto.getEmail());
			pstmt.setString(4,"!@#!$DAF!@$DASF!@123153");
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
	
	// 카카오회원이 로그인 할때 DB에 ID, 패스워드와 동일한지 확인하는 메서드
	public boolean kakaoMatchIDDB(KakaoMemberLoginDTO kakaomemberlogindto) {
		connect();
		
		String sql = "select * from member_tb where member_id=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,kakaomemberlogindto.getKid());
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()==true) {
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			disconnect();
		}
		return false;
	}
	

	// 회원이 로그인 할때 DB에 ID, 패스워드와 동일한지 확인하는 메서드
	public boolean MatchIDDB(MemberLoginDTO memberlogindto) {
		connect();
		
		String sql = "select * from member_tb where member_id=? and member_pw=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memberlogindto.getid());
			pstmt.setString(2,memberlogindto.getpw());
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
	
	public boolean MatchIDDB(String id) {
		connect();
		
		String sql = "select * from member_tb where member_id=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
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
	
	
	// 회원이 정보 수정하기 전 비밀번호 재확인 할 때 사용하는 메서드
	public boolean MatchIDDB(String id, String pw) {
		connect();
		
		String sql = "select * from member_tb where member_id=? and member_pw=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,pw);
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
	

	// 회원이 직접 회원의 정보를 수정할 때 파리미터를 ID와 PW로 넘겨서 해당 회원의 수정할 정보를 불러오는 메서드
	public HashMap<String, String> getMbrDB(String member_id, String member_pw) {
		connect();
		HashMap<String, String> mbr = new HashMap<String, String>();
		
		String sql = "select * from member_tb where member_id=? and member_pw=?";
		 		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,member_id);
			pstmt.setString(2,member_pw);
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
	
}
