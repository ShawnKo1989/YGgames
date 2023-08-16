package file;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

public class FileTransfer {
	private static FileTransfer instance = new FileTransfer();

	private FileTransfer() {
	}

	public static FileTransfer getInstance() {
		return instance;
	}

	// InputStream을 Base64로 인코딩하는 메서드
	public String encodeToBase64(InputStream is) {
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		byte[] buffer = new byte[4096];
		int bytesRead;
		try {
			while ((bytesRead = is.read(buffer)) != -1) {
				outputStream.write(buffer, 0, bytesRead);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		byte[] bytes = outputStream.toByteArray();

		String base64url = Base64.getEncoder().encodeToString(bytes);

		return base64url;
	}
}
