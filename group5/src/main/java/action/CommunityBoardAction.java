package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BoardDAO;
import dao.PostDAO;
import dto.PostDTO;

public class CommunityBoardAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		int pageNo = 1;
		int postsPerPage = 10;
		if(request.getParameter("pageNo")!=null) {
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
			System.out.println(pageNo);
		}
		
		PostDAO postDao = PostDAO.getInstance();
		BoardDAO boardDao = BoardDAO.getInstance();
		String boardName = boardDao.getBoardName(boardNo);
		ArrayList<PostDTO> postList = postDao.getPostList(boardNo, pageNo, postsPerPage);
		int totalPosts = postDao.getTotalPosts(boardNo);
		
		request.setAttribute("boardNo",boardNo);
		request.setAttribute("pageNo",pageNo);
		request.setAttribute("boardName",boardName);
		request.setAttribute("postList",postList);
		request.setAttribute("totalPosts",totalPosts);
		
		RequestDispatcher rd = request.getRequestDispatcher("/communitypage/CommunityBoard.jsp");
		rd.forward(request, response);
		
	}

}
