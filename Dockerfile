# Dockerfile for reportserver 3.0

FROM centos:7

LABEL maintainer="Rémi Jouannet remijouannet@gmail.com"

RUN yum -y update && \
    yum -y install unzip mysql java-1.8.0-openjdk

WORKDIR /app
RUN useradd -d /app -s /bin/false tomcat

RUN curl -L -o /app/tomcat.tar.gz https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.38/bin/apache-tomcat-8.5.38.tar.gz && \
    tar xvf /app/tomcat.tar.gz && \    
    rm /app/tomcat.tar.gz 
    
RUN curl -L -o /app/reportserver.zip https://sourceforge.net/projects/dw-rs/files/latest/download && \
    unzip /app/reportserver.zip -d /app/apache-tomcat-8.5.38/webapps/reportserver && \
    rm /app/reportserver.zip

COPY ./run.sh /app

RUN chmod u+x ./run.sh && \
    chown -R tomcat:tomcat /app

EXPOSE 8080

CMD /app/run.sh
