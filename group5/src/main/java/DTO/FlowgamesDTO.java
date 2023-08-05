package DTO;

public class FlowgamesDTO {
	private String title;
	private String thumnail_img;
	
	public FlowgamesDTO(String title, String thumnail_img) {
		this.title = title;
		this.thumnail_img = thumnail_img;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getThumnail_img() {
		return thumnail_img;
	}

	public void setThumnail_img(String thumnail_img) {
		this.thumnail_img = thumnail_img;
	}
	
	
	
}
