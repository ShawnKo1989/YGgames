package jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String Driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
			String dbid = "group5";
			String dbPassword = "1234";
			Class.forName(Driver);
			conn = DriverManager.getConnection(url, dbid, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String email, String pw) {
		String SQL = "SELECT pw FROM member WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				if (rs.getString(1).equals(pw)) {
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀번호 불일치
				}
			}
			rs.close();
			pstmt.close();
			conn.close();
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO member VALUES (reg_no_seq.NEXTVAL, ?, ?, ?, 0, ?, ?, ?, ?, ?, 0)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getEmail());
			pstmt.setString(2, user.getPw());
			pstmt.setString(3, user.getNickname());
			pstmt.setString(4, user.getName());
			pstmt.setInt(5, user.getGender());
			pstmt.setString(6, user.getPhone());
			pstmt.setString(7, user.getBirth());
			pstmt.setString(8, user.getAddress());
			int rt = pstmt.executeUpdate();
			pstmt.close();
			conn.close();
			return rt;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public String getTitle(int reg_no) {
		String title = "";
		try {
			String sql = "SELECT * FROM my_room WHERE reg_no = " + reg_no;
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				title = rs.getString("now_style");
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return title;
	}
}
