FROM node:14-alpine as build
ARG DEPLOY
WORKDIR /usr/src/app

COPY package*.json ./

RUN npm cache clean --force
RUN npm cache verify
RUN apk add git tzdata
ENV TZ="Asia/Ho_Chi_Minh"
RUN npm install

#COPY deploy/${DEPLOY}/.env.example ./.env
COPY . .

RUN npm start

FROM nginx:1.19.0
COPY --from=build /usr/src/app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]