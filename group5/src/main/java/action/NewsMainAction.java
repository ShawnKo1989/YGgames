package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.NewsDAO;
import DTO.NewsDTO;

public class NewsMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		NewsDAO newsDao = NewsDAO.getInstance();
		ArrayList<NewsDTO> newsList = newsDao.getAllNews();
		
		request.setAttribute("newsList", newsList);
		
		RequestDispatcher rd = request.getRequestDispatcher("NewsMain.jsp");
		rd.forward(request, response);
		
	}

}
