package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ReplyDAO;

@SuppressWarnings("serial")
@WebServlet("/ChildReplySaveServlet")
public class ChildReplySaveServlet extends HttpServlet {
	static String dbid = "projectDB";
	static String dbpw = "pass1234";
	static String driver = "oracle.jdbc.driver.OracleDriver";
	static String url = "jdbc:oracle:thin:@localhost:1521:xe";
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String upload_text = request.getParameter("writeReply");
		int reg_no = Integer.parseInt(request.getParameter("reg_no"));
		int showPostNo = Integer.parseInt(request.getParameter("showPostNo"));
		int up_rpl_no=Integer.parseInt(request.getParameter("up_rpl_no"));
		ReplyDAO reDao = ReplyDAO.getInstance();
		try {
			reDao.saveReply(upload_text, showPostNo, reg_no,up_rpl_no);
			response.setStatus(HttpServletResponse.SC_OK);
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
	}
}
