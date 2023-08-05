package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserDAO;
import DTO.UserDTO;

public class RegisterCheckAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		UserDTO user = new UserDTO();
		UserDAO userDao = UserDAO.getInstance();
		String userEmail = request.getParameter("userEmail");
		String userPw = request.getParameter("userPw");
		
		int result = userDao.registerCheck(userEmail);
		
		if(result == 1) {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "존재하지않는 회원입니다.");
			response.sendRedirect("signin.jsp");
		}else {
			request.getRequestDispatcher("Controller?command=PasswordCheckAction")
				.forward(request,response);
			
		}
	}

}
