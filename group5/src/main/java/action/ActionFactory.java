package action;

public class ActionFactory {
	private static ActionFactory instance = new ActionFactory();
	private ActionFactory() {}
	public static ActionFactory getInstance() {
		return instance;
	}
	public Action getAction(String command) {
		Action action = null;
		switch(command) {
		case "RegisterCheckAction":action = new RegisterCheckAction();break;
		case "PasswordCheckAction":action = new PasswordCheckAction();break;
		case "ConnUpdateAction":action = new ConnUpdateAction();break;
		case "UserRegisterAction":action = new UserRegisterAction();break;
		case "EmailOtpAction":action = new EmailOtpAction();break;
		case "UpdateUserInfoAction" : action = new UpdateUserInfoAction();break;
		case "NicknameChangeAction": action = new NicknameChangeAction();break;
		case "UserProfileUpdateAction": action = new UserProfileUpdateAction();break;
		case "UserMobileOTPAction" : action = new UserMobileOTPAction();break;
		case "UserMobileSettingAction" : action = new UserMobileSettingAction();break;
		case "UserPwChangeAction" : action = new UserPwChangeAction();break;
		case "AllSessionLogoutAction" : action = new AllSessionLogoutAction();break;
		case "UserWithdrawalAction" : action = new UserWithdrawalAction();break;
		case "community":action = new CommunityMainAction();break; 
		case "communityBoard":action = new CommunityBoardAction();break;
		case "showPostAction":action = new ShowPostAction();break;
		case "communitySearch":action = new CommunitySearchAction();break;
		case "postWrite":action = new PostWriteAction();break;
		case "pcCafe":action = new PcCafeAction();break;
		case "reserveSeat":action = new ReserveSeatAction();break;
		case "reservePay":action = new CafeReservePayAction();break;
		case "payment":action = new PaymentAction();break;
		case "inquiry":action = new InquiryAction();break;
		case "paymentSelect":action = new PaymentSelectAction();break;
		case "news":action = new NewsMainAction();break;
		case "newsIn":action = new NewsInAction();break;
		}
		return action;
	}
}
