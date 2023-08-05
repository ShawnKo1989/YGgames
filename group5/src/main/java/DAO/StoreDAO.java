package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import DTO.AdvertiseDTO;
import DTO.BestsellerDTO;
import DTO.DiscountDTO;
import DTO.DisplayDTO;
import DTO.FlowgamesDTO;
import DTO.FreegamesDTO;
import DTO.MostplayDTO;
import DTO.MostpopDTO;
import DTO.RecentupdateDTO;
import DTO.RewardgameDTO;
import DTO.WishgameDTO;

public class StoreDAO {
	private Connection conn;
	
	private StoreDAO() {
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbId = "temp";
			String dbPw = "1234";
			
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbId, dbPw);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private static StoreDAO instance = new StoreDAO();
	
	public static StoreDAO getInstance() {
		return instance;
	}
	
	public ArrayList<DisplayDTO> getDisplaygames(ArrayList<DisplayDTO> dpList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT title_icon, simple_text," + " dis_offer, displayed_img, TO_CHAR(nvl(ori_prc,-1), 'FM999,999,999,999') as ori_prc"
				+ " FROM game_list g,displayed_games dp" + " WHERE g.g_no = dp.g_no" + " ORDER BY buy_cnt DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title_icon = rs.getString("title_icon");
				String simple_text = rs.getString("simple_text");
				String dis_offer = rs.getString("dis_offer");
				String displayed_img = rs.getString("displayed_img");
				String ori_prc = rs.getString("ori_prc");
				dpList.add(new DisplayDTO(title_icon, simple_text, dis_offer, displayed_img, ori_prc));
				
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
		return dpList;
		
	}
	
	public ArrayList<FlowgamesDTO> getFlowgames(ArrayList<FlowgamesDTO> fgList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT g.title, g.thumnail_img" + " FROM game_list g, displayed_games dp"
				+ " WHERE g.g_no= dp.g_no" + " ORDER BY dp.g_no DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String thumnail_img = rs.getString("thumnail_img");
				fgList.add(new FlowgamesDTO(title, thumnail_img));
				
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
		return fgList;
		
	}
	
	public ArrayList<DiscountDTO> getDiscountgames(ArrayList<DiscountDTO> dcList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT" + " title, TO_CHAR(ori_prc, 'FM999,999,999,999') AS ori_prc, dc_rate,"
				+ " TO_CHAR(ori_prc*(1+dc_rate), 'FM999,999,999,999') AS dc_prc,thumnail_img" + "	FROM game_list"
				+ " WHERE dc_rate IS NOT NULL" + " AND dc_rate != 0" + " ORDER BY wish_cnt DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String ori_prc = rs.getString("ori_prc");
				double dc_rate = rs.getDouble("dc_rate");
				String dc_prc = rs.getString("dc_prc");
				String thumnail_img = rs.getString("thumnail_img");
				dcList.add(new DiscountDTO(title, ori_prc, dc_rate, dc_prc, thumnail_img));
				
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
		return dcList;
	}
	public ArrayList<AdvertiseDTO> getAdvertise(ArrayList<AdvertiseDTO> adList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT title, media_url, TO_CHAR(ori_prc, 'FM999,999,999,999') AS ori_prc, TO_CHAR(ori_prc*(1+nvl(dc_rate,0)), 'FM999,999,999,999') AS dc_prc,nvl(dc_rate,0) AS dc_rate"
				+ " FROM game_list g, game_container gc" + " WHERE g.g_no = gc.g_no" + " AND media_no =1"
				+ " AND media_type=1";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String media_url = rs.getString("media_url");
				String ori_prc = rs.getString("ori_prc");
				double dc_rate = rs.getDouble("dc_rate");
				String dc_prc = rs.getString("dc_prc");
				adList.add(new AdvertiseDTO(title, media_url, ori_prc, dc_rate, dc_prc));
				
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
		return adList;
		
	}
	public ArrayList<FreegamesDTO> getFreegames(ArrayList<FreegamesDTO> freeList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT title, media_url, TO_CHAR(ori_prc, 'FM999,999,999,999') AS ori_prc"
				+ " FROM game_list g, game_container gc" + " WHERE ori_prc = 0" + " AND g.g_no = gc.g_no"
				+ " AND gc.media_type = 1" + " AND gc.media_no = 1" + " ORDER BY wish_cnt DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String media_url = rs.getString("media_url");
				String ori_prc = rs.getString("ori_prc");
				freeList.add(new FreegamesDTO(title, media_url, ori_prc));
				
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
		return freeList;
		
	}
	public ArrayList<BestsellerDTO> getBestsellergames(ArrayList<BestsellerDTO> bsList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT thumnail_img, title,TO_CHAR(nvl(ori_prc,-1), 'FM999,999,999,999') AS ori_prc,"
				+ " nvl(dc_rate,0) AS dc_rate,TO_CHAR(ori_prc*(1+nvl(dc_rate,0)), 'FM999,999,999,999') AS dc_prc"
				+ " FROM game_list" + " ORDER BY buy_cnt DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String thumnail_img = rs.getString("thumnail_img");
				String ori_prc = rs.getString("ori_prc");
				double dc_rate = rs.getDouble("dc_rate");
				String dc_prc = rs.getString("dc_prc");
				bsList.add(new BestsellerDTO(title, thumnail_img, ori_prc, dc_rate, dc_prc));
				
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
		return bsList;
		
	}
	
