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
            position: relative;
        }

        h2 {
            color: #f1c40f;
            font-size: 48px;
            text-shadow: 0px 0px 15px rgba(255, 215, 0, 0.8);
            margin: 8px 0 20px;
        }

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
        .question-btn.answered {
            background-color: #e74c3c !important;
            cursor: not-allowed;
            opacity: 0.8;
            transform: none;
        }

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
            box-shadow: 0 10px 25px rgba(41, 128, 185, 0.7);
        }
        button.action:hover { transform: translateY(-3px); }

        #queue {
            font-size: 38px;
            font-weight: bold;
            margin-top: 25px;
            padding: 25px 40px;
            background-color: #f39c12;
            border-radius: 20px;
            color: white;
            min-width: 350px;
            display: inline-block;
            box-shadow: 0 0 25px rgba(243, 156, 18, 0.8);
        }

        /* ================== 30s Timer (top-right) ================== */
        #timer30 {
            position: absolute;
            top: 30px;
            right: 40px;
            width: 130px;
            height: 130px;
            border-radius: 50%;
            background-color: #4CAF50;
            color: white;
            font-size: 56px;
            font-weight: bold;
            display: none; /* Mặc định ẩn */
            align-items: center;
            justify-content: center;
            box-shadow: 0 0 25px rgba(76, 175, 80, 0.6);
            text-shadow: 0 0 15px rgba(255, 255, 255, 0.7);
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        /* ================== 5s Timer (beside button) ================== */
        #timer5 {
            width: 110px;
            height: 110px;
            border-radius: 50%;
            background-color: #FFD54F;
            color: black;
            display: none;
            align-items: center;
            justify-content: center;
            font-size: 52px;
            font-weight: bold;
            box-shadow: 0 0 20px rgba(255, 215, 0, 0.6);
            opacity: 1;
            transition: opacity 1s ease;
            margin-left: 20px;
        }

        /* ================== HẾT GIỜ MESSAGE ================== */
        #hetGioMessage {
            display: none;
            margin-top: 30px;
            font-family: 'Segoe UI', 'Roboto', 'Arial', sans-serif;
            font-size: 2.5em;
            color: #ff0000;
            background-color: #ffcccc;
            padding: 25px 40px;
            border-radius: 20px;
            border: 3px solid #ff4d4d;
            text-align: center;
            box-shadow: 0 4px 15px rgba(255, 69, 0, 0.3);
            width: 80%;
            max-width: 500px;
            margin-left: auto;
            margin-right: auto;
            font-weight: bold;
            animation: fadeIn 2s ease-in-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: scale(0.9); }
            100% { opacity: 1; transform: scale(1); }
        }

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
    <div id="timer30">30</div>

    <div id="questionListSection">
        <h2>Danh sách câu hỏi</h2>
        <div id="questionButtons">
            <% for (int i = 1; i <= 15; i++) { %>
            <button id="qBtn<%=i%>" class="question-btn" onclick="showQuestion(<%=i%>)"><%=i%></button>
            <% } %>
            <!-- Nút Test cho bấm chuông thử -->
            <button id="testBtn" class="question-btn" style="background-color:#f1c40f; color:black;" onclick="showTestQuestion()">Test</button>
        </div>
    </div>

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

    <div id="buzzerSection" style="display:none; margin-top:36px;">
        <h2>Yêu cầu trả lời</h2>
        <p id="queue"></p>

        <div style="display:flex; align-items:center; justify-content:center; gap:20px;">
            <%--            <button id="resetButton" class="action" onclick="resetBuzzer()">Xóa yêu cầu sai</button>--%>
            <div id="timer5">5</div>
        </div>

        <div id="hetGioMessage"><strong>Hết Giờ!</strong></div>
    </div>
</div>
<script> window.history.pushState({}, "", "****"); </script>

