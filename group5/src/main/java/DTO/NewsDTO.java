package DTO;

import java.util.ArrayList;

public class NewsDTO {
    private int newsNo;
    private String title;
    private String newsImg;
    private String newsMainImg;
    private String newsDate;
    private String subtitle;
    private String writer;
    private ArrayList<String> content;
    private ArrayList<Integer> contentType;

    public int getNewsNo() {
        return newsNo;
    }

    public void setNewsNo(int newsNo) {
        this.newsNo = newsNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNewsImg() {
        return newsImg;
    }

    public void setNewsImg(String newsImg) {
        this.newsImg = newsImg;
    }

    public String getNewsMainImg() {
        return newsMainImg;
    }

    public void setNewsMainImg(String newsMainImg) {
        this.newsMainImg = newsMainImg;
    }

    public String getNewsDate() {
        return newsDate;
    }

    public void setNewsDate(String newsDate) {
        this.newsDate = newsDate;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public ArrayList<String> getContent() {
        return content;
    }

    public void setContent(ArrayList<String> content) {
        this.content = content;
    }

    public ArrayList<Integer> getContentType() {
        return contentType;
    }

    public void setContentType(ArrayList<Integer> contentType) {
        this.contentType = contentType;
    }
}
