package DTO;

public class RecentupdateDTO {
	private String title;
	private String ori_prc;
	private int dc_rate;
	private String thumnail_img;
	
	public RecentupdateDTO(String title, String ori_prc, int dc_rate, String thumnail_img) {
		this.title = title;
		this.ori_prc = ori_prc;
		this.dc_rate = dc_rate;
		this.thumnail_img = thumnail_img;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getOri_prc() {
		return ori_prc;
	}

	public void setOri_prc(String ori_prc) {
		this.ori_prc = ori_prc;
	}

	public int getDc_rate() {
		return dc_rate;
	}

	public void setDc_rate(int dc_rate) {
		this.dc_rate = dc_rate;
	}

	public String getThumnail_img() {
		return thumnail_img;
	}

	public void setThumnail_img(String thumnail_img) {
		this.thumnail_img = thumnail_img;
	}
	
	
	
}
