package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import DTO.ReplyDTO;

public class ReplyDAO {
	private static Connection conn;
	private String url = "jdbc:oracle:thin:@localhost:1521:xe";
	private String dbid = "temp";
	private String dbpw = "1234";

	private ReplyDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static ReplyDAO instance = new ReplyDAO();
	
	public static ReplyDAO getInstance() {
		return instance;
	}

	public void closeConnection() {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int replyCount(int postNo){
		
		int cnt = 0;
		String sql = "SELECT COUNT(*) FROM reply WHERE post_no=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, postNo);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				cnt = rs.getInt("COUNT(*)");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return cnt;
	}
	
	public ArrayList<ReplyDTO> showReply(int postNo) {
		ArrayList<ReplyDTO> showReply = new ArrayList<>();
		
		String sql = "SELECT r.*, m.nickname" +
				" FROM reply r, member m " +
				" WHERE r.reg_no = m.reg_no AND r.post_no = ? AND r.up_rpl_no IS NULL" +
				" ORDER BY r.rpl_no";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, postNo);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReplyDTO reply = new ReplyDTO(); 
				reply.setRplNo(rs.getInt("rpl_no"));
				reply.setContent(rs.getString("content"));
				reply.setReplyTime(rs.getString("time"));
				reply.setReplyCondition(rs.getInt("reply_condition"));
				reply.setNickname(rs.getString("nickname"));
				showReply.add(reply);
			}
			
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return showReply;
	}
	
	public ArrayList<ReplyDTO> showChildReply(int upRplNo) {
		ArrayList<ReplyDTO> showChildReply = new ArrayList<>();
		
		 String sql = 
			        "SELECT r.*, m.nickname"
			      + "  FROM reply r, member m" 
			      + "  WHERE r.reg_no=m.reg_no AND up_rpl_no=? AND reply_condition=0"
			      + "  ORDER BY r.rpl_no";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, upRplNo);
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReplyDTO reply = new ReplyDTO(); 
				reply.setRplNo(rs.getInt("rpl_no"));
				reply.setContent(rs.getString("content"));
				reply.setReplyTime(rs.getString("time"));
				reply.setReplyCondition(rs.getInt("reply_condition"));
				reply.setNickname(rs.getString("nickname"));
				showChildReply.add(reply);
			}
			
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return showChildReply;
	}
	
	public void saveReply(String upload_text, int showPostNo, int reg_no, int up_rpl_no) throws Exception {

		String sql = "INSERT INTO reply (rpl_no, post_no, up_rpl_no, content, reg_no, time,reply_condition) "
				+ "VALUES ((SELECT NVL(MAX(rpl_no), 0) FROM reply) + 1, ?, ?, ?, ?, SYSDATE,0)";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, showPostNo);
			pstmt.setInt(2, up_rpl_no);
			pstmt.setString(3, upload_text);
			pstmt.setInt(4, reg_no);
			pstmt.executeUpdate();
			
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void deleteReply(int rpl_no) throws Exception {

			String sql = "UPDATE reply SET reply_condition=1 WHERE rpl_no=?";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, rpl_no);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void saveReply(String uploadText, int showPostNo, int reg_no) throws Exception {
		String sql = "INSERT INTO reply (rpl_no, post_no, up_rpl_no, content, reg_no, time,reply_condition) "
				+ "VALUES ((SELECT NVL(MAX(rpl_no), 0) FROM reply) + 1, ?, NULL, ?, ?, SYSDATE,0)";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, showPostNo);
			pstmt.setString(2, uploadText);
			pstmt.setInt(3, reg_no);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateReply(int rpl_no, String updateComment) throws Exception {

			String sql = "UPDATE reply SET content=? WHERE rpl_no=?";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, updateComment);
			pstmt.setInt(2, rpl_no);
			pstmt.executeUpdate();
			
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}