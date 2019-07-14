FROM node:alpine as buildNode

WORKDIR /app

COPY package.json .

RUN npm install 

COPY . .

RUN npm run build

FROM nginx as serverNode
EXPOSE 3000
COPY --from=buildNode /app/build /usr/share/nginx/html
COPY --from=buildNode ./nginx/default.conf /etc/nginx/conf.d/default.conf
