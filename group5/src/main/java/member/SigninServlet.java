package member;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;
import dto.UserDTO;
@WebServlet("/SigninServlet")
public class SigninServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
			int result2 = userDao.passwordCheck(userEmail, userPw, request);
			if(result2 == 0) {
				System.out.println(user.getNickName());
				request.getSession().setAttribute("messageType", "알림메시지");
				request.getSession().setAttribute("messageContent", "로그인되었습니다.");
				int result3 = userDao.userConnectivity((int)request.getSession().getAttribute("reg_no"));
				if(result3 == 0) {
					System.out.println("접속상태 업데이트 성공");
					response.sendRedirect("main.jsp");
				}else {
					System.out.println("접속상태 업데이트 실패");
				}
			}else if(result2 == -2){
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

}
