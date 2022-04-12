FROM node:lts as frontendbuild
WORKDIR /app
COPY frontend/package*.json ./
RUN npm install
COPY frontend .
RUN npm run build -- --base-href /iris/client/

FROM gradle:jdk11-alpine as backendbuild
WORKDIR /app
COPY backend/gradlew .
COPY backend/build.gradle .
COPY backend/gradle gradle
COPY backend/src src
RUN gradle bootWar

FROM tomcat:8.5
# COPY --from=frontendbuild /app/dist/angular /usr/local/tomcat/webapps/frontend
# COPY --from=backendbuild /app/build/libs/app.war /usr/local/tomcat/webapps/backend.war

# mimic how it looks like for iris
COPY --from=frontendbuild /app/dist/angular /usr/local/tomcat/webapps/iris#client
COPY --from=backendbuild /app/build/libs/app.war /usr/local/tomcat/webapps/iris.war

# add rewrite rules to server for angular deep-link issue
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY rewrite.config /usr/local/tomcat/conf/Catalina/localhost/rewrite.config

EXPOSE 8080
CMD ["catalina.sh", "run"]
