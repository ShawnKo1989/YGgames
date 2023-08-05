package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CafeReservePayAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
		int seatNumber = Integer.parseInt(request.getParameter("seatNumber"));
			
		request.setAttribute("seatNumber", seatNumber);
		
		RequestDispatcher rd = request.getRequestDispatcher("CafeSeatsReservePay.jsp");
		rd.forward(request, response);
		
	}

}
