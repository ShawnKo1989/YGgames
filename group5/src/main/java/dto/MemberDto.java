package dto;

public class MemberDto {
	private int rno;
	private String email;
	private String pw;
	private String nickname;
	private int type;
	private String name;
	private int gender;
	private String phone;
	private String birth;
	private String address;
	private int valid;

	public MemberDto(int rno, String email, String pw, String nickname, int type, String name, int gender, String phone, String birth,
			String address, int valid) {
		this.rno = rno;
		this.email = email;
		this.pw = pw;
		this.nickname = nickname;
		this.type = type;
		this.name = name;
		this.gender = gender;
		this.phone = phone;
		this.birth = birth;
		this.address = address;
		this.valid = valid;
	}

	public int getRno() {
		return rno;
	}

	public void setRno(int rno) {
		this.rno = rno;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getValid() {
		return valid;
	}

	public void setValid(int valid) {
		this.valid = valid;
	}
}
