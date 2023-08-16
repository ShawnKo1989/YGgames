package dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import dto.ContactAttachmentDto;
import dto.ContactDto;
import sql.DB;

public class ContactDao {
	private static ContactDao instance = new ContactDao();
	private ContactDao() {}
	public static ContactDao getInstance() {
		return instance;
	}
	
	public void insertContact(HttpServletRequest request, Collection<Part> parts) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String description = request.getParameter("description");
		
		String sql = "INSERT INTO contact(cno, name, email, description) VALUES (cont_cno_seq.NEXTVAL, ?, ?, ?)";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setString(3, description);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		int r = db.runStmt(pstmt);

		if (r == 1) {
			String sql1 = "INSERT INTO contact_attachments(file_name, file_content, cno, file_type, fno) VALUES (?, ?, cont_cno_seq.CURRVAL, ?, ca_fno_seq.NEXTVAL)";
			for (Part part : parts) {
				PreparedStatement pstmt1 = db.getPstmt(conn, sql1);
				
				String parameter = part.getName();
				if (!parameter.equals("attachments")) {
					continue;
				}
				String fileName = part.getSubmittedFileName();
				String fileType = part.getContentType();
				InputStream is = null;
				try {
					is = part.getInputStream();
					pstmt1.setString(1, fileName);
					pstmt1.setBinaryStream(2, is);
					pstmt1.setString(3, fileType);
					int r1 = db.runStmt(pstmt1);
					if (r1 != 1) {
						System.out.println("attachment insert fail");
					}
				} catch (IOException | SQLException e) {
					e.printStackTrace();
				}
				db.close(pstmt1);
			}
		} else {
			System.out.println("insert fail");
		}

		db.close(pstmt);
		db.close(conn);
	}

	public ContactDto getContactDto(int cno) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String sql = "SELECT * FROM contact WHERE cno=?";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setInt(1, cno);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		ResultSet rs = db.getRs(pstmt);

		ContactDto cDto = null;
		try {
			if (rs.next()) {
				String name = rs.getString("name");
				String email = rs.getString("email");
				String description = rs.getString("description");
				String regdate = rs.getString("regdate");

				String sql2 = "SELECT * FROM contact_attachments WHERE cno=? ORDER BY fno ASC";
				PreparedStatement pstmt2 = db.getPstmt(conn, sql2);
				pstmt2.setInt(1, cno);

				ResultSet rs2 = db.getRs(pstmt2);
				List<ContactAttachmentDto> attachments = new ArrayList<ContactAttachmentDto>();
				try {
					while (rs2.next()) {
						String fileName = rs2.getString("file_name");
						String fileType = rs2.getString("file_type");
						InputStream is = rs2.getBinaryStream("file_content");
						attachments.add(new ContactAttachmentDto(fileName, fileType, is));
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				cDto = new ContactDto(cno, name, email, description, regdate, attachments);
				db.close(rs2);
				db.close(pstmt2);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		db.close(rs);
		db.close(pstmt);
		db.close(conn);
		
		return cDto;
	}

	public ArrayList<ContactDto> getContactList(String email, int pno) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String sql = "SELECT b2.* "
				+ "FROM ("
					+ "SELECT rownum rno, b1.* "
					+ "FROM (" + "SELECT * "
						+ "FROM contact "
						+ "WHERE email=? "
						+ "ORDER BY cno DESC"
					+ ") b1"
				+ ") b2 "
				+ "WHERE b2.rno > ? AND b2.rno <=?";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setString(1, email);
			pstmt.setInt(2, (pno - 1) * 3);
			pstmt.setInt(3, pno * 3);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		ResultSet rs = db.getRs(pstmt);

		ArrayList<ContactDto> cList = new ArrayList<ContactDto>();
		try {
			while (rs.next()) {
				int cno = rs.getInt("cno");
				cList.add(getContactDto(cno));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		db.close(rs);
		db.close(pstmt);
		db.close(conn);

		return cList;
	}

	public int cntHistory(String email) {
		int r = 0;

		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String sql = "SELECT count(*) FROM contact WHERE email=?";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setString(1, email);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		ResultSet rs = db.getRs(pstmt);

		try {
			if (rs.next()) {
				r = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		db.close(rs);
		db.close(pstmt);
		db.close(conn);

		return r;
	}
}
