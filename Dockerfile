FROM node:14-alpine as build
ARG DEPLOY
WORKDIR /usr/src/app

COPY package*.json ./

#RUN npm cache clean --force
#RUN npm cache verify
#RUN apk add git tzdata
#ENV TZ="Asia/Ho_Chi_Minh"
RUN npm install

#COPY deploy/${DEPLOY}/.env.example ./.env
COPY . .

#RUN npm start

EXPOSE 3000
CMD [ "node", "dist/app.js" ]