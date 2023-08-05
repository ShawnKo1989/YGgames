package DTO;

public class ReplyDTO {
	private int rplNo;
	private int postNo;
	private int upRplNo;
	private String content;
	private String nickname;
	private String replyTime;
	private int replyCondition;
	
	public int getRplNo() {
		return rplNo;
	}
	public void setRplNo(int rplNo) {
		this.rplNo = rplNo;
	}
	public int getPostNo() {
		return postNo;
	}
	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}
	public int getUpRplNo() {
		return upRplNo;
	}
	public void setUpRplNo(int upRplNo) {
		this.upRplNo = upRplNo;
	}
	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(String replyTime) {
		this.replyTime = replyTime;
	}
	public int getReplyCondition() {
		return replyCondition;
	}
	public void setReplyCondition(int replyCondition) {
		this.replyCondition = replyCondition;
	}
}
