package DAO;

import java.sql.*;

import net.nurigo.sdk.message.service.DefaultMessageService;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;

public class SettingDAO {
	private DefaultMessageService messageService;
	private Connection conn;
	
	private SettingDAO() {
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String dbId = "temp";
			String dbPw = "1234";
			
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbId, dbPw);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private static SettingDAO instance = new SettingDAO();
	public static SettingDAO getInstance() {
		return instance;
	}
	
	public int settingAddress(String userAddress, String userPostalCode, 
			int userGender, String userName, int userType, String userBirth, int reg_no) {
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE member"
				+ " SET address = ?, postal_code = ?, gender= ?, name = ?, user_type= ?, birth= ?"
				+ " WHERE reg_no = ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userAddress);
			pstmt.setString(2, userPostalCode);
			pstmt.setInt(3, userGender);
			pstmt.setString(4, userName);
			pstmt.setInt(5, userType);
			pstmt.setString(6, userBirth);
			pstmt.setInt(7, reg_no);
			pstmt.executeUpdate();
			return 0; // 성공적으로 수정되었슴.
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 오류 발생시 출력되는 숫자.
	}
	public int settingNickname(String userNickname, String userEmail) {
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE member"
				+ " SET nickname = ?"
				+ " WHERE email = ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userNickname);
			pstmt.setString(2, userEmail);
			pstmt.executeUpdate();
			return 0; // 성공적으로 수정되었슴.
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 오류 발생시 출력되는 숫자.
	}
	public String sendMobileOTP(String userPhoneNum) {
		String mobileOTPNum = "";
		for(int i=1; i<=6; i++) {
			int num = (int)(Math.random()*9)+1;
			mobileOTPNum += num;
		}
		String apiKey ="NCSMKQYO2706VXFZ";
        String secretApiKey = "0BJPXPCEENU7ETWQ8MTQVWDTRVY0EG1Y";
        try {
	        this.messageService = NurigoApp.INSTANCE.initialize(apiKey, secretApiKey, "https://api.coolsms.co.kr");
	        
	        Message message = new Message();
	        message.setFrom("01058615444");
	        message.setTo(userPhoneNum);
	        message.setText("YG게임즈 모바일 인증번호는 ["+mobileOTPNum+"] 입니다.");
	
	        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
	        if(response != null) {
	        	System.out.println("인증번호를 위한 문자가 발송되었습니다.");
	        }
        }catch(Exception e) {
        	System.out.println("문자발송 실패.");
        	return null;
        }
        
		return mobileOTPNum;
	}
	public int settingMobileNum(String userMobileNum, int reg_no) {
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE member"
				+ " SET phone = ?"
				+ " WHERE reg_no = ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userMobileNum);
			pstmt.setInt(2, reg_no);
			pstmt.executeUpdate();
			return 0; // 성공적으로 수정되었슴.
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 오류 발생시 출력되는 숫자.
	}
	public int settingUserPw(String userPw, int reg_no) {
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE member"
				+ " SET pw = ?"
				+ " WHERE reg_no = ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setString(1, userPw);
			pstmt.setInt(2, reg_no);
			pstmt.executeUpdate();
			return 0; // 성공적으로 수정되었슴.
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 오류 발생시 출력되는 숫자.
	}
	public int checkUserMobile(int reg_no) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM member WHERE reg_no = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reg_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String userNum = rs.getString("phone");
				if(userNum != null) {
					return 0; // 탈퇴가 가능함
				}else {
					return -1; // 추가 모바일 인증이 필요함
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) {rs.close();}
				if(pstmt != null) {pstmt.close();}
			}catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		return -1; // 오류 발생시 출력 ( 데이터베이스 오류)
	}
	public int settingUserWithdraw(int reg_no) {
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE member"
				+ " SET valid = 1"
				+ " WHERE reg_no = ?";
		try {
			pstmt= conn.prepareStatement(sql);
			pstmt.setInt(1, reg_no);
			pstmt.executeUpdate();
			return 0; // 성공적으로 수정되었슴.
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
			if(pstmt != null) {pstmt.close();}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return -1; // 오류 발생시 출력되는 숫자.
	}
	
}
