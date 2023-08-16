package dto;

public class GamePayDTO {
	String gameImg;
	String gameTitle;
	String publisher;
	String gameOriPrice;
	String gameDisPrice;
	String totalPrice;
	public GamePayDTO(String gameImg, String gameTitle, String publisher, String gameOriPrice, String gameDisPrice,
			String totalPrice) {
		this.gameImg = gameImg;
		this.gameTitle = gameTitle;
		this.publisher = publisher;
		this.gameOriPrice = gameOriPrice;
		this.gameDisPrice = gameDisPrice;
		this.totalPrice = totalPrice;
	}
	public String getGameImg() {
		return gameImg;
	}
	public void setGameImg(String gameImg) {
		this.gameImg = gameImg;
	}
	public String getGameTitle() {
		return gameTitle;
	}
	public void setGameTitle(String gameTitle) {
		this.gameTitle = gameTitle;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getGameOriPrice() {
		return gameOriPrice;
	}
	public void setGameOriPrice(String gameOriPrice) {
		this.gameOriPrice = gameOriPrice;
	}
	public String getGameDisPrice() {
		return gameDisPrice;
	}
	public void setGameDisPrice(String gameDisPrice) {
		this.gameDisPrice = gameDisPrice;
	}
	public String getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}
	
	
	
}
