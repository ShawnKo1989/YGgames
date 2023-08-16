package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeSeatDAO;
@SuppressWarnings("serial")
@WebServlet("/UpdateCafeUser")
public class UpdateCafeUser extends HttpServlet {
	static String dbid = "projectDB";
	static String dbpw = "pass1234";
	static String driver = "oracle.jdbc.driver.OracleDriver";
	static String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int feeValue = Integer.parseInt(request.getParameter("feeValue"));
		int reg_no = Integer.parseInt(request.getParameter("reg_no"));
		int seatNum = Integer.parseInt(request.getParameter("seatNum"));
		CafeSeatDAO cafeDao = CafeSeatDAO.getInstance();
		try {
			cafeDao.updateCafeSeats(reg_no,seatNum,feeValue);
			response.setStatus(HttpServletResponse.SC_OK);
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			e.printStackTrace();
		}
	}

	
}
