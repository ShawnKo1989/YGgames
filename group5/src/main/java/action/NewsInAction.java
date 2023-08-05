package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.NewsDAO;
import DTO.NewsDTO;

public class NewsInAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int newsNo = Integer.parseInt(request.getParameter("newsNo"));
		NewsDAO newsDao = NewsDAO.getInstance();
		NewsDTO news = newsDao.getNewsByNo(newsNo);
		
		request.setAttribute("news",news);
		request.setAttribute("newsNo",newsNo);
		
		RequestDispatcher rd = request.getRequestDispatcher("NewsIn.jsp");
		rd.forward(request, response);
	}
}
