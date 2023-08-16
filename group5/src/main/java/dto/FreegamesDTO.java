package dto;

public class FreegamesDTO {
	private String title;
	private String media_url;
	private String ori_prc;
	
	public FreegamesDTO(String title, String media_url, String ori_prc) {
		this.title = title;
		this.media_url = media_url;
		this.ori_prc = ori_prc;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMedia_url() {
		return media_url;
	}

	public void setMedia_url(String media_url) {
		this.media_url = media_url;
	}

	public String getOri_prc() {
		return ori_prc;
	}

	public void setOri_prc(String ori_prc) {
		this.ori_prc = ori_prc;
	}
	
	
	
}
