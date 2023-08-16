package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.RsvDto;
import sql.DB;

public class RsvDao {
	private static RsvDao instance = new RsvDao();

	private RsvDao() {
	}

	public static RsvDao getInstance() {
		return instance;
	}

	public int[] cntRsv(String schedule) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String sql = "SELECT * "
				+ "FROM reservation_info "
				+ "WHERE rsv_schedule=to_date(?, 'yyyy-mm-dd hh24:mi:ss')";
		CallableStatement cstmt = db.getCstmt(conn, sql);
		try {
			cstmt.setString(1, schedule);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		ResultSet rs = db.getRs(cstmt);

		int[] supporters = { 0, 0, 0, 0 };
		try {
			while (rs.next()) {
				int sptNo = rs.getInt("employee_id");
				supporters[sptNo - 1] = 1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		db.close(rs);
		db.close(cstmt);
		db.close(conn);

		return supporters;
	}

	public RsvDto getRsvDto(int rsvno) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();

		String sql = " SELECT * "
				+ " FROM reservation_info r "
				+ " LEFT OUTER JOIN number_manage nm "
				+ "        ON r.rsv_type=nm.rsv_type "
				+ " LEFT OUTER JOIN employee e "
				+ "        ON r.employee_id=e.employee_id "
				+ " WHERE r.rsv_no=? ";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setInt(1, rsvno);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		ResultSet rs = db.getRs(pstmt);

		RsvDto dto = null;

		try {
			if (rs.next()) {
				String schedule = rs.getString("rsv_schedule");
				String name = rs.getString("vst_name");
				String phone = rs.getString("phone");
				String email = rs.getString("email");
				String purpose = rs.getString("purpose");
				String type = rs.getString("rsv_type_name");
				int typeNo = rs.getInt("rsv_type");
				String supporter = rs.getString("employee_name");
				int supporterNo = rs.getInt("employee_id");
				dto = new RsvDto(rsvno, name, schedule, type, typeNo, supporter, supporterNo, purpose, phone, email);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		db.close(rs);
		db.close(pstmt);
		db.close(conn);

		return dto;
	}

	public int rsvReg(RsvDto rDto) {
		DB db = DB.getInstance();
		Connection conn = db.getConn();
		
		String sql = "INSERT INTO reservation_info(rsv_no, rsv_schedule, employee_id, rsv_type, vst_name, phone, email, purpose) VALUES (rsvinfo_rsvno_seq.nextval, to_date(?, 'yyyy-mm-dd hh24'), ?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = db.getPstmt(conn, sql);
		try {
			pstmt.setString(1, rDto.getSchedule());
			pstmt.setInt(2, rDto.getSupporterNo());
			pstmt.setInt(3, rDto.getTypeNo());
			pstmt.setString(4, rDto.getName());
			pstmt.setString(5, rDto.getPhone());
			pstmt.setString(6, rDto.getEmail());
			pstmt.setString(7, rDto.getPurpose());
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		db.runStmt(pstmt);
		sql = "SELECT max(rsv_no) FROM reservation_info";
		pstmt = db.getCstmt(conn, sql);
		
		ResultSet rs = db.getRs(pstmt);
		
		int r = 0;
		try {
			if (rs.next()) {
				r = rs.getInt("max(rsv_no)");
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
