FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm config set proxy http://rgb-proxy.avl.com:8080
RUN npm config set https-proxy http://rgb-proxy.avl.com:8080
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
