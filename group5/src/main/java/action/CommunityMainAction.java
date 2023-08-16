package action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.PostDAO;
import dto.PostDTO;

public class CommunityMainAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PostDAO postDao = PostDAO.getInstance();
		List<PostDTO> allPost  = postDao.allPost();
		List<PostDTO> hotPost = postDao.hotPost();
		request.setAttribute("allPost", allPost);
		request.setAttribute("hotPost", hotPost);
		RequestDispatcher rd = request.getRequestDispatcher("/communitypage/Community.jsp");
		rd.forward(request, response);
		
	}
	
}
