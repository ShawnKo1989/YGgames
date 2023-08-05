package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.SettingDAO;

public class UserProfileUpdateAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		SettingDAO settingDao = SettingDAO.getInstance();
		int userGender = 0;
		int userType = 0;
		int userRegNo = (int)(request.getSession().getAttribute("reg_no"));
		String userAddress1 = request.getParameter("userAddress1");
		String userAddress2 = request.getParameter("userAddress2");
		String userAddress3 = request.getParameter("userAddress3");
		String userName = request.getParameter("userName");
		String getUserGender = request.getParameter("userGender");
		String getUserType = request.getParameter("userType");
		String userBirth = request.getParameter("userBirth");
		if(getUserGender.equals("남자")) {
			userGender = 0;
		}else {
			userGender = 1;
		}
		if(getUserType.equals("유저")) {
			userType = 0;
		}else {
			userType = 1;
		}
		String userPostalCode = request.getParameter("userPostalCode");
		String userAddressFinal = userAddress1 + " " + userAddress2 + " "+userAddress3;
		
		System.out.println("UserProfileUpdateAction 정상적으로 작동중");
		
		int result = settingDao.settingAddress(userAddressFinal, userPostalCode, userGender, userName, userType, userBirth ,userRegNo);
		
		if(result == 0) {
			request.getSession().setAttribute("messageType", "알림메시지");
			request.getSession().setAttribute("messageContent", "수정되었습니다.");
			response.sendRedirect("profileSetting.jsp");
			return;
		}else {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "잘못된 정보입니다.다시입력해주세요");
			response.sendRedirect("profileSetting.jsp");
		}
	}

}
