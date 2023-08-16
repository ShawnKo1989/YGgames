package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.BoardDAO;
import dao.PostDAO;
import dto.PostDTO;
@SuppressWarnings("serial")
@WebServlet("/CommunityBoardServlet")
public class CommunityBoardServlet extends HttpServlet {
    
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String boardName = "전체";
        int boardNo = 0;
        try {
            boardNo = Integer.parseInt(request.getParameter("boardNo"));
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        int pageNo = 1;
        try {
            pageNo = Integer.parseInt(request.getParameter("pageNo"));
        } catch (NumberFormatException e) {
            pageNo = 1;
        }
        int postsPerPage = 10;

        PostDAO dao = PostDAO.getInstance();
        BoardDAO bDao = BoardDAO.getInstance();
        if (boardNo != 0) {
            boardName = bDao.getBoardName(boardNo);
        }

        List<PostDTO> postList = dao.getPostList(boardNo, pageNo, postsPerPage);
        int totalPosts = dao.getTotalPosts(boardNo);
        dao.closeConnection();

        int totalPages = (int) Math.ceil((double) totalPosts / postsPerPage);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HashMap<String, Object> responseData = new HashMap<>();
        responseData.put("boardName", boardName);
        responseData.put("postList", postList);
        responseData.put("pageNo", pageNo);
        responseData.put("totalPages", totalPages);

        Gson gson = new Gson();
        String jsonData = gson.toJson(responseData);

        PrintWriter out = response.getWriter();
        out.print(jsonData);

    }
}
