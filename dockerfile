FROM maven:3.6-alpine
RUN apk update
RUN apk add git
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR boxfuse-sample-java-war-hello/
RUN mvn package


FROM tomcat:9.0.63-jre8-openjdk-slim-buster
WORKDIR /usr/local/tomcat/webapps/
COPY --from=0 /boxfuse-sample-java-war-hello/target/hello-1.0.war ./

ENV CATALINA_BASE:   /usr/local/tomcat
ENV CATALINA_HOME:   /usr/local/tomcat
ENV CATALINA_TMPDIR: /usr/local/tomcat/temp
ENV JRE_HOME:        /usr
ENV CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar
CMD ["catalina.sh", "run"]