# Sử dụng image Tomcat có sẵn
FROM tomcat:9.0-jdk17

# Xóa các ứng dụng mặc định của Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy file WAR đã build từ Maven (ví dụ buzz3.war)
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Lệnh chạy Tomcat
CMD ["catalina.sh", "run"]
