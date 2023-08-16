package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PayMentDAO;
import dto.PayMentDTO;

public class PaymentSelectAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		PayMentDAO paymentDao = PayMentDAO.getInstance();
		
		ArrayList<PayMentDTO> payList;
		
		if(request.getParameter("selectedSectionDate")!=null) {
			try {
				payList = paymentDao.sectionDate(request.getParameter("selectedSectionDate"));
				
				request.setAttribute("payList", payList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(request.getParameter("selectedDate")!=null) {
			try {
				payList = paymentDao.selectedDate(request.getParameter("selectedDate"));
				
				request.setAttribute("payList", payList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(request.getParameter("selectedMonth")!=null) {
			try {
				payList = paymentDao.selectedMonth(request.getParameter("selectedMonth"));
				
				request.setAttribute("payList", payList);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try {
			String remainSeat = paymentDao.remainCafeSeats();
			String totalSeat = paymentDao.totalCafeSeats();
			
			request.setAttribute("remainSeat", remainSeat);
		    request.setAttribute("totalSeat", totalSeat);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String today = paymentDao.today();
		
		request.setAttribute("today", today);
		
		RequestDispatcher rd = request.getRequestDispatcher("/incomepage/PayMentSelectDate.jsp");
		rd.forward(request, response);
	}

}
