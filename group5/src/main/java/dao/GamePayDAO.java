package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dto.DisplayDTO;
import dto.GamePayDTO;

public class GamePayDAO {
	private Connection conn;
	
	private GamePayDAO() {
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
	
	private static GamePayDAO instance = new GamePayDAO();
	
	public static GamePayDAO getInstance() {
		return instance;
	}
	public ArrayList<GamePayDTO> getPayInfo(){
		ArrayList<GamePayDTO> gpList = new ArrayList<GamePayDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT gl.thumnail_img, gl.title, gp.publisher, TO_CHAR(gl.ori_prc,'l999,999,999,999') AS ori_prc," + 
				" TO_CHAR(nvl((gl.ori_prc*(-gl.dc_rate)),0),'l999,999,999,999') AS dc_prc," + 
				" TO_CHAR(gl.ori_prc*(1+nvl(gl.dc_rate,0)),'l999,999,999,999') AS total_prc" + 
				" FROM game_list gl, game_publishing gp" + 
				" WHERE gl.g_no = gp.g_no" + 
				" AND gl.g_no = 1011";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String gameImg = rs.getString("thumnail_img");
				String gameTitle = rs.getString("title");
				String publisher = rs.getString("publisher");
				String gameOriPrice = rs.getString("ori_prc");
				String gameDisPrice = rs.getString("dc_prc");
				String totalPrice = rs.getString("total_prc");
				gpList.add(new GamePayDTO(gameImg,gameTitle,publisher,gameOriPrice,gameDisPrice,totalPrice));
				
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
		return gpList;
		
	}
	
}
