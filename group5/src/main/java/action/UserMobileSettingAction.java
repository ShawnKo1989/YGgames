package action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.SettingDAO;

public class UserMobileSettingAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		SettingDAO settingDao = SettingDAO.getInstance();
		String userNum = (String)request.getSession().getAttribute("userPhoneNum");
		int regNo = (int)request.getSession().getAttribute("reg_no");
		String mobileOTPNum = (String)request.getSession().getAttribute("mobileOTPNum");
		String num1 = (String)request.getParameter("num1");
		String num2 = (String)request.getParameter("num2");
		String num3 = (String)request.getParameter("num3");
		String num4 = (String)request.getParameter("num4");
		String num5 = (String)request.getParameter("num5");
		String num6 = (String)request.getParameter("num6");
		String userWriteNum = num1 + num2 + num3 + num4 + num5 + num6;
		
		int result= 0;
		if(!mobileOTPNum.equals(userWriteNum)) {
			result = 2;
			request.getSession().setAttribute("mobileOTPNum",null);
		}else {
			result = settingDao.settingMobileNum(userNum,regNo);
			request.getSession().setAttribute("mobileOTPNum",null);
		}
		
		System.out.println("UserMobileSettingAction 정상작동중.");
		if(result == 0) {
			System.out.println("해당유저의 모바일이 등록됨.");
			request.getSession().setAttribute("userPhoneNum", null);
			request.getSession().setAttribute("messageType", "알림메시지");
			request.getSession().setAttribute("messageContent", "등록되었습니다.");
			response.sendRedirect("profileSetting.jsp");
		}else if(result ==2) {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "입력한 OTP가 일치하지않음.");
			response.sendRedirect("profileSetting.jsp");
		}else {
			request.getSession().setAttribute("messageType", "경고메시지");
			request.getSession().setAttribute("messageContent", "뭔가 잘못됐음.");
			response.sendRedirect("profileSetting.jsp");
		}
	}

}
