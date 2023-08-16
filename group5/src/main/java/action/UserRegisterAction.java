package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.UserDAO;

public class UserRegisterAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO userDao = UserDAO.getInstance();
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userEmail = request.getParameter("userEmail");
		String userName = request.getParameter("userName");
		String nickName = request.getParameter("nickName");
		String userPw = request.getParameter("userPw");
		
		System.out.println("UserRegisterAction 정상적으로 작동중!!");
		if(userEmail == null || userName == null || nickName == null || userPw == null) {
			request.setAttribute("messageType","오류메시지");
			request.setAttribute("messageContent","모든내용을 입력하세요.");
			request.getRequestDispatcher("/signinpage/signup.jsp")
			.forward(request, response);;
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
			request.setAttribute("messageType","오류메시지");
			request.setAttribute("messageContent","이미 존재하는 회원입니다.");
			request.getRequestDispatcher("/signuppage/signup.jsp")
			.forward(request,response);
			return;
		}else {
			request.setAttribute("userEmail", userEmail);
			request.setAttribute("userNickname",nickName);
			request.setAttribute("userName", userName);
			request.setAttribute("userPw", userPw);
			System.out.println("회원가입이 가능한 ID / 중복체크완료.");
			request.getRequestDispatcher("/Controller?command=EmailOtpAction")
				.forward(request, response);
		}
	}

}
