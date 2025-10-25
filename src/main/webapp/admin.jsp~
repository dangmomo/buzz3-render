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

        .question-btn {
            border: none;
            color: white;
            font-size: 28px;
            border-radius: 50%;
            width: 100px;
            height: 100px;
            cursor: pointer;
            transition: 0.25s;
        }
        .question-btn:hover { transform: scale(1.08); }
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
            display: none;
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

        #hetGioMessage {
            display: none;
            margin-top: 30px;
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

        /* ======= CSS hiển thị phân chia 2 phần ======= */
        #questionButtons {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 25px;
            justify-items: center;
            margin-top: 20px;
        }

        .section-title {
            grid-column: span 5;
            text-align: center;
            font-weight: bold;
            font-size: 22px;
            color: #f1c40f;
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.4);
            margin-top: 15px;
        }

        .part1 {
            background-color: #00CED1;
            box-shadow: 0px 8px 20px rgba(0, 206, 209, 0.6);
        }
        .part1:hover { background-color: #20B2AA; }

        .part2 {
            background-color: #27ae60;
            box-shadow: 0px 8px 20px rgba(39, 174, 96, 0.6);
        }
        .part2:hover { background-color: #2ecc71; }

        /* ======= ẢNH ĐUỔI HÌNH BẮT CHỮ ======= */
        #questionText {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        #questionText img {
            width: 420px; /* bạn có thể chỉnh 350px hoặc 500px tùy kích thước màn hình */
            height: auto;
            border-radius: 15px;
            box-shadow: 0 0 25px rgba(255, 255, 255, 0.4);
            transition: transform 0.3s ease;
        }

        #questionText img:hover {
            transform: scale(1.05);
        }

    </style>
</head>
<body>
<div class="container">
    <div id="timer30">30</div>

    <!-- ========== DANH SÁCH CÂU HỎI (ĐÃ CẬP NHẬT) ========== -->
    <div id="questionListSection">
        <h2>Danh sách câu hỏi</h2>

        <div id="questionButtons">
            <div class="section-title">Phần chơi 1: Đuổi hình bắt chữ</div>

            <% for (int i = 1; i <= 5; i++) { %>
            <button id="qBtn<%=i%>" class="question-btn part1" onclick="showQuestion(<%=i%>)"><%=i%></button>
            <% } %>

            <div class="section-title">Phần chơi 2: Trắc nghiệm thần tốc</div>

            <% for (int i = 6; i <= 15; i++) { %>
            <button id="qBtn<%=i%>" class="question-btn part2" onclick="showQuestion(<%=i%>)"><%=i - 5%></button>
            <% } %>

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
            <div id="timer5">5</div>
        </div>
        <div id="hetGioMessage"><strong>Hết Giờ!</strong></div>
    </div>
</div>
<script> window.history.pushState({}, "", "****"); </script>

