package action;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CafeSeatDAO;
import dto.CafeSeatDTO;

public class PcCafeAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
	CafeSeatDAO cafeSeatDao = CafeSeatDAO.getInstance();
	try {
		List<CafeSeatDTO> seatArr = cafeSeatDao.totalCafeSeats();
		int[] loginMember = cafeSeatDao.loginMember();
		int[] reserveId = cafeSeatDao.loginSeats();
		String[] startTime = cafeSeatDao.startDate();
		String[] endTime = cafeSeatDao.endDate();
		int[] totalFee = cafeSeatDao.fee();
		request.setAttribute("seatArr",seatArr);
		request.setAttribute("loginMember", loginMember);
		request.setAttribute("reserveId", reserveId);
		request.setAttribute("startTime", startTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("tileFee", totalFee);
		RequestDispatcher rd = request.getRequestDispatcher("/cafeseatpage/CafeSeatsTileArray.jsp");
		rd.forward(request, response);
	} catch (Exception e) {
		e.printStackTrace();
	} 
		
	}
}
