import java.io.IOException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "BuzzerServlet", value = "/BuzzerServlet")
public class BuzzerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final BlockingQueue<String> buzzerQueue = new LinkedBlockingQueue<>();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        // Trả về dữ liệu dạng "Tên người chơi|sourcePage"
        String data = buzzerQueue.peek() != null ? buzzerQueue.peek() : "none";
        response.getWriter().write(data);
    }

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

        if (player != null && sourcePage != null && !buzzerQueue.contains(player + "|" + sourcePage)) {
            buzzerQueue.offer(player + "|" + sourcePage);
        }

        response.sendRedirect("admin.jsp");
    }

    public static String acceptFirstRequest() {
        return buzzerQueue.poll();
    }
}
