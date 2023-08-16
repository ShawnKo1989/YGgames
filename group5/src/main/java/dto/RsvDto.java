package dto;

public class RsvDto {
	private int rsvno;
	private String name;
	private String schedule;
	private String type;
	private int typeNo;
	private String supporter;
	private int supporterNo;
	private String purpose;
	private String phone;
	private String email;

	public RsvDto(int rsvno, String name, String schedule, String type, int typeNo, String supporter, int supporterNo,
			String purpose, String phone, String email) {
		super();
		this.rsvno = rsvno;
		this.name = name;
		this.schedule = schedule;
		this.type = type;
		this.typeNo = typeNo;
		this.supporter = supporter;
		this.supporterNo = supporterNo;
		this.purpose = purpose;
		this.phone = phone;
		this.email = email;
	}

	public int getRsvno() {
		return rsvno;
	}

	public void setRsvno(int rsvno) {
		this.rsvno = rsvno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSchedule() {
		return schedule;
	}

	public void setSchedule(String schedule) {
		this.schedule = schedule;
	}

	public String getSupporter() {
		return supporter;
	}

	public void setSupporter(String supporter) {
		this.supporter = supporter;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public int getTypeNo() {
		return typeNo;
	}

	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}

	public int getSupporterNo() {
		return supporterNo;
	}

	public void setSupporterNo(int supporterNo) {
		this.supporterNo = supporterNo;
	}
}
