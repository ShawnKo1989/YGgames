package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.BoardDTO;
public class BoardDAO {
	private static Connection conn;
	private String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
	private String dbid = "group5";
	private String dbpw = "abcd1234";
	private static BoardDAO instance = new BoardDAO();
	
	private BoardDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	 private Connection getConnection() throws SQLException {
	        return DriverManager.getConnection(url, dbid, dbpw);
    }
	public static BoardDAO getInstance() {
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
	
	public ArrayList<BoardDTO> showBoard(){
		ArrayList<BoardDTO> showBoard = new ArrayList<>();
		
		String sql = "SELECT board_title FROM board";
		
		try (Connection conn = getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				BoardDTO board = new BoardDTO();
				board.setBoardTitle(rs.getString("board_title"));
				showBoard.add(board);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return showBoard;
	}
	
	public String getBoardName(int boardNo) {
		String boardName = "전체";
		String sql = "SELECT board_title FROM board WHERE board_no=?";
		try (Connection conn = getConnection();
	             PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, boardNo);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				boardName = rs.getString("board_title");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return boardName;
	}
	
	public void closeResources(ResultSet rs, PreparedStatement pstmt) {
		
	    try {
	        if (rs != null && !rs.isClosed()) {
	            rs.close();
	        }
	        if (pstmt != null && !pstmt.isClosed()) {
	            pstmt.close();
	        }
	        if (conn != null && !conn.isClosed()) {
	            conn.close();
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	
}
