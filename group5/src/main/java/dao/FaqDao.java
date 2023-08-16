package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.FaqDetailDto;
import dto.FaqDto;
import sql.DB;

public class FaqDao {
	private static FaqDao instance = new FaqDao();
	private FaqDao() {}
	public static FaqDao getInstance() {
		return instance;
	}
	
	public FaqDto getFaqDto(int fno) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String sql = "SELECT * FROM faq_detail WHERE fno=? ORDER BY c_idx ASC";
		PreparedStatement pstmt = db.getPstmt(conn, sql);

		String sql2 = "SELECT * FROM faq WHERE faq_no=?";
		PreparedStatement pstmt2 = db.getPstmt(conn, sql2);
		
		String sql3 = "SELECT * FROM number_manage WHERE faq_cat_no=?";
		PreparedStatement pstmt3 = db.getPstmt(conn, sql3);

		try {
			pstmt.setInt(1, fno);
			pstmt2.setInt(1, fno);
		} catch (Exception e) {
			e.printStackTrace();
		}

		ResultSet rs = db.getRs(pstmt);
		ResultSet rs2 = db.getRs(pstmt2);

		FaqDto fDto = null;
		ArrayList<FaqDetailDto> detail = new ArrayList<FaqDetailDto>();
		try {
			while (rs.next()) {
				String content = rs.getString("content");
				int cIdx = rs.getInt("c_idx");
				String tag = rs.getString("tag");
				FaqDetailDto fCont = new FaqDetailDto(content, cIdx, tag);
				detail.add(fCont);
			}
			if (rs2.next()) {
				String title = rs2.getString("title");
				int category = rs2.getInt("faq_cat_no");
				String subdivision = rs2.getString("subdivision");
				pstmt3.setInt(1, category);
				ResultSet rs3 = db.getRs(pstmt3);
				if(rs3.next()) {
					fDto = new FaqDto(fno, title, category, rs3.getString("faq_cat_name"), subdivision, detail);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		db.close(rs);
		db.close(rs2);
		db.close(pstmt);
		db.close(pstmt2);
		db.close(conn);

		return fDto;
	}

	public ArrayList<FaqDto> getFaqList(int cno, String word, int pno, int isTotal) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String sql = "";
		PreparedStatement pstmt = null;
		if(isTotal!=1) {
			sql = cno == 0 ? "SELECT * FROM faq WHERE title LIKE ? ORDER BY faq_no ASC"
					: "SELECT * FROM faq WHERE faq_cat_no=? AND title LIKE ? ORDER BY faq_no ASC";
			sql = "SELECT b2.* FROM (SELECT rownum rnum, b1.* FROM ( " + sql + " ) b1) b2 WHERE b2.rnum>=? AND b2.rnum<=?";
			pstmt = db.getPstmt(conn, sql);
			try {
				pstmt.setInt(1, cno);
				pstmt.setString(2, word);
				pstmt.setInt(3, pno*10 - 9);
				pstmt.setInt(4, pno*10);
			} catch (Exception e) {
				try {
					pstmt.setString(1, word);
					pstmt.setInt(2, pno*10 - 9);
					pstmt.setInt(3, pno*10);
				} catch (Exception e1) {
					e.printStackTrace();
				}
			}
		} else {
			sql = "SELECT b2.* "
					+ " FROM (SELECT rownum rnum, b1.* "
						+ " FROM (SELECT * FROM faq "
						+ " ORDER BY faq_no ASC) b1"
					+ " ) b2 "
				+ " WHERE b2.rnum>=? AND b2.rnum<=?";
			pstmt = db.getPstmt(conn, sql);
			try {
				pstmt.setInt(1, pno*10 - 9);
				pstmt.setInt(2, pno*10);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		

		ResultSet rs = db.getRs(pstmt);

		ArrayList<FaqDto> fList = new ArrayList<FaqDto>();
		try {
			while (rs.next()) {
				int fno = rs.getInt("faq_no");
				fList.add(getFaqDto(fno));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fList;
	}
	public int cntSearchRs(int cno, String word, int isTotal) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();
		
		int r = 0;

		String sql = "";
		PreparedStatement pstmt = null;
		if(isTotal!=1) {
			sql = cno == 0 ? "SELECT count(*) FROM faq WHERE title LIKE ? "
					: "SELECT count(*) FROM faq WHERE faq_cat_no=? AND title LIKE ? ";
			pstmt = db.getPstmt(conn, sql);
			if(cno==0) {
				try {
					pstmt.setString(1, word);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			} else {
				try {
					pstmt.setInt(1, cno);
					pstmt.setString(2, word);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else {
			sql = "SELECT count(*) FROM faq";
			pstmt = db.getPstmt(conn, sql);
		}
		ResultSet rs = db.getRs(pstmt);
		try {
			if(rs.next()) {
				r = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		db.close(rs);
		db.close(pstmt);
		db.close(conn);
		
		return r;
	}
}
