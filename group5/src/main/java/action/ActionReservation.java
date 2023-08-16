package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.RsvDao;
import dto.RsvDto;

public class ActionReservation implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	String date = request.getParameter("date");
            String time = request.getParameter("time");
            String schedule = date + " " + time;
            int supporterNo = Integer.parseInt(request.getParameter("supporter"));
            int typeNo = Integer.parseInt(request.getParameter("supportType"));
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String email = request.getParameter("email");
            String purpose = request.getParameter("description");

            RsvDao rDao = RsvDao.getInstance();
            int[] sptSchedules = rDao.cntRsv(schedule);
            if(sptSchedules[supporterNo-1]==0) {
            	RsvDto rDto = new RsvDto(0, name, schedule, null, typeNo, null, supporterNo, purpose, phone, email);
            	
            	int rsvno = rDao.rsvReg(rDto);
            	
            	request.setAttribute("rsvno", rsvno);
            } else {
            	int rsvno =0;
            	request.setAttribute("rsvno", rsvno);
            }
        } catch(Exception e) {
        	int rsvno =0;
        	request.setAttribute("rsvno", rsvno);
        } finally {
        	RequestDispatcher rd = request.getRequestDispatcher("/help/?command=reservationForm");
        	rd.forward(request, response);
        }
	}
}
