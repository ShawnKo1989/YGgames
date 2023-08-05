package jdbc;

public class Friend {
	private int reg_no;
	private String nickname;
	private String name;
	private int connecting;
	private int relationship;
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getConnecting() {
		return connecting;
	}
	public void setConnecting(int connecting) {
		this.connecting = connecting;
	}
	public int getReg_no() {
		return reg_no;
	}
	public void setReg_no(int reg_no) {
		this.reg_no = reg_no;
	}
	public int getRelationship() {
		return relationship;
	}
	public void setRelationship(int relationship) {
		this.relationship = relationship;
	}
	public Friend(String nickname, String name, int connecting) {
		super();
		this.nickname = nickname;
		this.name = name;
		this.connecting = connecting;
	}
	public Friend(int reg_no, String nickname, int connecting, int relationship) {
		super();
		this.reg_no = reg_no;
		this.nickname = nickname;
		this.connecting = connecting;
		this.relationship = relationship;
	}
}
