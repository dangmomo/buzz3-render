<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin - Gameshow</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: linear-gradient(to bottom, #1e2a47, #4c6b8b);
            color: white;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .container {
            background: rgba(0, 0, 0, 0.6);
            padding: 50px;
            border-radius: 20px;
            box-shadow: 0px 15px 60px rgba(0, 0, 0, 0.8);
            text-align: center;
            width: 90%;
            max-width: 1400px;
        }

        h2 {
            color: #f1c40f;
            font-size: 48px;
            text-shadow: 0px 0px 15px rgba(255, 215, 0, 0.8);
            margin: 8px 0 20px;
        }

        /* Lưới nút câu hỏi: 5 cột */
        #questionButtons {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 25px;
            justify-items: center;
            margin-top: 20px;
        }

        .question-btn {
            background-color: #27ae60;
            border: none;
            color: white;
            font-size: 28px;
            border-radius: 50%;
            width: 100px;
            height: 100px;
            cursor: pointer;
            box-shadow: 0px 8px 20px rgba(39, 174, 96, 0.6);
            transition: 0.25s;
        }
        .question-btn:hover { transform: scale(1.08); background-color: #2ecc71; }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        table td {
            padding: 25px 30px;
            text-align: center;
            border: 2px solid #ecf0f1;
            font-size: 36px;
            background-color: #34495e;
            color: #ffffff;
        }

        .answer {
            font-size: 40px;
            color: #2ecc71;
            font-weight: bold;
            margin-top: 20px;
        }

        button.action {
            margin-top: 20px;
            font-size: 28px;
            padding: 18px 40px;
            background: linear-gradient(to right, #3498db, #2980b9);
            color: white;
            border: none;
            border-radius: 35px;
            cursor: pointer;
            transition: 0.25s;
            box-shadow: 0px 10px 25px rgba(41, 128, 185, 0.7);
        }
        button.action:hover { transform: translateY(-3px); }

        #queue {
            font-size: 36px;
            font-weight: bold;
            margin-top: 20px;
            padding: 20px 30px;
            background-color: #f39c12;
            border-radius: 15px;
            color: white;
            min-width: 300px;
            display: inline-block;
        }

        /* nhỏ gọn trên mobile */
        @media (max-width: 900px) {
            #questionButtons { grid-template-columns: repeat(3, 1fr); }
            .question-btn { width: 84px; height: 84px; font-size: 22px; }
            h2 { font-size: 36px; }
            table td { font-size: 24px; padding: 18px; }
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Danh sách câu hỏi (mặc định hiện) -->
    <div id="questionListSection">
        <h2>Danh sách câu hỏi</h2>
        <div id="questionButtons">
            <% for (int i = 1; i <= 15; i++) { %>
            <button class="question-btn" onclick="showQuestion(<%=i%>)"><%=i%></button>
            <% } %>
        </div>
    </div>

    <!-- Khu vực hiển thị câu hỏi (mặc định ẩn) -->
    <div id="questionBox" style="display:none;">
        <h2>Câu hỏi</h2>
        <table>
            <tr><td id="questionText"></td></tr>
            <tr><td id="options" style="font-size:34px; line-height:1.8; text-align:left;"></td></tr>
        </table>

        <div>
            <button id="showAnswerBtn" class="action" onclick="showAnswer()">Hiện đáp án</button>
            <button id="backBtn" class="action" style="display:none; margin-left:12px;" onclick="goBack()">Quay lại</button>
        </div>

        <div id="answerBox" class="answer" style="display:none;"></div>
    </div>

    <!-- Khu vực Buzzer / Yêu cầu trả lời:
         Mặc định ẩn => chỉ hiện khi ấn 1 câu hỏi -->
    <div id="buzzerSection" style="display:none; margin-top:36px;">
        <h2>Yêu cầu trả lời</h2>
        <p id="queue"></p>
        <div style="margin-top: 20px; text-align: center;">
            <button id="resetButton" class="action" onclick="resetBuzzer()">Xóa yêu cầu sai</button>
        </div>
    </div>
</div>

<script>
    // ----- Dữ liệu 15 câu trắc nghiệm -----
    const questions = [
        {q: "Thủ đô của Việt Nam là gì?", opts: ["A. Hồ Chí Minh", "B. Hà Nội", "C. Đà Nẵng", "D. Hải Phòng"], a: "B. Hà Nội"},
        {q: "5 × 6 = ?", opts: ["A. 30", "B. 25", "C. 35", "D. 20"], a: "A. 30"},
        {q: "Ai là người đầu tiên đặt chân lên Mặt Trăng?", opts: ["A. Neil Armstrong", "B. Yuri Gagarin", "C. Buzz Aldrin", "D. John Glenn"], a: "A. Neil Armstrong"},
        {q: "Nguyên tố có ký hiệu 'O' là gì?", opts: ["A. Vàng", "B. Oxi", "C. Bạc", "D. Sắt"], a: "B. Oxi"},
        {q: "Năm nhuận có bao nhiêu ngày?", opts: ["A. 365", "B. 366", "C. 364", "D. 367"], a: "B. 366"},
        {q: "Trái Đất quay quanh Mặt Trời theo quỹ đạo gì?", opts: ["A. Tròn", "B. Elip", "C. Vuông", "D. Tam giác"], a: "B. Elip"},
        {q: "Tác giả 'Truyện Kiều' là ai?", opts: ["A. Nguyễn Trãi", "B. Nguyễn Du", "C. Hồ Xuân Hương", "D. Tố Hữu"], a: "B. Nguyễn Du"},
        {q: "Quốc gia có diện tích lớn nhất thế giới?", opts: ["A. Mỹ", "B. Trung Quốc", "C. Nga", "D. Canada"], a: "C. Nga"},
        {q: "CPU là viết tắt của?", opts: ["A. Central Processing Unit", "B. Computer Power Unit", "C. Core Processor Utility", "D. Central Power Unit"], a: "A. Central Processing Unit"},
        {q: "Hệ điều hành do Google phát triển?", opts: ["A. iOS", "B. Android", "C. Windows", "D. Linux"], a: "B. Android"},
        {q: "π (pi) xấp xỉ bằng?", opts: ["A. 2.14", "B. 3.14", "C. 3.41", "D. 4.13"], a: "B. 3.14"},
        {q: "Biểu tượng của Trung Quốc là?", opts: ["A. Sư tử", "B. Rồng", "C. Gấu trúc", "D. Hổ"], a: "C. Gấu trúc"},
        {q: "Đơn vị đo cường độ dòng điện là?", opts: ["A. Watt", "B. Volt", "C. Ampere", "D. Ohm"], a: "C. Ampere"},
        {q: "Nước tổ chức World Cup 2022?", opts: ["A. Nga", "B. Qatar", "C. Brazil", "D. Đức"], a: "B. Qatar"},
        {q: "Einstein nổi tiếng với thuyết gì?", opts: ["A. Tiến hoá", "B. Tương đối", "C. Lượng tử", "D. Big Bang"], a: "B. Tương đối"}
    ];

    // ----- Buzzer polling & sound (vẫn chạy) -----
    var previousColor = '#f39c12';
    var buzzerSound = new Audio('<%= request.getContextPath() %>/music/bell.mp3');
    buzzerSound.volume = 0.7;

    function fetchBuzzerQueue() {
        fetch('BuzzerServlet')
            .then(resp => resp.text())
            .then(data => {
                var queueElement = document.getElementById('queue');
                var newColor = '#f39c12';
                if (!data || data.trim() === "" || data === "none") {
                    queueElement.innerText = "";
                } else {
                    var parts = data.split("|");
                    var playerName = parts[0] || data;
                    var sourcePage = parts[1] || "";
                    queueElement.innerText = playerName;
                    if (sourcePage === "player1.jsp") newColor = '#ff4d4d';
                    else if (sourcePage === "player2.jsp") newColor = '#3498db';
                }
                if (newColor !== previousColor && queueElement.innerText !== "") {
                    try { buzzerSound.play(); } catch(e){/* ignore autoplay issues */ }
                }
                queueElement.style.backgroundColor = newColor;
                previousColor = newColor;
            })
            .catch(err => console.error("Lỗi khi tải yêu cầu:", err));
    }
    // Poll every 2s (keeps updating queue when buzzerSection visible)
    setInterval(fetchBuzzerQueue, 2000);

    // ----- UI logic -----
    function showQuestion(num) {
        const q = questions[num - 1];
        if (!q) return alert("Câu hỏi chưa được thêm.");
        // ẩn danh sách, hiện khu vực câu hỏi và hiển thị buzzer section
        document.getElementById("questionListSection").style.display = "none";
        document.getElementById("questionBox").style.display = "block";
        document.getElementById("buzzerSection").style.display = "block"; // <-- hiện yêu cầu trả lời khi chọn câu
        // điền nội dung
        document.getElementById("questionText").innerText = q.q;
        // tạo options (A-D) mỗi dòng
        document.getElementById("options").innerHTML = q.opts.map((o, i) => {
            return (i === 0 ? "" : "") + o;
        }).join("<br>");
        document.getElementById("answerBox").style.display = "none";
        document.getElementById("showAnswerBtn").style.display = "inline-block";
        document.getElementById("backBtn").style.display = "none";
        document.getElementById("answerBox").innerText = "Đáp án đúng: " + q.a;
        // reset queue color/text (không bắt buộc)
        // document.getElementById('queue').innerText = "";
    }

    function showAnswer() {
        document.getElementById("answerBox").style.display = "block";
        document.getElementById("showAnswerBtn").style.display = "none";
        document.getElementById("backBtn").style.display = "inline-block";
    }

    function goBack() {
        // khi quay lại danh sách: hiện danh sách, ẩn questionBox, ẩn buzzerSection
        document.getElementById("questionListSection").style.display = "block";
        document.getElementById("questionBox").style.display = "none";
        document.getElementById("buzzerSection").style.display = "none";
    }

    function resetBuzzer() {
        fetch('BuzzerServlet', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=reset'
        }).then(() => {
            document.getElementById('queue').innerText = "";
            document.getElementById('queue').style.backgroundColor = '#f39c12';
            previousColor = '#f39c12';
        }).catch(err => console.error(err));
    }

    // ban đầu: ensure buzzerSection hidden (already via inline style)
    // fetchBuzzerQueue can still run in background updating #queue; buzzerSection hidden so not visible.
</script>
</body>
</html>
