package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.UserDAO;

public class UpdateUserInfoAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		
		UserDAO userDao = new UserDAO();
		String userName = (String)(request.getParameter("userName")); 
		String userNickname = (String)(request.getParameter("userNickname"));
		String userEmail = (String)(request.getParameter("userEmail"));
		String userPw = (String)(request.getParameter("userPw"));
		System.out.println(userName + " " + userPw +" "+userNickname+" "+userEmail);
		
		try {
			userDao.updateUserInfo(userName, userNickname, userEmail, userPw);
			System.out.println("정상적으로 회원DB에 등록되었슴.");
		}catch(Exception e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("signup2.jsp").forward(request,response);
	}

}
