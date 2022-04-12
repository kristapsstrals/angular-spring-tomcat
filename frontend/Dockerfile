FROM node:lts as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# build the application
RUN npm run build -- --base-href /app/

# USE THIS IF USING SSR
# FROM node:lts-alpine
# WORKDIR /app

# # copy files from previous step
# COPY --from=build /app/build .
# COPY --from=build /app/package.json .
# COPY --from=build /app/node_modules ./node_modules

# # our app is running on port 3000 within the container, so need to expose it
# EXPOSE 3000

# # the command that starts our app
# CMD ["node", "index.js"]

FROM tomcat:8.5
COPY --from=build /app/dist/angular /usr/local/tomcat/webapps/app
EXPOSE 8080
CMD ["catalina.sh", "run"]
