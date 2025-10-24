package com.example.servlet;

import java.io.IOException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet quản lý chức năng bấm chuông của người chơi trong gameshow.
 * Sử dụng BlockingQueue để lưu trữ thứ tự người bấm chuông.
 */
@WebServlet(name = "BuzzerServlet", value = "/BuzzerServlet")
public class BuzzerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Hàng đợi giữ các yêu cầu bấm chuông dưới dạng "Tên người chơi|sourcePage"
    private static final BlockingQueue<String> buzzerQueue = new LinkedBlockingQueue<>();

    /**
     * Xử lý GET request: trả về tên người chơi đầu tiên trong hàng đợi.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        String firstPlayer = buzzerQueue.peek() != null ? buzzerQueue.peek() : "none";
        response.getWriter().write(firstPlayer);
    }

    /**
     * Xử lý POST request:
     * - Nếu action="reset", xóa hết hàng đợi và redirect về admin.jsp
     * - Nếu có player và sourcePage, thêm vào hàng đợi nếu chưa tồn tại
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("reset".equals(action)) {
            buzzerQueue.clear();
            response.sendRedirect("admin.jsp");
            return;
        }

        String player = request.getParameter("player");
        String sourcePage = request.getParameter("sourcePage");

        if (player != null && sourcePage != null) {
            String entry = player + "|" + sourcePage;
            // Thêm vào hàng đợi nếu chưa tồn tại
            if (!buzzerQueue.contains(entry)) {
                buzzerQueue.offer(entry);
            }
        }

        response.sendRedirect("admin.jsp");
    }

    /**
     * Lấy và xóa người chơi đầu tiên trong hàng đợi (dùng cho admin hoặc game logic)
     */
    public static String acceptFirstRequest() {
        return buzzerQueue.poll();
    }
}
