package dto;

public class FaqDetailDto {
	private String content;
	private int cIdx;
	private String tag;

	public FaqDetailDto(String content, int cIdx, String tag) {
		this.content = content;
		this.cIdx = cIdx;
		this.tag = tag;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getcIdx() {
		return cIdx;
	}

	public void setcIdx(int cIdx) {
		this.cIdx = cIdx;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}
}