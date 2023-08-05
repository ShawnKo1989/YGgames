package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.PostDAO;
import DAO.ReplyDAO;
import DTO.PostDTO;
import DTO.ReplyDTO;

public class ShowPostAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int showPostNo = 0;
		if(request.getParameter("showPostNo")!=null) {
			showPostNo=Integer.parseInt(request.getParameter("showPostNo"));
		}
		
		PostDAO postDao = PostDAO.getInstance();
		ReplyDAO replyDao = ReplyDAO.getInstance();
		int replyCnt = replyDao.replyCount(showPostNo);
		ArrayList<PostDTO> showPosts = postDao.showPost(showPostNo);
		ArrayList<ReplyDTO> showReply = replyDao.showReply(showPostNo);
		
		request.setAttribute("replyCnt",replyCnt);
		request.setAttribute("showPosts",showPosts);
		request.setAttribute("showReply",showReply);
		
		RequestDispatcher rd = request.getRequestDispatcher("CommunityShowBoard.jsp?showPostNo="+showPostNo);
		rd.forward(request, response);
		
	}
}
