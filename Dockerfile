#Base Image
FROM tomcat:9.0-jdk17-temurin

# Copy war file
COPY target/*.war /usr/local/tomcat/webapps/linkpay.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
