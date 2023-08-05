package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.SettingDAO;

public class UserWithdrawalAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		System.out.println("UserWithdrawalAction 정상작동중");
		
		SettingDAO settingDao = SettingDAO.getInstance();
		int userRegNo = (int)(request.getSession().getAttribute("reg_no"));
		
		int result = settingDao.checkUserMobile(userRegNo);
		
		if(result == 0) {
			settingDao.settingUserWithdraw(userRegNo);
			request.getSession().setAttribute("messageType", "알림메시지");
			request.getSession().setAttribute("messageContent", "회원탈퇴되었습니다.");
			response.sendRedirect("main.jsp");
		}else {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "모바일 인증이 안된 계정입니다. 인증 후 이용해주세요.");
			response.sendRedirect("profileSetting.jsp");
		}
	}
}