<script>
    const questions = [
        // 5 câu đầu: Đuổi hình bắt chữ (mỗi câu 2 ảnh)
        {
            type: "picture",
            images: [
                "<%= request.getContextPath() %>/images/duoihinh1a.png",
                "<%= request.getContextPath() %>/images/duoihinh1b.png"
            ],
            a: "Độc quyền"
        },
        {
            type: "picture",
            images: [
                "<%= request.getContextPath() %>/images/duoihinh2a.png",
                "<%= request.getContextPath() %>/images/duoihinh2b.png",
                "<%= request.getContextPath() %>/images/duoihinh2c.png"
            ],
            a: "Độc quyền nhà nước"
        },
        {
            type: "picture",
            images: [
                "<%= request.getContextPath() %>/images/duoihinh3a.png",
                "<%= request.getContextPath() %>/images/duoihinh3b.png"
            ],
            a: "Cô la"
        },
        {
            type: "picture",
            images: [
                "<%= request.getContextPath() %>/images/duoihinh4a.png",
                "<%= request.getContextPath() %>/images/duoihinh4b.png"
            ],
            a: "Meta"
        },
        {
            type: "picture",
            images: [
                "<%= request.getContextPath() %>/images/duoihinh5a.png",
                "<%= request.getContextPath() %>/images/duoihinh5b.png"
            ],
            a: "Microsoft"
        },

        // 10 câu còn lại: Trắc nghiệm như cũ
        {q:"Theo Kinh tế Chính trị Mác – Lênin, Cạnh tranh là gì?",
            opts:["A. Là sự ganh đua giữa những người sản xuất hàng hóa nhằm thu được lợi nhuận cao hơn.",
                "B. Là sự đấu tranh giai cấp giữa giai cấp tư sản và giai cấp vô sản.",
                "C. Là sự tranh giành thị trường giữa các quốc gia.",
                "D. Là sự hợp tác giữa các doanh nghiệp để tăng cường năng lực sản xuất."],
            a:"A. Là sự ganh đua giữa những người sản xuất hàng hóa nhằm thu được lợi nhuận cao hơn."},

        {q:"Quy luật cơ bản nào của sản xuất hàng hóa chi phối sự xuất hiện và vận động của cạnh tranh?",
            opts:["A. Quy luật Cung – Cầu.",
                "B. Quy luật Lưu thông tiền tệ.",
                "C. Quy luật Giá trị.",
                "D. Quy luật Tích lũy tư bản."],
            a:"C. Quy luật Giá trị."},

        {q:"Kết quả trực tiếp của Cạnh tranh trong nội bộ ngành là gì?",
            opts:["A. Hình thành tỷ suất lợi nhuận bình quân.",
                "B. Hình thành giá trị thị trường (giá trị xã hội).",
                "C. Hình thành giá cả sản xuất.",
                "D. Hình thành mức giá độc quyền."],
            a:"B. Hình thành giá trị thị trường (giá trị xã hội)."},

        {q:"Kết quả trực tiếp của Cạnh tranh ngoài ngành là gì?",
            opts:["A. Hình thành tỷ suất giá trị thặng dư.",
                "B. Hình thành tỷ suất lợi nhuận độc quyền.",
                "C. Hình thành tỷ suất lợi nhuận bình quân.",
                "D. Hình thành giá trị cá biệt."],
            a:"C. Hình thành tỷ suất lợi nhuận bình quân."},

        {q:"Đặc điểm cơ bản nhất đánh dấu sự chuyển biến từ chủ nghĩa tư bản cạnh tranh tự do sang giai đoạn độc quyền (Chủ nghĩa Đế quốc) là gì?",
            opts:["A. Sự xuất hiện của lao động làm thuê.",
                "B. Sự xuất hiện của giá trị thặng dư.",
                "C. Sự thống trị của các tổ chức độc quyền trong đời sống kinh tế.",
                "D. Sự phát triển của thương mại quốc tế."],
            a:"C. Sự thống trị của các tổ chức độc quyền trong đời sống kinh tế."},

        {q:"Ngày nay, hình thức độc quyền phổ biến nhất trong nền kinh tế thị trường là gì?",
            opts:["A. Độc quyền tự nhiên (Natural Monopoly)",
                "B. Độc quyền nhà nước",
                "C. Độc quyền công nghệ (Tech Monopoly)",
                "D. Độc quyền thương mại cổ truyền"],
            a:"C. Độc quyền công nghệ (Tech Monopoly)"},

        {q:"Tập đoàn nào sau đây thường được coi là ví dụ điển hình của “độc quyền mới” trong thời đại số?",
            opts:["A. Toyota",
                "B. Microsoft",
                "C. Coca-Cola",
                "D. Samsung"],
            a:"D. Samsung"},

        {q:"“Độc quyền nhà nước” trong điều kiện hiện nay chủ yếu thể hiện ở lĩnh vực nào?",
            opts:["A. Sản xuất hàng tiêu dùng",
                "B. Năng lượng, viễn thông và tài nguyên quốc gia",
                "C. Thời trang và giải trí",
                "D. Thương mại điện tử"],
            a:"B. Năng lượng, viễn thông và tài nguyên quốc gia"},

        {q:"Vai trò tích cực của chủ nghĩa tư bản trong lịch sử phát triển kinh tế thế giới là gì?",
            opts:["A. Làm chậm tiến trình công nghiệp hóa",
                "B. Thúc đẩy tiến bộ khoa học – kỹ thuật và năng suất lao động",
                "C. Ngăn cản toàn cầu hóa kinh tế",
                "D. Làm suy yếu nhà nước"],
            a:"B. Thúc đẩy tiến bộ khoa học – kỹ thuật và năng suất lao động"},

        {q:"Tại sao nhiều quốc gia vẫn duy trì doanh nghiệp nhà nước độc quyền trong một số lĩnh vực?",
            opts:["A. Vì muốn tăng giá hàng hóa",
                "B. Vì nhà nước không tin tưởng khu vực tư nhân",
                "C. Vì cần đảm bảo an ninh, ổn định xã hội và lợi ích công cộng",
                "D. Vì doanh nghiệp nhà nước luôn hiệu quả hơn tư nhân"],
            a:"C. Vì cần đảm bảo an ninh, ổn định xã hội và lợi ích công cộng"}
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
                resetBuzzer();
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
        timer30Display.style.display = "flex";

        const qBox = document.getElementById("questionBox");
        // qBox.querySelector("h2").innerText = "Câu hỏi " + num;

        // Nếu là đuổi hình bắt chữ
        if (q.type === "picture") {
            qBox.querySelector("h2").innerText = "Câu hỏi " + num;
            let imagesHtml = q.images.map(img => `<img src="${img}" style="width:440px;height:auto;border-radius:8px;">`).join('');
            document.getElementById("questionText").innerHTML = `
        <div style="display:flex;gap:20px;justify-content:center;align-items:center;">
            ${imagesHtml}
        </div>
    `;
            document.getElementById("options").innerHTML = "";
        }
        else {
            qBox.querySelector("h2").innerText = "Câu hỏi " + (num - 5);
            document.getElementById("questionText").innerText = q.q;
            document.getElementById("options").innerHTML = q.opts.join("<br>");
        }

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
            if (isPaused) isPaused = true;
        });
    }

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
