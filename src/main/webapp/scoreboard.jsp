<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bảng điểm - Gameshow</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(to bottom right, #1e3c72, #2a5298);
            color: #fff;
            margin: 0;
            padding: 40px;
            text-align: center;
        }

        h1 {
            font-size: 48px;
            text-shadow: 0px 0px 15px rgba(255,255,255,0.5);
            margin-bottom: 20px;
        }

        .controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;
        }

        .dropdown {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
        }

        select {
            padding: 10px 15px;
            font-size: 18px;
            border-radius: 10px;
            border: none;
            outline: none;
            cursor: pointer;
        }

        .scoreboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 20px;
            max-width: 1000px;
            margin: 0 auto 30px;
        }

        .team-card {
            background: rgba(255,255,255,0.15);
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .team-card:hover {
            transform: scale(1.05);
        }

        .team-name {
            font-size: 22px;
            font-weight: bold;
            color: #ffeb3b;
            margin-bottom: 15px;
        }

        .team-name[contenteditable="true"] {
            background: rgba(255,255,255,0.2);
            border-radius: 8px;
            padding: 5px;
        }

        .score {
            font-size: 64px;
            font-weight: bold;
            margin: 15px 0;
            color: #ffffff;
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        .buttons button {
            font-size: 22px;
            width: 45px;
            height: 45px;
            border: none;
            border-radius: 10px;
            background-color: #27ae60;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .buttons button:hover {
            background-color: #2ecc71;
        }

        .buttons button.minus {
            background-color: #c0392b;
        }

        .buttons button.minus:hover {
            background-color: #e74c3c;
        }

        .reset-btn {
            margin-top: 30px;
            padding: 15px 40px;
            font-size: 22px;
            border: none;
            border-radius: 30px;
            background: linear-gradient(to right, #f39c12, #e67e22);
            color: white;
            cursor: pointer;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            transition: 0.3s;
        }

        .reset-btn:hover {
            background: linear-gradient(to right, #e67e22, #f1c40f);
        }
    </style>

    <script>
        let mode = "score"; // "score" hoặc "edit"
        let numTeams = 10;

        function createScoreboard() {
            const container = document.getElementById("scoreboard");
            container.innerHTML = "";

            for (let i = 1; i <= numTeams; i++) {
                const card = document.createElement("div");
                card.className = "team-card";

                const name = document.createElement("div");
                name.className = "team-name";
                name.id = "teamName" + i;
                name.textContent = "Đội " + i;
                name.contentEditable = (mode === "edit");

                const score = document.createElement("div");
                score.className = "score";
                score.id = "score" + i;
                score.textContent = "0";

                const btns = document.createElement("div");
                btns.className = "buttons";

                const plusBtn = document.createElement("button");
                plusBtn.textContent = "+";
                plusBtn.onclick = () => updateScore(i, 10);

                const minusBtn = document.createElement("button");
                minusBtn.textContent = "-";
                minusBtn.classList.add("minus");
                minusBtn.onclick = () => updateScore(i, -10);

                btns.appendChild(plusBtn);
                btns.appendChild(minusBtn);

                card.appendChild(name);
                card.appendChild(score);
                card.appendChild(btns);

                container.appendChild(card);
            }
        }

        function updateScore(id, change) {
            if (mode !== "score") return;

            const scoreEl = document.getElementById("score" + id);
            let current = parseInt(scoreEl.textContent);
            scoreEl.textContent = current + change;
        }

        function resetScores() {
            for (let i = 1; i <= numTeams; i++) {
                document.getElementById("score" + i).textContent = "0";
            }
        }

        function changeNumTeams() {
            numTeams = parseInt(document.getElementById("numTeams").value);
            createScoreboard();
        }

        function changeMode() {
            mode = document.getElementById("mode").value;
            for (let i = 1; i <= numTeams; i++) {
                const nameEl = document.getElementById("teamName" + i);
                nameEl.contentEditable = (mode === "edit");
            }
        }

        window.onload = createScoreboard;
    </script>
</head>

<body>
<h1>BẢNG ĐIỂM</h1>

<div class="controls">
    <div class="dropdown">
        <label for="numTeams">Số đội chơi</label>
        <select id="numTeams" onchange="changeNumTeams()">
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
            <option value="6">6</option>
            <option value="7">7</option>
            <option value="8">8</option>
            <option value="9">9</option>
            <option value="10" selected>10</option>
        </select>
    </div>

    <div class="dropdown">
        <label for="mode">Chế độ</label>
        <select id="mode" onchange="changeMode()">
            <option value="score" selected>Ghi điểm</option>
            <option value="edit">Chỉnh sửa</option>
        </select>
    </div>
</div>

<div id="scoreboard" class="scoreboard"></div>

<button class="reset-btn" onclick="resetScores()">Reset</button>
</body>
</html>
