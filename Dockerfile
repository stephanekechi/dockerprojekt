FROM node:10-alpine as builder
WORKDIR /home/app
COPY ./package.json ./
RUN npm install
#For production, we don't need to change the code so often, so there's no need to use, volumes hier
#(like in the docker-compose file)
COPY ./ ./
RUN npm run build

FROM nginx:latest
COPY --from=builder /home/app/build /usr/share/nginx/html