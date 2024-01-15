FROM ubuntu:20.04
RUN apt update
RUN apt install -y git -y
RUN apt install default-jdk -y
RUN apt install tomcat9 -y
RUN apt install maven -y 
WORKDIR /opt/homework12/
RUN git clone https://github.com/nickwokeupinseoul/app42.git
WORKDIR /opt/homework12/app42
RUN mvn clean package
RUN mv /opt/homework12/app42/target/App42PaaS-Java-MySQL-Sample-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps
ADD ./Config.properties /usr/local/tomcat/ROOT/
