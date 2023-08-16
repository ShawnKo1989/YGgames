package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.FaqDao;
import dto.FaqDto;

public class ActionSearch implements Action {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pno = 0;
		try {
			pno = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			pno = 1;
		}

		int isTotal = 0;
		try {
			if (Integer.parseInt(request.getParameter("total")) == 1) {
				isTotal = 1;
			}
		} catch (NumberFormatException e) {
			isTotal = 0;
		}

		String search = "";
		try {
			search = request.getParameter("search");
			if (search == null) {
				search = "";
			}
		} catch (Exception e) {
			search = "";
		}
		String searchWord = "%" + search + "%";

		int cno = 0;
		try {
			cno = Integer.parseInt(request.getParameter("category"));
		} catch (NumberFormatException e) {
			cno = 0;
		}
		
		String resultStyle = request.getParameter("resultStyle");
		resultStyle = resultStyle==null ? "page" : resultStyle;

		FaqDao fDao = FaqDao.getInstance();
		ArrayList<FaqDto> fList = fDao.getFaqList(cno, searchWord, pno, isTotal);
		if(resultStyle.equals("page") || resultStyle.equals("list")) {
			int[] rsSize = new int[5];
			for (int i = 0; i < rsSize.length; i++) {
				rsSize[i] = fDao.cntSearchRs(i, searchWord, isTotal);
			}
			
			request.setAttribute("pno", pno);
			request.setAttribute("isTotal", isTotal);
			request.setAttribute("search", search);
			request.setAttribute("cno", cno);
			request.setAttribute("fList", fList);
			request.setAttribute("rsSize", rsSize);
			request.setAttribute("resultStyle", resultStyle);
			
			RequestDispatcher rd = request.getRequestDispatcher("/help/search/result.jsp");
			rd.forward(request, response);
		} else if(resultStyle.equals("getMoreList")) {
			response.setContentType("application/json");
			
			PrintWriter out = response.getWriter();
			JSONArray array = new JSONArray();
			
			for(FaqDto fDto : fList) {
				JSONObject obj = new JSONObject();
				obj.put("fno", fDto.getFno());
				obj.put("title", fDto.getTitle());
				array.add(obj);
			}
			out.println(array);
		}
	}
}