	public ArrayList<MostplayDTO> getMostplaygames(ArrayList<MostplayDTO> mpList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT title, thumnail_img, TO_CHAR(nvl(ori_prc,-1), 'FM999,999,999,999') AS ori_prc,"
				+ " nvl(dc_rate,0) AS dc_rate,TO_CHAR(ori_prc*(1+nvl(dc_rate,0)), 'FM999,999,999,999') AS dc_prc"
				+ " FROM game_list" + " ORDER BY nvl(ori_prc,-1) DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String thumnail_img = rs.getString("thumnail_img");
				String ori_prc = rs.getString("ori_prc");
				double dc_rate = rs.getDouble("dc_rate");
				String dc_prc = rs.getString("dc_prc");
				mpList.add(new MostplayDTO(title, thumnail_img, ori_prc, dc_rate, dc_prc));
				
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
		return mpList;
		
	}
	
	public ArrayList<WishgameDTO> getWishgames(ArrayList<WishgameDTO> wgList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT title, to_char(to_date(available,'yy.mm.dd')), thumnail_img, TO_CHAR(nvl(ori_prc,-1), 'FM999,999,999,999') AS ori_prc"
				+ " FROM game_list g, comming_soon cs" + " WHERE nvl(ori_prc,-1) = -1" + " AND g.g_no = cs.g_no"
				+ " ORDER BY wish_cnt DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String ori_prc = rs.getString("ori_prc");
				String thumnail_img = rs.getString("thumnail_img");
				String available = rs.getString("to_char(to_date(available,'yy.mm.dd'))");
				wgList.add(new WishgameDTO(title, ori_prc, thumnail_img, available));
				
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
		return wgList;
	}
	
	public ArrayList<MostpopDTO> getMostpopgames(ArrayList<MostpopDTO> popList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT buy_cnt, star_rate,TO_CHAR(ori_prc*(1+nvl(dc_rate,0)), 'FM999,999,999,999') AS dc_prc," + 
				" title, TO_CHAR(nvl(ori_prc,-1), 'FM999,999,999,999') AS ori_prc, nvl(dc_rate,0) AS dc_rate, thumnail_img" + 
				" FROM game_list g, game_publishing gp" + 
				" WHERE g.g_no = gp.g_no" + 
				" ORDER BY buy_cnt DESC, star_rate DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String ori_prc = rs.getString("ori_prc");
				int dc_rate = rs.getInt("dc_rate");
				String thumnail_img = rs.getString("thumnail_img");
				String dc_prc = rs.getString("dc_prc");
				popList.add(new MostpopDTO(title, ori_prc, dc_rate, thumnail_img, dc_prc));
				
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
		return popList;
	}
	
	public ArrayList<RewardgameDTO> getRewardgames(ArrayList<RewardgameDTO> rewardList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT DISTINCT title, TO_CHAR(nvl(ori_prc,-1), 'FM999,999,999,999') AS ori_prc, dc_rate, thumnail_img"
				+ " FROM game_list g, reward r" + " WHERE g.g_no = r.g_no";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String ori_prc = rs.getString("ori_prc");
				int dc_rate = rs.getInt("dc_rate");
				String thumnail_img = rs.getString("thumnail_img");
				rewardList.add(new RewardgameDTO(title, ori_prc, dc_rate, thumnail_img));
				
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
		return rewardList;
	}
	
	public ArrayList<RecentupdateDTO> getRecentupdate(ArrayList<RecentupdateDTO> recentList){
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT title,"
				+ " TO_CHAR(nvl(ori_prc,-1), 'FM999,999,999,999') AS ori_prc, dc_rate, thumnail_img"
				+ " FROM game_list" + " WHERE update_date > sysdate-300" + " ORDER BY update_date DESC";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String title = rs.getString("title");
				String ori_prc = rs.getString("ori_prc");
				int dc_rate = rs.getInt("dc_rate");
				String thumnail_img = rs.getString("thumnail_img");
				recentList.add(new RecentupdateDTO(title, ori_prc, dc_rate, thumnail_img));
				
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
		return recentList;
	}
}
