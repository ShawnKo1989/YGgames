package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.SettingDAO;

public class NicknameChangeAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String userNickname = (String)(request.getParameter("userNickname"));
		String userEmail = (String)(request.getParameter("userEmail"));
		SettingDAO settingDao = SettingDAO.getInstance();
		System.out.println(userNickname + " " + userEmail);
		
		try {
			int result = settingDao.settingNickname(userNickname, userEmail);
			if(result == 0) {
				request.getSession().setAttribute("messageType", "알림메시지");
				request.getSession().setAttribute("messageContent", "수정되었습니다.");
				request.getSession().setAttribute("userNickname", userNickname);
				response.sendRedirect("profileSetting.jsp");
				return;
			}else {
				request.getSession().setAttribute("messageType", "경고메시지");
				request.getSession().setAttribute("messageContent", "잘못된 정보입니다.다시입력해주세요");
				response.sendRedirect("profileSetting.jsp");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
