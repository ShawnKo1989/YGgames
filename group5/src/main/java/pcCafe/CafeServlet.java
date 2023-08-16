package pcCafe;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.CafeDAO;
import dto.CafeDTO;


@WebServlet("/CafeServlet")
public class CafeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("get 요청이 들어옴.");
		CafeDAO cDao = CafeDAO.getInstance(); 
		ArrayList <CafeDTO> cafeList = null; 
		request.setCharacterEncoding("utf-8");
		
		int pageNum =0;
		try{
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}catch (NumberFormatException e){
			pageNum = 1;
		}
		
		String point = (String)request.getParameter("point");
		String pass = (String)request.getParameter("pass");
		String pay = (String)request.getParameter("pay");
		String event = (String)request.getParameter("event");
		System.out.println(point + " " + pass + " " + pay + " " + event);
		try {
			cafeList = cDao.getKakoCafe(pageNum,point,pass,pay,event);
			System.out.println("dto에 저장되었슴");
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		response.setCharacterEncoding("utf-8");
		 response.setContentType("application/json");
		 PrintWriter out = response.getWriter();
		 JSONArray array = new JSONArray();
		 for(CafeDTO dto : cafeList) {
			 JSONObject obj = new JSONObject();
			 obj.put("cafeName",dto.getCafeName());
			 obj.put("point",dto.getPoint());
			 obj.put("pass",dto.getPass());
			 obj.put("pay",dto.getPay());
			 obj.put("event",dto.getEvent());
			 obj.put("city",dto.getCity());
			 obj.put("region",dto.getRegion());
			 obj.put("address",dto.getAddress());
			 obj.put("totalnum",dto.getTotalnum());
			 array.add(obj);
		 }
		 out.println(array);
		 System.out.println("Json Array 로 보내짐");
	}


}
