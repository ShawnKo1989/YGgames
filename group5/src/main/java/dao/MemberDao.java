package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.MemberDto;
import sql.DB;

public class MemberDao {
	private static MemberDao instance = new MemberDao();
	private MemberDao() {}
	public static MemberDao getInstance() {
		return instance;
	}
	
	public MemberDto getMemberDto(String email) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();
		
		String sql = "SELECT * FROM member WHERE email=?";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setString(1, email);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		MemberDto dto = null;
		ResultSet rs = db.getRs(pstmt);
		try {
			if(rs.next()) {
				int rno = rs.getInt("reg_no");
				String pw = rs.getString("pw");
				String nickname = rs.getString("nickname");
				int type = rs.getInt("user_type");
				String name = rs.getString("name");
				int gender = rs.getInt("gender");
				String phone = rs.getString("phone");
				String birth = rs.getString("birth");
				String address = rs.getString("address");
				int valid = rs.getInt("valid");
				dto = new MemberDto(rno, email, pw, nickname, type, name, gender, phone, birth, address, valid);			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		db.close(pstmt);
		db.close(conn);
		
		return dto;
	}
	public int insertMember(MemberDto dto) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();
		
		String sql = "INSERT INTO member(reg_no, email, pw, nickname, name, gender, phone, birth, address) "
				+ "VALUES (seq_reg.NEXTVAL, ?,?,?,?,?,?,?,?)";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setString(1, dto.getEmail());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getName());
			pstmt.setInt(5, dto.getGender());
			pstmt.setString(6, dto.getPhone());
			pstmt.setString(7, dto.getBirth());
			pstmt.setString(8, dto.getAddress());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		int r = 0;
		try {
			r = db.runStmt(pstmt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		db.close(pstmt);
		db.close(conn);
		
		return r;
	}
}
