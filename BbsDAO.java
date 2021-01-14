package DAODTO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
	private Connection conn;
	private ResultSet rs;
	
	// DB 접근 
	public BbsDAO() {
		try {
			String dbURL = 
			String dbID = 
			String dbPassword = 
			Class.forName("org.mariadb.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	// 날짜 가져오는 메서드
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	// bbsID 다음 번호 확인하는 메서드
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; //첫 번째 게시물인 경우
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	
	// 게시글 작성 후 데이터베이스에 입력하는 메서드
	public int write(String bbsTitle, String userID, String bbsContent, String bbsimg) {
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setString(6, bbsimg);
			pstmt.setInt(7, 0);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 삭제되지 않은 게시글들을 10개씩 정렬하여 리스트로 불러오는 메서드
	public ArrayList<BbsDTO> getList(){
		String SQL = "SELECT * FROM BBS ORDER BY bbsID DESC";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsimg(rs.getString(6));
				bbs.setBbsPopularity(rs.getInt(7));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	// 삭제되지 않은 게시글들을 리스트로 불러오는 메서드
	public ArrayList<BbsDTO> getsearchList(String content){
		String SQL = "select * from BBS where bbsTitle  like '%"+content+"%'";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsimg(rs.getString(6));
				bbs.setBbsPopularity(rs.getInt(7));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	// 해당 게시글의 댓글을 불러오는 메서드
	public ArrayList<BbsReplyDTO> getReplyList(int bbsID){
		String SQL = "SELECT * FROM BBSreply WHERE bbsID = ? ORDER BY bbsDate DESC ";
		ArrayList<BbsReplyDTO> list = new ArrayList<BbsReplyDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,bbsID);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BbsReplyDTO bbs = new BbsReplyDTO();
				bbs.setBbsID(rs.getInt(1));
				bbs.setUserID(rs.getString(2));
				bbs.setBbsDate(rs.getString(3));
				bbs.setBbsContent(rs.getString(4));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	// TOP 10  인기 순위 10위까지 차례대로 불러오는 메서드
	public ArrayList<BbsDTO> getListpop(int pageNumber){
		String SQL = "SELECT * FROM BBS ORDER BY bbsPopularity DESC LIMIT 10";
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsimg(rs.getString(6));
				bbs.setBbsPopularity(rs.getInt(7));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list; 
	}
	
	
	// 게시글 번호를 받아 게시글 내용을 가져오는 메서드
	public BbsDTO getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsimg(rs.getString(6));
				bbs.setBbsPopularity(rs.getInt(7));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; 
	}
	
	// 게시글 수정 하는 메서드
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 댓글 저장하는 메서드
	public int reply(int bbsID, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBSreply VALUES(?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setString(4, bbsContent);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 게시글 삭제하는 메서드
	public int delete(int bbsID) {
		String SQL = "delete from BBS where bbsID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 특정 게시글의 댓글 수 구하는 메서드
	public int count(int bbsID) {
		String SQL = "select * from BBSreply where bbsID = ?";
		int rowCount = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			ResultSet rs = pstmt.executeQuery();
			rs.last(); // rs의 인덱스를 맨 마지막으로 가져간다.
			rowCount = rs.getRow(); // rs의 레코드 값을 가져온다.
			return rowCount;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	
	// 특정 게시글의 특정 댓글을 삭제하는 메서드
	public int deletereply(String content) {
		String SQL = "delete from BBSreply where bbsDate=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, content);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 특정 게시글 추천 수 증가 메서드
	public int updatePop(int bbsID) {
		String SQL = "UPDATE BBS SET bbsPopularity=bbsPopularity+1 WHERE bbsID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
}
