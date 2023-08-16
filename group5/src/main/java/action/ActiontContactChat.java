package action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.MemberDto;

public class ActiontContactChat implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		MemberDto mDto = (MemberDto)session.getAttribute("dto");
		
		String url = "/group5/help/contactUs/chat/" + (mDto.getType()==0 ? "admin.jsp?room=admin" : "client.jsp?room=" + mDto.getEmail());
		
		RequestDispatcher rd = request.getRequestDispatcher(url);
		rd.forward(request, response);
	}
}
