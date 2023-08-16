package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.CafeDTO;


public class CafeDAO{
private Connection conn;
	
	private CafeDAO() {
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
			String dbid = "group5";
			String dbpw = "abcd1234";
			
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbid, dbpw);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private static CafeDAO instance = new CafeDAO();
	public static CafeDAO getInstance() {
		return instance;
	}

	public ArrayList<CafeDTO> getKakoCafe(int pageNum, String pointVal, String passVal, String payVal, String eventVal) {
		ArrayList<CafeDTO> cafeList = new ArrayList<CafeDTO>();
		int startNum = pageNum*40-39;
		int endNum = pageNum*40;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT rownum, cl2.*,(SELECT count(*) FROM pccafelist WHERE point like ?"
				+" AND pass LIKE ?"
				+" AND pay LIKE ? AND event LIKE ?) AS totalnum"
				+" FROM(SELECT rownum rnum,cl1.*"
				+" FROM(SELECT *FROM pccafelist WHERE point LIKE ?"
				+" AND pass LIKE ?"
				+" AND pay LIKE ? AND event LIKE ? ORDER BY cafename)cl1)cl2"
				+" WHERE rnum >= ? AND rnum <= ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1,pointVal);
			pstmt.setString(2,passVal);
			pstmt.setString(3,payVal);
			pstmt.setString(4,eventVal);
			pstmt.setString(5,pointVal);
			pstmt.setString(6,passVal);
			pstmt.setString(7,payVal);
			pstmt.setString(8,eventVal);
			pstmt.setInt(9,startNum);
			pstmt.setInt(10,endNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int cno = rs.getInt("cno");
				String cafeName = rs.getString("cafename");
				String point = rs.getString("point");
				String pass = rs.getString("pass");
				String pay = rs.getString("pay");
				String event = rs.getString("event");
				String city = rs.getString("city");
				String region = rs.getString("region");
				String address = rs.getString("address");
				int totalnum = rs.getInt("totalnum");
				
				cafeList.add(new CafeDTO(cno,cafeName, point, pass, pay,
						event, city, region, address, totalnum));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return cafeList; 
	}
	public ArrayList<CafeDTO> getGoogleCafe(int pageNum, String pointVal, String passVal, String payVal, String eventVal) {
		ArrayList<CafeDTO> cafeList = new ArrayList<CafeDTO>();
		int startNum = pageNum*15-14;
		int endNum = pageNum*15;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT rownum, cl2.*,(SELECT count(*) FROM pccafelist WHERE point like ?"
				+" AND pass LIKE ?"
				+" AND pay LIKE ? AND event LIKE ?) AS totalnum"
				+" FROM(SELECT rownum rnum,cl1.*"
				+" FROM(SELECT *FROM pccafelist WHERE point LIKE ?"
				+" AND pass LIKE ?"
				+" AND pay LIKE ? AND event LIKE ? ORDER BY cafename)cl1)cl2"
				+" WHERE rnum >= ? AND rnum <= ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1,"%"+pointVal+"%");
			pstmt.setString(2,"%"+passVal+"%");
			pstmt.setString(3,"%"+payVal+"%");
			pstmt.setString(4,"%"+eventVal+"%");
			pstmt.setString(5,"%"+pointVal+"%");
			pstmt.setString(6,"%"+passVal+"%");
			pstmt.setString(7,"%"+payVal+"%");
			pstmt.setString(8,"%"+eventVal+"%");
			pstmt.setInt(9,startNum);
			pstmt.setInt(10,endNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int cno = rs.getInt("cno");
				String cafeName = rs.getString("cafename");
				String point = rs.getString("point");
				String pass = rs.getString("pass");
				String pay = rs.getString("pay");
				String event = rs.getString("event");
				String city = rs.getString("city");
				String region = rs.getString("region");
				String address = rs.getString("address");
				int totalnum = rs.getInt("totalnum");
				
				cafeList.add(new CafeDTO(cno,cafeName, point, pass, pay,
						event, city, region, address, totalnum));
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return cafeList; 
	}
}
