package dto;

public class CafeDTO {
	private int cno;
	private String cafeName;
	private String point;
	private String pass;
	private String pay;
	private String event;
	private String city;
	private String region;
	private String address;
	private int totalnum;
	
	public CafeDTO(int cno, String cafeName, String point, String pass, String pay, String event, String city,
			String region, String address, int totalnum) {
		this.cno = cno;
		this.cafeName = cafeName;
		this.point = point;
		this.pass = pass;
		this.pay = pay;
		this.event = event;
		this.city = city;
		this.region = region;
		this.address = address;
		this.totalnum = totalnum;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getCafeName() {
		return cafeName;
	}

	public void setCafeName(String cafeName) {
		this.cafeName = cafeName;
	}

	public String getPoint() {
		return point;
	}

	public void setPoint(String point) {
		this.point = point;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getPay() {
		return pay;
	}

	public void setPay(String pay) {
		this.pay = pay;
	}

	public String getEvent() {
		return event;
	}

	public void setEvent(String event) {
		this.event = event;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getRegion() {
		return region;
	}

	public void setRegion(String region) {
		this.region = region;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getTotalnum() {
		return totalnum;
	}

	public void setTotalnum(int totalnum) {
		this.totalnum = totalnum;
	}
	
	
	
}
