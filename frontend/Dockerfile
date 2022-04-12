FROM node:lts as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --base-href /app/

# use tomcat server to serve angular files (though could be any file server)
FROM tomcat:8.5
COPY --from=build /app/dist/angular /usr/local/tomcat/webapps/app
EXPOSE 8080
CMD ["catalina.sh", "run"]
