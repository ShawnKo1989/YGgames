package action;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import dao.ContactDao;

public class ActionContactUs implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Collection<Part> parts = request.getParts();
		ContactDao cDao = ContactDao.getInstance();
		cDao.insertContact(request, parts);

		response.sendRedirect("/group5/help/contactUs");
	}
}
