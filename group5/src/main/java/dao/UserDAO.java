package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServletRequest;

import dto.MemberDto;
import dto.UserDTO;

public class UserDAO {

	private Connection conn;
	
	public UserDAO() {
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
			String dbid = "group5";
			String dbpw = "abcd1234";
			
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
			
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	private static UserDAO instance = new UserDAO();

	public static UserDAO getInstance() {
		return instance;
	}
	
	public int registerCheck(String userEmail) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		System.out.println("RegisterCheckDAO is working!!");
		String sql = "SELECT * FROM member WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				return 0; // 이미 존재하는 회원입니다.
			}else {
				return 1; // 가입 가능한 아이디 입니다.
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		return -1; // 오류 발생시 출력 ( 데이터베이스 오류)
	}
	public int passwordCheck(String userEmail, String userPw, HttpServletRequest request) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		UserDTO user = new UserDTO();
		
		String sql = "SELECT * FROM member WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int rNo = rs.getInt("reg_no");
				String pw = rs.getString("pw");
				String userNickname = rs.getString("nickname");
				String userName = rs.getString("name");
				int valid = rs.getInt("valid");
				int userType = rs.getInt("user_type");
				if(valid == 1) {
					return -2;
				}
				if(pw.equals(userPw)) {
						request.getSession().setAttribute("reg_no", rNo);
						request.getSession().setAttribute("userEmail", userEmail);
						request.getSession().setAttribute("userPw", pw);
						request.getSession().setAttribute("userNickname", userNickname);
						request.getSession().setAttribute("userName", userName);
						request.getSession().setAttribute("userType", userType);
						
						request.getSession().setAttribute("isLogin", true);
			            MemberDto mDto = new MemberDto(rNo, userEmail, userPw, userNickname, userType, userName, rs.getInt("gender"), rs.getString("phone"), rs.getString("birth"), rs.getString("address"), valid);
			            request.getSession().setAttribute("dto", mDto);
						return 0; //비밀번호가 일치할경우
				}else {
					return 1; //일치하지않을경우 
				}
			}
			
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 오류 발생시 출력 ( 데이터베이스 오류)
	}
	public int userConnectivity(int reg_no) {
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE member"
				+ " SET connecting = 1"
				+ " WHERE reg_no = ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, reg_no);
			pstmt.executeUpdate();
			return 0; // 성공적으로 수정되었슴.
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 오류 발생시 출력되는 숫자.
	}
	public int register(String userEmail, String userpw, String nickName, String userName) {
		PreparedStatement pstmt = null;
		
		String sql = "INSERT INTO member"
				+" (reg_no, email, pw, nickname, user_type, name," 
				+" gender, phone, birth,address, postal_code, valid, connecting)" 
				+" VALUES (seq_reg.nextval,?,?,?,0,?,null,null,null,null,null,null,0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			pstmt.setString(2, userpw);
			pstmt.setString(3, nickName);
			pstmt.setString(4, userName);
			pstmt.executeUpdate();
			
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close();}
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		return -1; // 오류 발생시 출력 ( 데이터베이스 오류)
	}
	public void updateUserInfo(String userName, String userNickname, String userEmail, String userPw) {
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO member"
				+" (reg_no, email, pw, nickname, user_type, name," 
				+" gender, phone, birth,address, postal_code, valid, connecting)" 
				+" VALUES (seq_reg.nextval,?,?,?,0,?,null,null,null,null,null,null,0)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userEmail);
			pstmt.setString(2, userPw);
			pstmt.setString(3, userNickname);
			pstmt.setString(4, userName);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {pstmt.close();}
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
