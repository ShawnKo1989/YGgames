package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import action.ActionFactory;

@MultipartConfig
@WebServlet("/ControllerHelp")
public class ControllerHelp extends HttpServlet implements Controller {
	private static final long serialVersionUID = 1L;

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html");
		try {
			runAction(request, response);
		} catch (Exception e) {
			HttpSession session = request.getSession();
			String previousUrl = (String) session.getAttribute("previousUrl");
			if(previousUrl==null) {
				previousUrl = "help";
			}
			response.sendRedirect(previousUrl);
		}
	}

	@Override
	public void runAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String command = request.getParameter("command");

		Action action = ActionFactory.getInstance().getAction(command);
		action.execute(request, response);
	}
}
