package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import dto.PostDTO;

public class PostDAO {
	private Connection conn;
	private String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
	private String dbid = "group5";
	private String dbpw = "abcd1234";

	private PostDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static PostDAO instance = new PostDAO();
	
	public static PostDAO getInstance() {
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

	

	public ArrayList<PostDTO> getPostList(int boardNo, int pageNo, int postsPerPage) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		ArrayList<PostDTO> postList = new ArrayList<>();
		String sql = "";
		if (boardNo == 0) {
			sql = "SELECT * FROM "
					+ "(SELECT ROWNUM AS rnum, p.post_no, p.title, m.nickname, TO_CHAR(p.upload_date, 'YYYY-MM-DD') AS upload_date, p.view_cnt"
					+ " FROM (SELECT * FROM post ORDER BY post_no DESC) p, member m"
					+ " WHERE p.reg_no = m.reg_no AND ROWNUM <= ? * ?)" + " WHERE rnum > (? - 1) * ?";
		} else {
			sql = "SELECT * FROM "
					+ "(SELECT ROWNUM AS rnum, p.post_no, p.title, m.nickname, TO_CHAR(p.upload_date, 'YYYY-MM-DD') AS upload_date, p.view_cnt"
					+ " FROM (SELECT * FROM post WHERE board_no = ? ORDER BY post_no DESC) p, member m"
					+ " WHERE p.reg_no = m.reg_no AND ROWNUM <= ? * ?)" + " WHERE rnum > (? - 1) * ?";
		}
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			int index = 1;
			if (boardNo != 0) {
				pstmt.setInt(index++, boardNo);
			}
			pstmt.setInt(index++, pageNo);
			pstmt.setInt(index++, postsPerPage);
			pstmt.setInt(index++, pageNo);
			pstmt.setInt(index++, postsPerPage);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				PostDTO post = new PostDTO();
				post.setPostNo(rs.getInt("post_no"));
				post.setTitle(rs.getString("title"));
				post.setNickname(rs.getString("nickname"));
				post.setUploadDate(rs.getString("upload_date"));
				post.setViewCnt(rs.getInt("view_cnt"));
				postList.add(post);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return postList;
	}
	
	public ArrayList<PostDTO> getPostList(int boardNo, int pageNo, int postsPerPage, int reg_no) {
        ArrayList<PostDTO> postList = new ArrayList<>();
        String sql = "SELECT * "
                    + "FROM (SELECT ROWNUM AS rnum, p.post_no, p.title, m.nickname, TO_CHAR(p.upload_date, 'YYYY-MM-DD') AS upload_date, p.view_cnt"
                    + " FROM (SELECT * FROM post ORDER BY post_no DESC) p, member m"
                    + " WHERE p.reg_no = m.reg_no AND ROWNUM <= ? * ? AND m.reg_no = ?)"
                    + " WHERE rnum > (? - 1) * ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, pageNo);
            pstmt.setInt(2, postsPerPage);
            pstmt.setInt(3, reg_no);
            pstmt.setInt(4, pageNo);
            pstmt.setInt(5, postsPerPage);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                PostDTO post = new PostDTO();
                post.setPostNo(rs.getInt("post_no"));
                post.setTitle(rs.getString("title"));
                post.setNickname(rs.getString("nickname"));
                post.setUploadDate(rs.getString("upload_date"));
                post.setViewCnt(rs.getInt("view_cnt"));
                postList.add(post);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postList;
    }

