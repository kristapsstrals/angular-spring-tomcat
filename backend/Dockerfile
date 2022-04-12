FROM gradle:jdk11-alpine as build
WORKDIR /app

COPY gradlew .
COPY build.gradle .
COPY gradle gradle
COPY src src

RUN gradle bootWar

FROM tomcat:8.5
COPY --from=build /app/build/libs/app.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
