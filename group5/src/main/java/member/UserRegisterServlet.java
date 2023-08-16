package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;

/**
 * Servlet implementation class UserRegisterServlet
 */
@WebServlet("/UserRegisterServlet")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO userDao = UserDAO.getInstance();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userEmail = request.getParameter("userEmail");
		String userName = request.getParameter("userName");
		String nickName = request.getParameter("nickName");
		String userPw = request.getParameter("userPw");
		
		System.out.println("UserRegisterServlet 정상적으로 작동중!!");
		if(userEmail == null || userName == null || nickName == null || userPw == null) {
			request.getSession().setAttribute("messageType","오류메시지");
			request.getSession().setAttribute("messageContent","모든내용을 입력하세요.");
			response.sendRedirect("signup.jsp");
			return;
		}
		int result = userDao.registerCheck(userEmail);
//		int result = new UserDAO().register(userEmail, userName, nickName, userPw);
//		if(result ==1) {
//			request.getSession().setAttribute("messageType","성공메시지");
//			request.getSession().setAttribute("messageContent","회원가입에 성공하였습니다.");
//			response.sendRedirect("signup.jsp");
//			return;
//		}
		if(result == 0) {
			System.out.print("멤버DB에 등록되어있슴.");
			request.getSession().setAttribute("messageType","오류메시지");
			request.getSession().setAttribute("messageContent","이미 존재하는 회원입니다.");
			response.sendRedirect("signup.jsp");
			return;
		}else {
			request.getSession().setAttribute("userEmail", userEmail);
			request.getSession().setAttribute("userNickname",nickName);
			request.getSession().setAttribute("userName", userName);
			request.getSession().setAttribute("userPw", userPw);
			System.out.println("세션 정상작동중");
			response.sendRedirect("emailOTP.jsp");
		}
	}

}
