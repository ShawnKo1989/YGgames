package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserDAO;
import DTO.UserDTO;

public class PasswordCheckAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		UserDTO user = new UserDTO();
		UserDAO userDao = UserDAO.getInstance();
		String userEmail = request.getParameter("userEmail");
		String userPw = request.getParameter("userPw");
		
		int result = userDao.passwordCheck(userEmail, userPw, request);
		
		if(result == 0) {
			System.out.println(user.getNickName());
			request.getSession().setAttribute("messageType", "알림메시지");
			request.getSession().setAttribute("messageContent", "로그인되었습니다.");
			request.getRequestDispatcher("Controller?command=ConnUpdateAction")
				.forward(request,response);
		}else if(result == -2){
			request.getSession().setAttribute("messageType", "알림메시지");
			request.getSession().setAttribute("messageContent", "탈퇴된 회원입니다.");
			response.sendRedirect("signin.jsp");
		}else {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "비밀번호가 일치하지 않습니다.");
			response.sendRedirect("signin.jsp");
		}
	}

}
