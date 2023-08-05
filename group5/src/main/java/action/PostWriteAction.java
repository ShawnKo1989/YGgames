package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.BoardDAO;
import DTO.BoardDTO;

public class PostWriteAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BoardDAO boardDao = BoardDAO.getInstance();
		ArrayList<BoardDTO> boardTitle = boardDao.showBoard();
		
		String title = "";
		String content = "";
		int postNo=0;
		if(request.getParameter("postNo")!=null){
			postNo = Integer.parseInt(request.getParameter("postNo"));
		}
		if(request.getParameter("title")!=null){
			title = request.getParameter("title");
		}
		if(request.getParameter("content")!=null)	{
			content = request.getParameter("content");
		}
		int updateValue=0;
		if(request.getParameter("updateValue")!=null){
			updateValue=Integer.parseInt(request.getParameter("updateValue"));
		}
		
		
		request.setAttribute("boardTitle", boardTitle);
		request.setAttribute("title",title);
		request.setAttribute("postNo",postNo);
		request.setAttribute("content",content);
		request.setAttribute("updateValue",updateValue);
		
		RequestDispatcher rd = request.getRequestDispatcher("CommunityPostWrite.jsp");
		rd.forward(request, response);
	}

}
