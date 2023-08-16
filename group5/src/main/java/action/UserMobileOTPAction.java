package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SettingDAO;

public class UserMobileOTPAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		SettingDAO settingDao = SettingDAO.getInstance();
		String userPhoneNum = request.getParameter("userPhoneNum");
		System.out.println("UserMobileOTPAction 정상작동중..");
		String mobileOTPNum = settingDao.sendMobileOTP(userPhoneNum);
		
		if(mobileOTPNum != null || mobileOTPNum != "") {
			System.out.println("전송성공");
			request.setAttribute("userPhoneNum",userPhoneNum);
			request.setAttribute("mobileOTPNum", mobileOTPNum);
			request.getRequestDispatcher("/settingpage/profileSetting.jsp").
			forward(request,response);
		}
		
		
	}

}
