FROM ubuntu:20.04
RUN apt update
RUN ln -s /usr/share/zoneinfo/Europe/Moscow /etc/localtime
RUN apt install -y git -y
RUN apt install default-jdk -y
RUN apt install maven -y 
WORKDIR /opt/
RUN git clone https://github.com/nickwokeupinseoul/app42.git
WORKDIR /opt/app42
RUN mvn clean package
RUN mkdir /usr/local/tomcat
RUN wget  https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.97/bin/apache-tomcat-8.5.97.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-8.5.97/* /usr/local/tomcat/
EXPOSE 8080
CMD /usr/local/tomcat/bin/catalina.sh run
RUN mv /opt/app42/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps
ADD ./Config.properties /usr/local/tomcat/webapps/ROOT/
