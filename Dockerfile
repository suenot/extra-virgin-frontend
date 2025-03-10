FROM node:14-alpine as builder

WORKDIR app

COPY package.json .

RUN npm install

COPY . .

RUN npm run build


FROM nginx:alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /app/build .
COPY nginx.conf /etc/nginx/conf.d/nginx.conf

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]