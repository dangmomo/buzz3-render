//package dao;
//
//import model.Round1Question;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class Round1QuestionDAO {
//    private static final String URL = "jdbc:mysql://localhost:3306/buzz";
//    private static final String USER = "root";
//    private static final String PASSWORD = "root";
//
//    public Round1QuestionDAO() {
//        try {
//            Class.forName("com.mysql.cj.jdbc.Driver");
//        } catch (ClassNotFoundException e) {
//            e.printStackTrace();
//        }
//    }
//
//    // 1. Lấy danh sách tất cả câu hỏi
//    public List<Round1Question> getAllQuestions() {
//        List<Round1Question> questionList = new ArrayList<>();
//        String sql = "SELECT * FROM buzz.round1_questions";
//
//        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
//             Statement stmt = conn.createStatement();
//             ResultSet rs = stmt.executeQuery(sql)) {
//
//            while (rs.next()) {
//                Round1Question question = new Round1Question(
//                        rs.getInt("id"),
//                        rs.getString("category"),
//                        rs.getString("question"),
//                        rs.getBoolean("is_multiple_choice"),
//                        rs.getString("option_a"),
//                        rs.getString("option_b"),
//                        rs.getString("option_c"),
//                        rs.getString("option_d"),
//                        rs.getString("correct_answer"),
//                        rs.getString("explanation")
//                );
//                questionList.add(question);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return questionList;
//    }
//
//    // 2. Lấy một câu hỏi theo ID
//    public Round1Question getQuestionById(int id) {
//        String sql = "SELECT * FROM buzz.round1_questions WHERE id = ?";
//
//        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//
//            pstmt.setInt(1, id);
//            ResultSet rs = pstmt.executeQuery();
//
//            if (rs.next()) {
//                return new Round1Question(
//                        rs.getInt("id"),
//                        rs.getString("category"),
//                        rs.getString("question"),
//                        rs.getBoolean("is_multiple_choice"),
//                        rs.getString("option_a"),
//                        rs.getString("option_b"),
//                        rs.getString("option_c"),
//                        rs.getString("option_d"),
//                        rs.getString("correct_answer"),
//                        rs.getString("explanation")
//                );
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return null;
//    }
//
//    // 3. Thêm một câu hỏi mới
//    public boolean insertQuestion(Round1Question question) {
//        String sql = "INSERT INTO buzz.round1_questions (category, question, is_multiple_choice, option_a, option_b, option_c, option_d, correct_answer, explanation) " +
//                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//
//            pstmt.setString(1, question.getCategory());
//            pstmt.setString(2, question.getQuestion());
//            pstmt.setBoolean(3, question.isMultipleChoice());
//            pstmt.setString(4, question.getOptionA());
//            pstmt.setString(5, question.getOptionB());
//            pstmt.setString(6, question.getOptionC());
//            pstmt.setString(7, question.getOptionD());
//            pstmt.setString(8, question.getCorrectAnswer());
//            pstmt.setString(9, question.getExplanation());
//
//            return pstmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//
//    // 4. Cập nhật câu hỏi
//    public boolean updateQuestion(Round1Question question) {
//        String sql = "UPDATE buzz.round1_questions SET category = ?, question = ?, is_multiple_choice = ?, option_a = ?, option_b = ?, option_c = ?, option_d = ?, correct_answer = ?, explanation = ? WHERE id = ?";
//
//        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//
//            pstmt.setString(1, question.getCategory());
//            pstmt.setString(2, question.getQuestion());
//            pstmt.setBoolean(3, question.isMultipleChoice());
//            pstmt.setString(4, question.getOptionA());
//            pstmt.setString(5, question.getOptionB());
//            pstmt.setString(6, question.getOptionC());
//            pstmt.setString(7, question.getOptionD());
//            pstmt.setString(8, question.getCorrectAnswer());
//            pstmt.setString(9, question.getExplanation());
//            pstmt.setInt(10, question.getId());
//
//            return pstmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//
//    // 5. Xóa câu hỏi
//    public boolean deleteQuestion(int id) {
//        String sql = "DELETE FROM buzz.round1_questions WHERE id = ?";
//
//        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
//             PreparedStatement pstmt = conn.prepareStatement(sql)) {
//
//            pstmt.setInt(1, id);
//            return pstmt.executeUpdate() > 0;
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return false;
//    }
//}
