package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ReplyDAO;

@SuppressWarnings("serial")
@WebServlet("/DeleteReplyServlet")
public class DeleteReplyServlet extends HttpServlet {
	static String dbid = "projectDB";
	static String dbpw = "pass1234";
	static String driver = "oracle.jdbc.driver.OracleDriver";
	static String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		int rpl_no = Integer.parseInt(request.getParameter("rpl_no"));
		ReplyDAO reDao = ReplyDAO.getInstance();
		try {
			reDao.deleteReply(rpl_no);
			response.setStatus(HttpServletResponse.SC_OK);
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
	}


}
