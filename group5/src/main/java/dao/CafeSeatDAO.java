package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.CafeSeatDTO;

public class CafeSeatDAO {
	private static Connection conn;
	private String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
	private String dbid = "group5";
	private String dbpw = "abcd1234";
	
	private CafeSeatDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url, dbid, dbpw);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
	
	private static CafeSeatDAO instance = new CafeSeatDAO();
	
	public static CafeSeatDAO getInstance() {
		return instance;
	}
	
	public static void closeConnection() {
		try {
			if (conn != null && !conn.isClosed()) {
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void endTimeCafeSeat(int seatNum) throws Exception {
			
			String sql= "UPDATE cafe_seats SET reg_no=null, condition=0,start_time=null,end_time=null,total_fee=0 WHERE seat_no=?";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1,seatNum);
			pstmt.executeUpdate();
		} catch (SQLException e) {
				e.printStackTrace();
		}
	}
	
	public ArrayList<CafeSeatDTO> totalCafeSeats() throws Exception {
		ArrayList<CafeSeatDTO> conditionLi = new ArrayList<>();
		String sql = "SELECT condition FROM cafe_seats WHERE cafe_no=3108 ORDER BY seat_no";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
		ResultSet rs = pstmt.executeQuery();
		while (rs.next()) {
			CafeSeatDTO caSeat = new CafeSeatDTO();
			caSeat.setCondition(rs.getInt("condition"));
			conditionLi.add(caSeat);
		}
		rs.close();
		pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conditionLi;
	}
	
	public int[] loginSeats() throws Exception {
		String sql = "SELECT reg_no FROM cafe_seats WHERE cafe_no=3108 ORDER BY seat_no";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<Integer> seatID = new ArrayList<>();
		while (rs.next()) {
			int seatReserveId = rs.getInt("reg_no");
			seatID.add(seatReserveId);
		}
		int[] seatReserveID = new int[seatID.size()];
		for(int j=0;j < seatID.size(); j++) {
			seatReserveID[j]=seatID.get(j);
		}
		rs.close();
		pstmt.close();
		
		return seatReserveID;
	}
	

	public String nickname(int regNo) throws Exception {
		String sql = "SELECT nickname FROM member WHERE reg_no = ?";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, regNo);
		ResultSet rs = pstmt.executeQuery();
		String nickname="";
		while (rs.next()) {
			nickname = rs.getString("nickname");
		}
		rs.close();
		pstmt.close();
		
		return nickname;
	}
	public String[] startDate() throws Exception{
		String sql = "SELECT TO_CHAR(start_time,'HH24:MI') start_time FROM cafe_seats ORDER BY seat_no";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		List<String> start = new ArrayList<>();
		while (rs.next()) {
			String start_time = rs.getString("start_time");
			start.add(start_time);
		}
		String[] start_time = start.toArray(new String[0]);
		rs.close();
		pstmt.close();
		
		return start_time;
	}
	
	
	public String[] endDate() throws Exception{
		String sql = "SELECT TO_CHAR(end_time,'HH24:MI') end_time FROM cafe_seats ORDER BY seat_no";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		List<String> end = new ArrayList<>();
		while (rs.next()) {
			String end_time = rs.getString("end_time");
			end.add(end_time);
		}
		String[] end_time = end.toArray(new String[0]);
		rs.close();
		pstmt.close();
		
		return end_time;
	}
	public int[] fee() throws Exception{
		String sql = "SELECT total_fee FROM cafe_seats ORDER BY seat_no";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<Integer> fee = new ArrayList<>();
		while (rs.next()) {
			int total_fee = rs.getInt("total_fee");
			fee.add(total_fee);
		}
		int[] total_Fee = new int[fee.size()];
		for(int j=0;j < fee.size(); j++) {
			total_Fee[j]=fee.get(j);
		}
		rs.close();
		pstmt.close();
		
		return total_Fee;
	}
	public int[] loginMember() throws Exception{
		String sql = "SELECT reg_no FROM cafe_seats WHERE reg_no IS NOT NULL";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		ArrayList<Integer> login_reg = new ArrayList<>();
		while (rs.next()) {
			int member = rs.getInt("reg_no");
			login_reg.add(member);
		}
		int[] login_member = new int[login_reg.size()];
		for(int j=0;j < login_reg.size(); j++) {
			login_member[j]=login_reg.get(j);
		}
		rs.close();
		pstmt.close();
		
		return login_member;
	}
	
	public void updateCafeSeats(int reg_no, int seatNum,int feeValue) throws Exception {
			
			String sql= "UPDATE cafe_seats SET reg_no=?, condition=1,start_time=sysdate,end_time=sysdate+ ?/24/60,total_fee=? WHERE seat_no=?";
			try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, reg_no);
			pstmt.setInt(2, feeValue/1000);
			pstmt.setInt(3, feeValue);
			pstmt.setInt(4,seatNum);
			pstmt.executeUpdate();
			
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}
	
}
