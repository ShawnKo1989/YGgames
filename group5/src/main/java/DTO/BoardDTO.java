package DTO;

public class BoardDTO {
    private int boardNo;
    private String boardTitle;
    private int upBoardNo;

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public String getBoardTitle() {
        return boardTitle;
    }

    public void setBoardTitle(String boardTitle) {
        this.boardTitle = boardTitle;
    }

    public int getUpBoardNo() {
        return upBoardNo;
    }

    public void setUpBoardNo(int upBoardNo) {
        this.upBoardNo = upBoardNo;
    }
}

