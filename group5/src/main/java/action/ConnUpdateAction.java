package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dto.UserDTO;

public class ConnUpdateAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		UserDTO user = new UserDTO();
		UserDAO userDao = UserDAO.getInstance();
		String userEmail = request.getParameter("userEmail");
		String userPw = request.getParameter("userPw");
		
		int result = userDao.userConnectivity((int)request.getSession().getAttribute("reg_no"));
		if(result == 0) {
			System.out.println("접속상태 업데이트 성공");
			request.getRequestDispatcher("/storepage/main.jsp")
			.forward(request,response);
		}else {
			System.out.println("접속상태 업데이트 실패");
		}
		
	}

}
