package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AllSessionLogoutAction implements Action{
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		request.setAttribute("messageType", "알림메시지");
		request.setAttribute("messageContent", "로그아웃되었습니다.");
		request.getSession().invalidate();
		request.getRequestDispatcher("/index.jsp").forward(request,response);
	}

}
