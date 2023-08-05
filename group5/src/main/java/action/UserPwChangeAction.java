package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.SettingDAO;

public class UserPwChangeAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		SettingDAO settingDao = SettingDAO.getInstance();
		int userRegNo = (int)(request.getSession().getAttribute("reg_no"));
		String loginedPw = (String)request.getSession().getAttribute("userPw");
		String userPw = request.getParameter("originalPw");
		String userNewPw1 = request.getParameter("newUserPw1");
		String userNewPw2 = request.getParameter("newUserPw2");
		
		System.out.println("UserPwChangeAction 정상작동중.");
		int result = -1;
		
		if(!userNewPw1.equals(userNewPw2)) {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "새비밀번호가 일치하지 않습니다. 다시입력해주세요");
			response.sendRedirect("profileSetting.jsp");
		}else if(userNewPw1.equals(userPw)) {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "이전 비밀번호와 같은 비밀번호입니다. 다시입력해주세요");
			response.sendRedirect("profileSetting.jsp");
		}else if(!loginedPw.equals(userPw)){
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "현재 사용중인 비밀번호가 잘못됐습니다. 다시입력해주세요");
			response.sendRedirect("profileSetting.jsp");
		}else {
			result = settingDao.settingUserPw(userNewPw1, userRegNo);
		}
		if(result == 0) {
			request.getSession().setAttribute("messageType", "알림메시지");
			request.getSession().setAttribute("messageContent", "수정되었습니다.");
			response.sendRedirect("profileSetting.jsp");
			return;
		}
	}

}
