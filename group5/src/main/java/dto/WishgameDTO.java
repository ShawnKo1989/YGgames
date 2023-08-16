package dto;

public class WishgameDTO {
	private String title;
	private String ori_prc;
	private String thumnail_img;
	private String available;
	
	public WishgameDTO(String title, String ori_prc, String thumnail_img, String available) {
		this.title = title;
		this.ori_prc = ori_prc;
		this.thumnail_img = thumnail_img;
		this.available = available;
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

	public String getThumnail_img() {
		return thumnail_img;
	}

	public void setThumnail_img(String thumnail_img) {
		this.thumnail_img = thumnail_img;
	}

	public String getAvailable() {
		return available;
	}

	public void setAvailable(String available) {
		this.available = available;
	}
	
	
}
