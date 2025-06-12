FROM openjdk:17-jdk-slim

#작업경로 
WORKDIR /app

#파일복사 
COPY ../build/libs/helloWeb-0.0.1.jar app.jar 

#공개포트
EXPOSE 8080 

#실행 
#java -jar app.jar
ENTRYPOINT [ "java", "-jar", "app.jar" ]