package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.NewsDTO;

public class NewsDAO {
    private String url = "jdbc:oracle:thin:@210.114.1.134:1521:xe";
    private String user = "temp";
    private String password = "1234";

    private NewsDAO() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private static NewsDAO instance = new NewsDAO();

    public static NewsDAO getInstance() {
        return instance;
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(url, user, password);
    }

    public void closeResources(ResultSet rs, PreparedStatement pstmt) {
        try {
            if (rs != null && !rs.isClosed()) {
                rs.close();
            }
            if (pstmt != null && !pstmt.isClosed()) {
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<NewsDTO> getAllNews() {
        ArrayList<NewsDTO> newsList = new ArrayList<>();
        String sql = "SELECT news_no,news_title,news_img,news_main_img,TO_CHAR(news_date,'YYYY.MM.DD.') day,news_subtitle,writer FROM news ORDER BY news_no";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                NewsDTO news = new NewsDTO();
                news.setNewsNo(rs.getInt("news_no"));
                news.setTitle(rs.getString("news_title"));
                news.setNewsImg(rs.getString("news_img"));
                news.setNewsMainImg(rs.getString("news_main_img"));
                news.setNewsDate(rs.getString("day"));
                news.setSubtitle(rs.getString("news_subtitle"));
                news.setWriter(rs.getString("writer"));
                newsList.add(news);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(null, null);
        }
        return newsList;
    }

    public NewsDTO getNewsByNo(int newsNo) {
        NewsDTO news = null;
        ResultSet rsNews = null;
        PreparedStatement pstmtNews = null;

        ResultSet rsContent = null;
        PreparedStatement pstmtContent = null;

        String sqlNews = "SELECT news_title, news_main_img, TO_CHAR(news_date, 'YYYY.MM.DD.') day, news_subtitle, writer FROM news WHERE news_no=?";
        String sqlContent = "SELECT content, content_type FROM news_content WHERE news_no=? ORDER BY content_no";

        try (Connection conn = getConnection()) {
            pstmtNews = conn.prepareStatement(sqlNews);
            pstmtNews.setInt(1, newsNo);

            rsNews = pstmtNews.executeQuery();

            pstmtContent = conn.prepareStatement(sqlContent);
            pstmtContent.setInt(1, newsNo);
            rsContent = pstmtContent.executeQuery();

            
            if (rsNews.next()) {
                news = new NewsDTO();
                news.setNewsNo(newsNo);
                news.setTitle(rsNews.getString("news_title"));
                news.setNewsMainImg(rsNews.getString("news_main_img"));
                news.setNewsDate(rsNews.getString("day"));
                news.setSubtitle(rsNews.getString("news_subtitle"));
                news.setWriter(rsNews.getString("writer"));

                ArrayList<String> contentArray = new ArrayList<>();
                ArrayList<Integer> contentTypeArray = new ArrayList<>();
                while (rsContent.next()) {
                    contentArray.add(rsContent.getString("content"));
                    contentTypeArray.add(rsContent.getInt("content_type"));
                }

                news.setContent(contentArray);
                news.setContentType(contentTypeArray);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(rsNews, pstmtNews);
            closeResources(rsContent, pstmtContent);
        }

        return news;
    }

}
