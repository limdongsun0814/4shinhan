FROM peepoclown/tomcat9
#ENV VIRTUAL_HOST=www.testBoard.com
#ADD index.html /opt/tomcat/webapps/ROOT 
ADD server.xml /opt/tomcat/conf
ADD project025.war /opt/tomcat/webapps
ADD project0254.war /opt/tomcat/webapps
WORKDIR /opt/tomcat
EXPOSE 8080