package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PayMentDAO;

public class PaymentAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PayMentDAO paymentDao = PayMentDAO.getInstance();
		try {
			String remainSeat = paymentDao.remainCafeSeats();
			String totalSeat = paymentDao.totalCafeSeats();
			int[] yesFee = paymentDao.totalFee(1);
			int[] secFee = paymentDao.totalFee(2);
			int[] tirFee = paymentDao.totalFee(3); 
			int fFee = paymentDao.totalFee4();
			int[] feeArr = paymentDao.todayTotalFee();
			
			request.setAttribute("remainSeat", remainSeat);
		    request.setAttribute("totalSeat", totalSeat);
		    request.setAttribute("yesFee", yesFee);
		    request.setAttribute("secFee", secFee);
		    request.setAttribute("tirFee", tirFee);
		    request.setAttribute("fFee", fFee);
		    request.setAttribute("feeArr", feeArr);
		} catch(Exception e) {
			e.printStackTrace();
		}
		String today = paymentDao.today();
		String yesterday = paymentDao.whatDay(1);
		String day2 = paymentDao.whatDay(2);
		String day3 = paymentDao.whatDay(3);
		request.setAttribute("today", today);
		request.setAttribute("yesterday", yesterday);
		request.setAttribute("day2", day2);
		request.setAttribute("day3", day3);
		
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/incomepage/PayMent.jsp");
		rd.forward(request, response);
		
	}
	
}