<script>
    const questions = [
        {q:"Thủ đô của Việt Nam là gì?",opts:["A. Hồ Chí Minh","B. Hà Nội","C. Đà Nẵng","D. Hải Phòng"],a:"B. Hà Nội"},
        {q:"5 × 6 = ?",opts:["A. 30","B. 25","C. 35","D. 20"],a:"A. 30"},
        {q:"Ai là người đầu tiên đặt chân lên Mặt Trăng?",opts:["A. Neil Armstrong","B. Yuri Gagarin","C. Buzz Aldrin","D. John Glenn"],a:"A. Neil Armstrong"},
        {q:"Nguyên tố có ký hiệu 'O' là gì?",opts:["A. Vàng","B. Oxi","C. Bạc","D. Sắt"],a:"B. Oxi"},
        {q:"Năm nhuận có bao nhiêu ngày?",opts:["A. 365","B. 366","C. 364","D. 367"],a:"B. 366"},
        {q:"Trái Đất quay quanh Mặt Trời theo quỹ đạo gì?",opts:["A. Tròn","B. Elip","C. Vuông","D. Tam giác"],a:"B. Elip"},
        {q:"Tác giả 'Truyện Kiều' là ai?",opts:["A. Nguyễn Trãi","B. Nguyễn Du","C. Hồ Xuân Hương","D. Tố Hữu"],a:"B. Nguyễn Du"},
        {q:"Quốc gia có diện tích lớn nhất thế giới?",opts:["A. Mỹ","B. Trung Quốc","C. Nga","D. Canada"],a:"C. Nga"},
        {q:"CPU là viết tắt của?",opts:["A. Central Processing Unit","B. Computer Power Unit","C. Core Processor Utility","D. Central Power Unit"],a:"A. Central Processing Unit"},
        {q:"Hệ điều hành do Google phát triển?",opts:["A. iOS","B. Android","C. Windows","D. Linux"],a:"B. Android"},
        {q:"π (pi) xấp xỉ bằng?",opts:["A. 2.14","B. 3.14","C. 3.41","D. 4.13"],a:"B. 3.14"},
        {q:"Biểu tượng của Trung Quốc là?",opts:["A. Sư tử","B. Rồng","C. Gấu trúc","D. Hổ"],a:"C. Gấu trúc"},
        {q:"Đơn vị đo cường độ dòng điện là?",opts:["A. Watt","B. Volt","C. Ampere","D. Ohm"],a:"C. Ampere"},
        {q:"Nước tổ chức World Cup 2022?",opts:["A. Nga","B. Qatar","C. Brazil","D. Đức"],a:"B. Qatar"},
        {q:"Einstein nổi tiếng với thuyết gì?",opts:["A. Tiến hoá","B. Tương đối","C. Lượng tử","D. Big Bang"],a:"B. Tương đối"}
    ];

    const beepSound = new Audio('<%= request.getContextPath() %>/music/beep.mp3');
    beepSound.volume = 0.8;
    const bellSound = new Audio('<%= request.getContextPath() %>/music/bell.mp3');
    bellSound.volume = 0.7;

    let timer30, timer5, pausedTime = 0, timeLeft30 = 30, timeLeft5 = 5;
    let timerRunning30 = false, isPaused = false;

    const timer30Display = document.getElementById("timer30");
    const timer5Display = document.getElementById("timer5");
    const hetGioMessage = document.getElementById("hetGioMessage");
    const queueElement = document.getElementById("queue");
    let currentQuestion = null;

    function startTimer30() {
        clearInterval(timer30);
        timeLeft30 = 30;
        timerRunning30 = true;
        isPaused = false;
        hetGioMessage.style.display = "none";
        timer30Display.textContent = timeLeft30;

        timer30 = setInterval(() => {
            if (queueElement.innerText.trim() !== "") {
                pausedTime = timeLeft30;
                clearInterval(timer30);
                isPaused = true;
                startTimer5();
                return;
            }
            if (timeLeft30 <= 0) {
                clearInterval(timer30);
                showHetGio();
            } else timer30Display.textContent = --timeLeft30;
        }, 1000);
    }

    function startTimer5() {
        clearInterval(timer5);
        timeLeft5 = 5;
        timer5Display.style.display = "flex";
        timer5Display.style.opacity = "1";
        timer5Display.textContent = timeLeft5;

        timer5 = setInterval(() => {
            if (timeLeft5 <= 0) {
                clearInterval(timer5);
                timer5Display.style.opacity = "0";
                setTimeout(() => timer5Display.style.display = "none", 1000);
                resetBuzzer(); // Gọi reset
            } else timer5Display.textContent = --timeLeft5;
        }, 1000);
    }

    function continueTimer30() {
        clearInterval(timer30);
        timeLeft30 = pausedTime;
        timerRunning30 = true;
        timer30Display.textContent = timeLeft30;

        timer30 = setInterval(() => {
            if (queueElement.innerText.trim() !== "") {
                pausedTime = timeLeft30;
                clearInterval(timer30);
                isPaused = true;
                startTimer5();
                return;
            }
            if (timeLeft30 <= 0) {
                clearInterval(timer30);
                showHetGio();
            } else timer30Display.textContent = --timeLeft30;
        }, 1000);
    }

    function showHetGio() {
        hetGioMessage.style.display = "block";
        hetGioMessage.textContent = "HẾT GIỜ!";
        beepSound.play();
    }

    let previousColor = '#f39c12';
    function fetchBuzzerQueue() {
        fetch('BuzzerServlet')
            .then(resp => resp.text())
            .then(data => {
                let newColor = '#f39c12';
                if (!data || data.trim() === "" || data === "none") {
                    queueElement.innerText = "";
                } else {
                    const parts = data.split("|");
                    const playerName = parts[0] || data;
                    const sourcePage = parts[1] || "";
                    queueElement.innerText = playerName;
                    if (sourcePage === "player1.jsp") newColor = '#ff4d4d';
                    else if (sourcePage === "player2.jsp") newColor = '#3498db';
                }
                if (newColor !== previousColor && queueElement.innerText !== "") bellSound.play();
                queueElement.style.backgroundColor = newColor;
                previousColor = newColor;
            });
    }
    setInterval(fetchBuzzerQueue, 2000);

    function showQuestion(num) {
        const q = questions[num - 1];
        if (!q) return alert("Câu hỏi chưa có.");
        currentQuestion = num;
        document.getElementById("questionListSection").style.display = "none";
        document.getElementById("questionBox").style.display = "block";
        document.getElementById("buzzerSection").style.display = "block";

        // Hiển thị đồng hồ 30s
        timer30Display.style.display = "flex";

        document.getElementById("questionBox").querySelector("h2").innerText = "Câu hỏi " + num;
        document.getElementById("questionText").innerText = q.q;
        document.getElementById("options").innerHTML = q.opts.join("<br>");
        document.getElementById("answerBox").style.display = "none";
        document.getElementById("showAnswerBtn").style.display = "inline-block";
        document.getElementById("backBtn").style.display = "none";
        document.getElementById("answerBox").innerText = "Đáp án đúng: " + q.a;

        startTimer30();
    }

    function showAnswer() {
        document.getElementById("answerBox").style.display = "block";
        document.getElementById("showAnswerBtn").style.display = "none";
        document.getElementById("backBtn").style.display = "inline-block";
    }

    function goBack() {
        document.getElementById("questionListSection").style.display = "block";
        document.getElementById("questionBox").style.display = "none";
        document.getElementById("buzzerSection").style.display = "none";

        // Ẩn đồng hồ 30s
        timer30Display.style.display = "none";

        clearInterval(timer30);
        clearInterval(timer5);
        if (currentQuestion) {
            const btn = document.getElementById("qBtn" + currentQuestion);
            btn.classList.add("answered");
            btn.disabled = true;
        }
    }

    function resetBuzzer() {
        fetch('BuzzerServlet', {
            method: 'POST',
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'action=reset'
        }).then(() => {
            queueElement.innerText = "";
            queueElement.style.backgroundColor = '#f39c12';
            previousColor = '#f39c12';

            // Giữ trạng thái pause, chờ click vào 30s
            if (isPaused) {
                isPaused = true;
            }
        });
    }

    // Click vào #timer30 để tiếp tục đếm
    timer30Display.addEventListener("click", () => {
        if (isPaused) {
            isPaused = false;
            continueTimer30();
        }
    });
</script>
<script>
    // Câu hỏi thử cho nút Test
    const testQuestion = {
        q: "Câu hỏi thử chuông: 2 + 2 = ?",
        opts: ["A. 3","B. 4","C. 5","D. 6"],
        a: "B. 4"
    };

    // Hàm hiển thị câu hỏi Test
    function showTestQuestion() {
        currentQuestion = null; // Không đánh dấu là câu hỏi chính

        document.getElementById("questionListSection").style.display = "none";
        document.getElementById("questionBox").style.display = "block";
        document.getElementById("buzzerSection").style.display = "block";

        // Hiển thị đồng hồ 30s
        timer30Display.style.display = "flex";

        document.getElementById("questionBox").querySelector("h2").innerText = "Câu hỏi Test";
        document.getElementById("questionText").innerText = testQuestion.q;
        document.getElementById("options").innerHTML = testQuestion.opts.join("<br>");
        document.getElementById("answerBox").style.display = "none";
        document.getElementById("showAnswerBtn").style.display = "inline-block";
        document.getElementById("backBtn").style.display = "none";
        document.getElementById("answerBox").innerText = "Đáp án đúng: " + testQuestion.a;

        startTimer30();
    }
</script>
</body>
</html>
