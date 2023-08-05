package member;


import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Register {
	String mathRandom() {
		String rannum = "";
		for(int i = 1; i<=6; i++) {
			int ran = (int)(Math.random()*9);
			rannum += ran;
		}
		return rannum;
	}
	public static void naverMailSend(String email) throws Exception{
		Register reg = new Register();
        String host = "smtp.naver.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
        String user = "hotdog0818@naver.com"; // 패스워드
        String password = "abcd1234!";       
        String confirmNum =reg.mathRandom();

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
            message.setSubject("5조 프로젝트를 위한 테스트 발송");

            // 메일 내용
            message.setText(confirmNum);

            // send the message
            Transport.send(message);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
	
	
	public static void main(String[] args) throws Exception {
//		String name = "Seungwoo";
//		String id = "hotdog0818";
		String email = "hotdog0818@gmail.com";
		naverMailSend(email);
		}
	}

