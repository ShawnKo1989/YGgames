package DTO;

public class DiscountDTO {
	private String title;
	private String ori_prc;
	private double dc_rate;
	private String dc_prc;
	private String thumnail_img;
	public DiscountDTO(String title, String ori_prc, double dc_rate, String dc_prc, String thumnail_img) {
		this.title = title;
		this.ori_prc = ori_prc;
		this.dc_rate = dc_rate;
		this.dc_prc = dc_prc;
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
	public double getDc_rate() {
		return dc_rate;
	}
	public void setDc_rate(double dc_rate) {
		this.dc_rate = dc_rate;
	}
	public String getDc_prc() {
		return dc_prc;
	}
	public void setDc_prc(String dc_prc) {
		this.dc_prc = dc_prc;
	}
	public String getThumnail_img() {
		return thumnail_img;
	}
	public void setThumnail_img(String thumnail_img) {
		this.thumnail_img = thumnail_img;
	}
	
	
}
