package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.PostDAO;
@SuppressWarnings("serial")
@WebServlet("/updateLikeCntPlus")
public class UpdateLikeCntPlusServlet extends HttpServlet {
	static String dbid = "projectDB";
	static String dbpw = "pass1234";
	static String driver = "oracle.jdbc.driver.OracleDriver";
	static String url = "jdbc:oracle:thin:@localhost:1521:xe";

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int showPostNo = Integer.parseInt(request.getParameter("showPostNo"));
		PostDAO poDao = PostDAO.getInstance();
		try {
			poDao.updateLikeCntPlus(showPostNo);
			response.setStatus(HttpServletResponse.SC_OK);
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
	}

	
}
