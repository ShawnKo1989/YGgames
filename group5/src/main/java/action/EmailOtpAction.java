package action;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EmailOtpAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String name = (String)(request.getAttribute("userName")); 
		String nickname = (String)(request.getAttribute("userNickname"));
		String email = (String)(request.getAttribute("userEmail"));
		String pw = (String)(request.getAttribute("userPw"));
		
		String confirmNum = mathRandom();
		try {
			naverMailSend(email,confirmNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("confirmNum 확인중 ..."+confirmNum);
		request.setAttribute("confirmNum", confirmNum);
		request.getRequestDispatcher("emailOTP.jsp").forward(request,response);
		
	}
	String mathRandom() {
		String rannum = "";
		for(int i = 1; i<=6; i++) {
			int ran = (int)(Math.random()*9);
			rannum += ran;
		}
		return rannum;
	}
	private void naverMailSend(String email, String confirmNum) throws Exception{
	    String host = "smtp.naver.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
	    String user = "hotdog0818@naver.com"; // 패스워드
	    String password = "abcd1234!";       

	    // SMTP 서버 정보를 설정한다.
	    Properties props = new Properties();
	    props.put("mail.smtp.host", host);
	    props.put("mail.smtp.port", 587);
	    props.put("mail.smtp.auth", "true");
	    props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    
	    Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	        protected PasswordAuthentication getPasswordAuthentication() {
	            return new PasswordAuthentication(user, password);
	        }
	    });

	    try {
	        MimeMessage message = new MimeMessage(session);
	        message.setFrom(new InternetAddress(user));
	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

	        // 메일 제목
	        message.setSubject("YG게임즈 이메일 인증번호");

	        // 메일 내용
	        message.setText(confirmNum);

	        // send the message
	        Transport.send(message);

	    } catch (MessagingException e) {
	        e.printStackTrace();
	    }
	}
}