	public int getTotalPosts(int boardNo) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		int totalPosts = 0;
		String sql = "SELECT COUNT(*) as total FROM post";
		if (boardNo != 0) {
			sql += " WHERE board_no = ?";
		}

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			if (boardNo != 0) {
				pstmt.setInt(1, boardNo);
			}
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				totalPosts = rs.getInt("total");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return totalPosts;
	}

	public int getSearchPosts(String searchData) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		int totalPosts = 0;
		String sql = "SELECT COUNT(*) as total FROM post WHERE title LIKE ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, "%" + searchData + "%");
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				totalPosts = rs.getInt("total");
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return totalPosts;
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

	public ArrayList<PostDTO> allPost() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		ArrayList<PostDTO> allPosts = new ArrayList<>();
		String sql = "SELECT * FROM (" + "  SELECT ROWNUM as rnum, post_no, title, nickname, upload_date, view_cnt"
				+ "  FROM ("
				+ "    SELECT p.post_no, p.title, m.nickname, TO_CHAR(p.upload_date, 'YYYY-MM-DD') AS upload_date, p.view_cnt"
				+ "    FROM post p, member m" + "    WHERE p.reg_no = m.reg_no" + "    ORDER BY p.post_no DESC" + "  )"
				+ ") WHERE rnum <= 6";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				PostDTO post = new PostDTO();
				post.setPostNo(rs.getInt("post_no"));
				post.setTitle(rs.getString("title"));
				post.setNickname(rs.getString("nickname"));
				post.setUploadDate(rs.getString("upload_date"));
				post.setViewCnt(rs.getInt("view_cnt"));
				allPosts.add(post);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return allPosts;
	}

	public ArrayList<PostDTO> hotPost() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		int i = 0;
		ArrayList<PostDTO> hotPosts = new ArrayList<>();

		String sql = "SELECT * FROM (" + "  SELECT p.post_no, p.title, m.nickname, p.view_cnt"
				+ "  FROM post p, member m" + "  WHERE p.reg_no = m.reg_no" + "  ORDER BY view_cnt DESC)";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();

			while (rs.next() && i < 6) {
				PostDTO post = new PostDTO();

				post.setPostNo(rs.getInt("post_no"));
				post.setTitle(rs.getString("title"));
				post.setNickname(rs.getString("nickname"));
				post.setViewCnt(rs.getInt("view_cnt"));
				hotPosts.add(post);
				i++;
			}

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return hotPosts;
	}

	public ArrayList<PostDTO> showPost(int postNo) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		ArrayList<PostDTO> searchPost = new ArrayList<>();

		String sql = "SELECT * " + 
				" FROM post p" + 
				" LEFT OUTER JOIN member m" + 
				" ON p.reg_no=m.reg_no" + 
				" LEFT OUTER JOIN board b" + 
				" ON b.board_no=p.board_no" + 
				" WHERE p.post_no=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, postNo);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				PostDTO post = new PostDTO();
				post.setBoardTitle(rs.getString("board_title"));
				post.setTitle(rs.getString("title"));
				post.setNickname(rs.getString("nickname"));
				post.setViewCnt(rs.getInt("view_cnt"));
				post.setUploadDate(rs.getString("upload_date"));
				post.setLikeCnt(rs.getInt("like_cnt"));
				post.setContent(rs.getString("content"));
				searchPost.add(post);
			}

			rs.close();
			String sql2 = "UPDATE post SET view_cnt=view_cnt+1 WHERE post_no=?";
			try (PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {
				pstmt2.setInt(1, postNo);
				pstmt2.executeUpdate();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return searchPost;
	}

	public ArrayList<PostDTO> searchPost(String searchData) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		ArrayList<PostDTO> searchPost = new ArrayList<>();

		String sql = "SELECT p.post_no, p.title, m.nickname, TO_CHAR(p.upload_date,'YYYY-MM-DD') AS upload_date, p.view_cnt"
				+ " FROM post p, member m" + " WHERE p.reg_no=m.reg_no AND p.title LIKE ?" + " ORDER BY p.post_no DESC";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, "%" + searchData + "%");
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				PostDTO post = new PostDTO();
				post.setPostNo(rs.getInt("post_no"));
				post.setTitle(rs.getString("title"));
				post.setNickname(rs.getString("nickname"));
				post.setViewCnt(rs.getInt("view_cnt"));
				post.setUploadDate(rs.getString("upload_date"));
				searchPost.add(post);
			}

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
		return searchPost;
	}
	
	public void deletePost(int post_no) throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		String sql = "DELETE FROM post WHERE post_no=?";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, post_no);
			pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			}	
	}
	
	public void savePost(String board,String title,String content,int reg_no) throws Exception {
		
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		String sql = "SELECT board_no FROM board WHERE board_title=?";
		String sql2 = "INSERT INTO post (post_no, title, reg_no, upload_date,view_cnt,like_cnt,board_no,content) "
					+ "VALUES ((SELECT NVL(MAX(post_no), 0) FROM post) + 1, ?, ?, sysdate, 0, 0, ?,?)";
		
		int board_no=0;
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1,board);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				board_no=rs.getInt("board_no");
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		try (PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {
			pstmt2.setString(1,title);
			pstmt2.setInt(2,reg_no);
			pstmt2.setInt(3, board_no);
			pstmt2.setString(4,content);
			pstmt2.executeUpdate();
		}  catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
	}
	
	public void updatePost(String board,String title,String content,int reg_no,int postNo) throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		String sql = "SELECT board_no FROM board WHERE board_title=?";
		String sql2 = "UPDATE post SET title=?,board_no=?,content=? WHERE post_no=?";
		int board_no=0;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1,""+board);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				board_no=rs.getInt("board_no");
			}
			rs.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		try (PreparedStatement pstmt2 = conn.prepareStatement(sql2)) {
			pstmt2.setString(1,title);
			pstmt2.setInt(2, board_no);
			pstmt2.setString(3,content);
			pstmt2.setInt(4, postNo);
			pstmt2.executeUpdate();
		}  catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
	}
	
	public void updateLikeCntMinus(int showPostNo) throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		String sql = "UPDATE post SET like_cnt=like_cnt-1 WHERE post_no=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, showPostNo);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			closeResources(null, null);
		}
	}
	
	public void updateLikeCntPlus(int showPostNo) throws Exception {

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
			String sql = "UPDATE post SET like_cnt=like_cnt+1 WHERE post_no=?";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, showPostNo);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace(); 
		} finally {
			closeResources(null, null);
		}
	}
	

	
}
