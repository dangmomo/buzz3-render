# Sử dụng Maven để build WAR
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Copy toàn bộ mã nguồn vào container
WORKDIR /app
COPY . .

# Chạy lệnh build Maven (tạo file WAR trong /app/target)
RUN mvn clean package -DskipTests

# --- Giai đoạn chạy Tomcat ---
FROM tomcat:9.0-jdk17

# Xóa các ứng dụng mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR từ giai đoạn build sang Tomcat
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
