<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Người chơi 1</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      background: radial-gradient(circle, #1a1a1a, #000); /* Nền tối gradient */
      color: white;
      text-align: center;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0;
    }

    .container {
      background: rgba(255, 255, 255, 0.1);
      backdrop-filter: blur(10px);
      width: 400px;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0px 10px 30px rgba(255, 0, 0, 0.5);
      text-align: center;
      border: 2px solid rgba(255, 255, 255, 0.2);
    }

    h2 {
      color: #ff4d4d;
      font-size: 28px;
      font-weight: bold;
      text-shadow: 0 0 10px rgba(255, 77, 77, 0.8);
    }

    label {
      font-size: 20px;
      font-weight: bold;
      display: block;
      margin-bottom: 10px;
    }

    input {
      width: 100%;
      padding: 12px;
      font-size: 18px;
      border: none;
      border-radius: 8px;
      margin-bottom: 20px;
      text-align: center;
      background: rgba(255, 255, 255, 0.8);
      outline: none;
    }

    button {
      background: radial-gradient(circle, #ff0000, #990000); /* Hiệu ứng bóng đèn LED */
      color: white;
      font-size: 32px;
      padding: 40px;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      transition: 0.3s;
      width: 180px;
      height: 180px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: bold;
      box-shadow: 0px 15px 40px rgba(255, 0, 0, 0.9), 0px 0px 20px rgba(255, 0, 0, 0.5);
      position: relative;
      animation: pulse 1.5s infinite alternate;
    }

    button:hover {
      background: radial-gradient(circle, #ff1a1a, #800000);
      box-shadow: 0px 20px 50px rgba(255, 0, 0, 1), 0px 0px 25px rgba(255, 0, 0, 0.8);
    }

    button:active {
      background: radial-gradient(circle, #cc0000, #660000);
      transform: scale(0.95);
      box-shadow: 0px 10px 30px rgba(255, 0, 0, 1), 0px 0px 15px rgba(255, 0, 0, 0.8);
    }

    /* Hiệu ứng đèn LED nhấp nháy */
    @keyframes pulse {
      from {
        box-shadow: 0px 10px 30px rgba(255, 0, 0, 0.8), 0px 0px 15px rgba(255, 0, 0, 0.5);
      }
      to {
        box-shadow: 0px 20px 50px rgba(255, 0, 0, 1), 0px 0px 25px rgba(255, 0, 0, 0.9);
      }
    }

    /* Hiệu ứng tin nhắn */
    .message {
      margin-top: 15px;
      font-size: 18px;
      color: #ffd700;
      text-shadow: 0px 0px 10px rgba(255, 215, 0, 0.8);
    }

  </style>

  <script>
    function submitBuzzer() {
      var playerName = document.getElementById("playerName").value;
      if (playerName.trim() === "") {
        alert("Vui lòng nhập tên của bạn!");
        return;
      }

      var xhr = new XMLHttpRequest();
      xhr.open("POST", "BuzzerServlet", true);
      xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

      // Gửi cả tên người chơi và nguồn trang (player1.jsp)
      xhr.send("player=" + encodeURIComponent(playerName) + "&sourcePage=player1.jsp");

      var audio = new Audio('<%= request.getContextPath() %>/music/bell.mp3');
      audio.volume = 0.7;
      audio.play();
    }

  </script>
</head>
<body>

<div class="container">
  <h2>Người chơi 1 - Bấm chuông</h2>

  <label for="playerName">Nhập tên của bạn:</label>
  <input type="text" id="playerName" placeholder="Nhập tên" required />

  <button onclick="submitBuzzer()">Bấm chuông</button>


  <p id="message" class="message"></p>
</div>

</body>
</html>
