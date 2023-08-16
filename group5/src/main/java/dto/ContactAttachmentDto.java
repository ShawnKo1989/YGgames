package dto;

import java.io.InputStream;

import file.FileTransfer;

public class ContactAttachmentDto {
	private String name;
	private String type;
	private InputStream fis;
	private String base64url;
	public ContactAttachmentDto(String name, String type, InputStream fis) {
		this.name = name;
		this.type = type;
		this.fis = fis;

		FileTransfer ft = FileTransfer.getInstance();

		this.base64url = ft.encodeToBase64(fis); 
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public InputStream getFis() {
		return fis;
	}
	public void setFis(InputStream fis) {
		this.fis = fis;
	}
	public String getBase64url() {
		return base64url;
	}
	public void setBase64url(String base64url) {
		this.base64url = base64url;
	}
}
