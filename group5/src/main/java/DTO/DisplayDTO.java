package DTO;

public class DisplayDTO {
	private String title_icon;
	private String simple_text;
	private String dis_offer;
	private String displayed_img;
	private String ori_prc;
	
	public DisplayDTO(String title_icon, String simple_text, String dis_offer, String displayed_img, String ori_prc) {
		this.title_icon = title_icon;
		this.simple_text = simple_text;
		this.dis_offer = dis_offer;
		this.displayed_img = displayed_img;
		this.ori_prc = ori_prc;
	}
	public String getTitle_icon() {
		return title_icon;
	}
	public void setTitle_icon(String title_icon) {
		this.title_icon = title_icon;
	}
	public String getSimple_text() {
		return simple_text;
	}
	public void setSimple_text(String simple_text) {
		this.simple_text = simple_text;
	}
	public String getDis_offer() {
		return dis_offer;
	}
	public void setDis_offer(String dis_offer) {
		this.dis_offer = dis_offer;
	}
	public String getDisplayed_img() {
		return displayed_img;
	}
	public void setDisplayed_img(String displayed_img) {
		this.displayed_img = displayed_img;
	}
	public String getOri_prc() {
		return ori_prc;
	}
	public void setOri_prc(String ori_prc) {
		this.ori_prc = ori_prc;
	}
	

}
