package action;

import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CafeSeatDAO;
import DTO.CafeSeatDTO;

public class PcCafeAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
	CafeSeatDAO cafeSeatDao = CafeSeatDAO.getInstance();
	try {
		List<CafeSeatDTO> seatArr = cafeSeatDao.totalCafeSeats();
		int[] loginMember = cafeSeatDao.loginMember();
		String[] nickname = cafeSeatDao.nickname();
		int[] reserveId = cafeSeatDao.loginSeats();
		String[] startTime = cafeSeatDao.startDate();
		String[] endTime = cafeSeatDao.endDate();
		int[] totalFee = cafeSeatDao.fee();
		request.setAttribute("seatArr",seatArr);
		request.setAttribute("loginMember", loginMember);
		request.setAttribute("cafeNickname", nickname);
		request.setAttribute("reserveId", reserveId);
		request.setAttribute("startTime", startTime);
		request.setAttribute("endTime", endTime);
		request.setAttribute("tileFee", totalFee);
		RequestDispatcher rd = request.getRequestDispatcher("CafeSeatsTileArray.jsp");
		rd.forward(request, response);
	} catch (Exception e) {
		e.printStackTrace();
	} 
		
	}
}
