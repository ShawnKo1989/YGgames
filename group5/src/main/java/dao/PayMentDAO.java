package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import dto.PayMentDTO;

public class PayMentDAO {
    private String dbid = "group5";
    private String dbpw = "abcd1234";
    private String driver = "oracle.jdbc.driver.OracleDriver";
    private String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
    private Date today = new Date();
    private Connection conn;
    private SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
    
    private PayMentDAO() {    	
    }
    private static PayMentDAO instance = new PayMentDAO();
    public static PayMentDAO getInstance() {
    	return instance;
    }
    
    public String today() {
        String toDay = date.format(today);
        return toDay;
    }

    public String whatDay(int sysday) {
        Calendar day = Calendar.getInstance();
        day.add(Calendar.DATE, -sysday);
        String beforeDate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(day.getTime());
        return beforeDate;
    }

    public int[] totalFee(int sysday) throws Exception {
        Connection conn = null;
        int totalFee = 0;
        int totalNaverPay = 0;
        int totalKakaoPay = 0;
        int totalCard = 0;
        Class.forName(driver);
        conn = DriverManager.getConnection(url, dbid, dbpw);
        String sql = "SELECT pay_tool, fee FROM cafe_sell_history WHERE cafe_no=3108 AND sell_date=TO_CHAR(TRUNC(sysdate)-?,'YYYY/MM/DD')";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, sysday);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            int payTool = rs.getInt("pay_tool");
            int fee = rs.getInt("fee");
            totalFee += fee;
            switch (payTool) {
                case 0:
                    totalNaverPay += fee;
                    break;
                case 1:
                    totalKakaoPay += fee;
                    break;
                case 2:
                    totalCard += fee;
                    break;
            }
        }
        int[] fee = new int[4];
        fee[0] = totalFee;
        fee[1] = totalNaverPay;
        fee[2] = totalKakaoPay;
        fee[3] = totalCard;
        rs.close();
        pstmt.close();
        conn.close();
        return fee;
    }
    
    
    
    public int[] todayTotalFee() throws Exception{
    	Connection conn = null;
    	int totalNaverPay = 0;
    	int totalKakaoPay = 0;
    	int totalCard = 0;
    	int totalPc = 0;
    	int totalFood = 0;
    	int totalVou = 0;
    	int totalEtc = 0;
    	int totalFee = 0;
    	int[] feeArr =new int[8];
    	
    	Class.forName("oracle.jdbc.driver.OracleDriver");
    	conn = DriverManager.getConnection(url, dbid, dbpw);
    	String sql = "SELECT pay_tool,fee,product FROM cafe_sell_history WHERE cafe_no=3108 AND sell_date=TO_CHAR(TRUNC(sysdate),'YYYY/MM/DD')";
    	PreparedStatement pstmt = conn.prepareStatement(sql);
    	ResultSet rs = pstmt.executeQuery();
    	while (rs.next()) {
    		int pay_tool = rs.getInt("pay_tool");
    		int fee = rs.getInt("fee");
    		int product = rs.getInt("product");
    		switch (pay_tool) {
    			case 0 :
    		totalNaverPay += fee;
    		break;
    			case 1 :
    		totalKakaoPay += fee;
    		break;
    			case 2 :
    		totalCard += fee;
    		break;
    		}
    		switch (product) {
    			case 0 :
    		totalPc += fee;
    		break;
    			case 1 :
    		totalFood += fee;
    		break;
    			case 2 :
    		totalVou += fee;
    		break;
    			case 3 :
    		totalEtc += fee;
    		break;
    		}
    	}
    	totalFee += totalNaverPay + totalKakaoPay + totalCard;
    	rs.close();
    	pstmt.close();
    	conn.close();
    	feeArr[0]=totalFee;
    	feeArr[1]=totalNaverPay;
    	feeArr[2]=totalKakaoPay;
    	feeArr[3]=totalCard;
    	feeArr[4]=totalPc;
    	feeArr[5]=totalFood;
    	feeArr[6]=totalVou;
    	feeArr[7]=totalEtc;
    	return feeArr;
    }

    public int totalFee4() throws Exception {
        Connection conn = null;
        int totalFee = 0;
        Class.forName(driver);
        conn = DriverManager.getConnection(url, dbid, dbpw);
        String sql = "SELECT fee FROM cafe_sell_history WHERE cafe_no=3108 AND sell_date=TO_CHAR(TRUNC(sysdate)-4,'YYYY/MM/DD')";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            int fee = rs.getInt("fee");
            totalFee += fee;
        }
        rs.close();
        pstmt.close();
        conn.close();
        return totalFee;
    }

    public String totalCafeSeats() throws Exception {
        String cafeSeat = "";
        int totalSeats = 0;
        Class.forName(driver);
        Connection conn = DriverManager.getConnection(url, dbid, dbpw);
        String sql = "SELECT COUNT(*) FROM cafe_seats WHERE cafe_no=3108";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            totalSeats = rs.getInt("COUNT(*)");
        }
        if (totalSeats < 100) {
            cafeSeat += "0" + totalSeats;
        } else {
            cafeSeat += totalSeats;
        }
        rs.close();
        pstmt.close();
        conn.close();
        return cafeSeat;
    }

    public String remainCafeSeats() throws Exception {
        String cafeSeat = "";
        int remainSeats = 0;
        Class.forName(driver);
        Connection conn = DriverManager.getConnection(url, dbid, dbpw);
        String sql = "SELECT COUNT(*) FROM cafe_seats WHERE cafe_no=3108 AND condition=0";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            remainSeats = rs.getInt("COUNT(*)");
        }
        if (remainSeats < 100) {
            cafeSeat += "0" + remainSeats;
        } else if(remainSeats<10) {
        	cafeSeat+="00"+remainSeats;
        } else {
            cafeSeat += remainSeats;
        }
        rs.close();
        pstmt.close();
        conn.close();
        return cafeSeat;
    }

    public PayMentDTO[] getPaymentList() throws Exception {
        Connection conn = null;
        PayMentDTO[] paymentList = new PayMentDTO[7];
        for (int i = 0; i < 7; i++) {
            paymentList[i] = new PayMentDTO();
        }
        Class.forName(driver);
        conn = DriverManager.getConnection(url, dbid, dbpw);
        String sql = "SELECT pay_tool, product, fee FROM cafe_sell_history WHERE cafe_no=3108 AND sell_date=TO_CHAR(TRUNC(sysdate)-1,'YYYY/MM/DD')";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            int payTool = rs.getInt("pay_tool");
            int product = rs.getInt("product");
            int fee = rs.getInt("fee");
            switch (payTool) {
                case 0:
                    paymentList[0].setTotalNaverPay(paymentList[0].getTotalNaverPay() + fee);
                    break;
                case 1:
                    paymentList[0].setTotalKakaoPay(paymentList[0].getTotalKakaoPay() + fee);
                    break;
                case 2:
                    paymentList[0].setTotalCard(paymentList[0].getTotalCard() + fee);
                    break;
            }
            switch (product) {
                case 0:
                    paymentList[0].setTotalPc(paymentList[0].getTotalPc() + fee);
                    break;
                case 1:
                    paymentList[0].setTotalFood(paymentList[0].getTotalFood() + fee);
                    break;
                case 2:
                    paymentList[0].setTotalVou(paymentList[0].getTotalVou() + fee);
                    break;
                case 3:
                    paymentList[0].setTotalEtc(paymentList[0].getTotalEtc() + fee);
                    break;
            }
        }
        rs.close();
        pstmt.close();
        conn.close();
        return paymentList;
    }
    
    public ArrayList<PayMentDTO> sectionDate(String selectedSectionDate) throws Exception{
		ArrayList<PayMentDTO> sectionDate = new ArrayList<>();
		Connection conn = null;
		String firstyear = selectedSectionDate.split("-")[0];
		String firstmonth = selectedSectionDate.split("-")[1];
		String firstday = selectedSectionDate.split("-")[2];
		String lastyear = selectedSectionDate.split("-")[3];
		String lastmonth = selectedSectionDate.split("-")[4];
		String lastday = selectedSectionDate.split("-")[5];
		Class.forName(driver);
        conn = DriverManager.getConnection(url, dbid, dbpw);
		String sql = "SELECT pay_tool,fee,product FROM cafe_sell_history WHERE cafe_no=3108 AND sell_date>=TO_DATE('"
				+ firstyear + "/" + firstmonth + "/" + firstday + "','YYYY/MM/DD') AND sell_date<=TO_DATE('" + lastyear
				+ "/" + lastmonth + "/" + lastday + "','YYYY/MM/DD')";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			
			while (rs.next()) {
				int pay_tool = rs.getInt("pay_tool");
				int fee = rs.getInt("fee");
				int product = rs.getInt("product");
				PayMentDTO pment = new PayMentDTO(); 
				switch (pay_tool) {
					case 0:
						pment.setTotalNaverPay(fee);
					break;
					
					case 1:
						pment.setTotalKakaoPay(fee);
					break;
					
					case 2:
						pment.setTotalCard(fee);
					break;
				}
				switch (product) {
					case 0:
						pment.setTotalPc(fee);
					break;

					case 1:
						pment.setTotalFood(fee);
					break;
						
					case 2:
						pment.setTotalVou(fee);
					break;
					
					case 3:
						pment.setTotalEtc(fee);
					break;
				}
				sectionDate.add(pment);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return sectionDate;
	}
    
    public ArrayList<PayMentDTO> selectedDate(String selectedDate) throws Exception{
    	ArrayList<PayMentDTO> selectDate = new ArrayList<>();
    	Connection conn = null;
    	String year = selectedDate.split("-")[0];
		String month = selectedDate.split("-")[1];
		String day = selectedDate.split("-")[2];
    	Class.forName(driver);
    	conn = DriverManager.getConnection(url, dbid, dbpw);
    	String sql = "SELECT pay_tool,fee,product FROM cafe_sell_history WHERE cafe_no=3108 AND sell_date=TO_DATE('" + year
    			+ "/" + month + "/" + day + "','YYYY/MM/DD')";
    	try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
    		ResultSet rs = pstmt.executeQuery();
    		
    		while (rs.next()) {
    			int pay_tool = rs.getInt("pay_tool");
    			int fee = rs.getInt("fee");
    			int product = rs.getInt("product");
    			PayMentDTO pment = new PayMentDTO(); 
    			switch (pay_tool) {
    			case 0:
    				pment.setTotalNaverPay(fee);
    				break;
    				
    			case 1:
    				pment.setTotalKakaoPay(fee);
    				break;
    				
    			case 2:
    				pment.setTotalCard(fee);
    				break;
    			}
    			switch (product) {
    			case 0:
    				pment.setTotalPc(fee);
    				break;
    				
    			case 1:
    				pment.setTotalFood(fee);
    				break;
    				
    			case 2:
    				pment.setTotalVou(fee);
    				break;
    				
    			case 3:
    				pment.setTotalEtc(fee);
    				break;
    			}
    			selectDate.add(pment);
    		}
    		
    		rs.close();
    		pstmt.close();
    		conn.close();
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return selectDate;
    }
    
    public ArrayList<PayMentDTO> selectedMonth(String selectedMonth) throws Exception{
    	ArrayList<PayMentDTO> selectMonth = new ArrayList<>();
    	Connection conn = null;
    	String Monthyear = selectedMonth.split("-")[0];
		String Monthmonth = selectedMonth.split("-")[1];
		String setDay = "";
		if (Monthmonth.equals("04") || Monthmonth.equals("06") || Monthmonth.equals("09") || Monthmonth.equals("11")) {
			setDay = "30";
		} else if (Monthmonth.equals("02")) {
			setDay = "28";
		} else {
			setDay = "31";
		}
    	Class.forName(driver);
    	conn = DriverManager.getConnection(url, dbid, dbpw);
    	String sql = "SELECT pay_tool,fee,product FROM cafe_sell_history WHERE cafe_no=3108 AND sell_date>=TO_DATE('"
		+ Monthyear + "/" + Monthmonth + "/01','YYYY/MM/DD') AND sell_date<=TO_DATE('" + Monthyear + "/"
		+ Monthmonth + "/" + setDay + "','YYYY/MM/DD')";

    	try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
    		ResultSet rs = pstmt.executeQuery();
    		
    		while (rs.next()) {
    			int pay_tool = rs.getInt("pay_tool");
    			int fee = rs.getInt("fee");
    			int product = rs.getInt("product");
    			PayMentDTO pment = new PayMentDTO(); 
    			switch (pay_tool) {
	    		    case 0:
	    		        pment.setTotalNaverPay(fee);
	    		        break;
	    		    case 1:
	    		        pment.setTotalKakaoPay(fee);
	    		        break;
	    		    case 2:
	    		        pment.setTotalCard(fee);
	    		        break;
    			}

	    		switch (product) {
	    		    case 0:
	    		        pment.setTotalPc(fee);
	    		        break;
	    		    case 1:
	    		        pment.setTotalFood(fee);
	    		        break;
	    		    case 2:
	    		        pment.setTotalVou(fee);
	    		        break;
	    		    case 3:
	    		        pment.setTotalEtc(fee);
	    		        break;
	    		}

    			selectMonth.add(pment);
    		}
    		
    		rs.close();
    		pstmt.close();
    		conn.close();
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}
    	return selectMonth;
    }
    
}
