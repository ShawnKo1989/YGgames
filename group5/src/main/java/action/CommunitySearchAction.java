package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostDAO;
import dto.PostDTO;

public class CommunitySearchAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String searchData = request.getParameter("searching");
		PostDAO postDao = PostDAO.getInstance();
		ArrayList<PostDTO> searchPost = postDao.searchPost(searchData);
		int totalPosts = postDao.getSearchPosts(searchData);
		
		request.setAttribute("searchPost",searchPost);
		request.setAttribute("totalPosts", totalPosts);
		
		RequestDispatcher rd = request.getRequestDispatcher("/communitypage/CommunitySearch.jsp?searching="+searchData);
		rd.forward(request, response);
	}
}
