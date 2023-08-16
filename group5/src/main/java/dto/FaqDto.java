package dto;

import java.util.ArrayList;

public class FaqDto {
	private int fno;
	private String title;
	private int category;
	private String categoryName;
	private String subdivision;
	private ArrayList<FaqDetailDto> detail;

	public FaqDto(int fno, String title, int category, String categoryName, String subdivision,
			ArrayList<FaqDetailDto> detail) {
		this.fno = fno;
		this.title = title;
		this.category = category;
		this.categoryName = categoryName;
		this.subdivision = subdivision;
		this.detail = detail;
	}

	public int getFno() {
		return fno;
	}

	public void setFno(int fno) {
		this.fno = fno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getSubdivision() {
		return subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public ArrayList<FaqDetailDto> getDetail() {
		return detail;
	}

	public void setDetail(ArrayList<FaqDetailDto> detail) {
		this.detail = detail;
	}
}
