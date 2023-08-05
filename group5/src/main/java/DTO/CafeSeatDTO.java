package DTO;

public class CafeSeatDTO {
    private int seatNo;
    private int cafeNo;
    private int regNo;
    private int condition;
    private String startTime;
    private String endTime;
    private int totalFee;
    
    public int getSeatNo() {
        return seatNo;
    }
    
    public void setSeatNo(int seatNo) {
        this.seatNo = seatNo;
    }
    
    public int getCafeNo() {
        return cafeNo;
    }
    
    public void setCafeNo(int cafeNo) {
        this.cafeNo = cafeNo;
    }
    
    public int getRegNo() {
        return regNo;
    }
    
    public void setRegNo(int regNo) {
        this.regNo = regNo;
    }
    
    public int getCondition() {
        return condition;
    }
    
    public void setCondition(int condition) {
        this.condition = condition;
    }
    
    public String getStartTime() {
        return startTime;
    }
    
    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }
    
    public String getEndTime() {
        return endTime;
    }
    
    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }
    
    public int getTotalFee() {
        return totalFee;
    }
    
    public void setTotalFee(int totalFee) {
        this.totalFee = totalFee;
    }
}
