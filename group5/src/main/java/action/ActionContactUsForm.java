package action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.ContactDao;
import dto.ContactDto;
import dto.MemberDto;

public class ActionContactUsForm implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		// 세션에 "dto" 속성이 있는지 확인하여 로그인 상태를 판단한다.
		MemberDto mDto = (MemberDto) session.getAttribute("dto");
		if(mDto!=null) {
			String email = mDto.getEmail();
			int pno = 0;
			try {
				pno = Integer.parseInt(request.getParameter("page"));
			} catch (Exception e) {
				pno = 1;
			}
			
			ContactDao cDao = ContactDao.getInstance();
			ArrayList<ContactDto> cList = cDao.getContactList(email, pno);
			int historyCnt = cDao.cntHistory(email);
			int lastPno = historyCnt%3==0 ? historyCnt/3 : historyCnt/3+1;
			
			request.setAttribute("cList", cList);
			request.setAttribute("page", pno);
			request.setAttribute("lastPage", lastPno);
			
			RequestDispatcher rd = request.getRequestDispatcher("/help/contactUs/contactUs.jsp");
			rd.forward(request, response);
		}
	}
}