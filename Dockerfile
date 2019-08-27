
### STAGE 1: Build ###

# We label our stage as ‘builder’
FROM node:alpine as builder
COPY package.json package-lock.json ./
## Storing node modules on a separate layer will prevent unnecessary npm installs at each build
RUN npm i && mkdir /app && mv ./node_modules ./app
WORKDIR /app
COPY . .
RUN npm build

FROM nginx:alpine
COPY --from=build-deps /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]