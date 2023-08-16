package dto;

import java.util.List;

public class ContactDto {
	private int cno;
	private String name;
	private String email;
	private String description;
	private String regdate;
	private List<ContactAttachmentDto> attachments;

	public ContactDto(int cno, String name, String email, String description, String regdate, List<ContactAttachmentDto> attachments) {
		this.cno = cno;
		this.name = name;
		this.email = email;
		this.description = description;
		this.regdate = regdate;
		this.attachments = attachments;
	}

	public int getCno() {
		return cno;
	}

	public void setCno(int cno) {
		this.cno = cno;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public List<ContactAttachmentDto> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<ContactAttachmentDto> attachments) {
		this.attachments = attachments;
	}
}