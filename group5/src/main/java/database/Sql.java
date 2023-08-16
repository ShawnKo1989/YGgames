package database;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Sql
 */
@WebServlet("/Sql")
public class Sql extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public String driver = "oracle.jdbc.driver.OracleDriver";
	public String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
	public String dbid = "group5";
	public String dbpw = "abcd1234";
    public Sql() {
        super();
    }
    public void getUpdate(String sql) throws Exception{
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbid,dbpw);
		Statement stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		
		stmt.close();
		conn.close();
	}
	public ResultSet getQuery(String sql) throws Exception{
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbid,dbpw);
		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		return rs;
	}
	public ResultSet getPrepare(String sql) throws Exception{
		Class.forName(driver);
		Connection conn = DriverManager.getConnection(url,dbid,dbpw);
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		return rs;
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
