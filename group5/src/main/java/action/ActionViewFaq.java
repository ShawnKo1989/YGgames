package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.FaqDao;
import dto.FaqDto;

public class ActionViewFaq implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int fno = 0;
		try {
			fno = Integer.parseInt(request.getParameter("fno"));
		}catch (NumberFormatException | NullPointerException e) {
			fno = 1;
		}
		FaqDao fDao = FaqDao.getInstance();
		FaqDto fDto = fDao.getFaqDto(fno);
		
		request.setAttribute("fDto", fDto);
		
		RequestDispatcher rd = request.getRequestDispatcher("/help/search/faqDetail/detail.jsp?fno=" + fno);
		rd.forward(request, response);
	}
}
