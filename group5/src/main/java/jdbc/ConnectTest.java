package jdbc;

public class ConnectTest {
	public static void main(String[] args) {
		UserDAO userDAO = new UserDAO();
		System.out.println(userDAO.login("", ""));
	}
}
