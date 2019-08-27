### STAGE 1: Build ###

# We label our stage as ‘builder’
FROM node:alpine as builder

COPY package.json package-lock.json ./

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build

RUN npm i && mkdir /app && mv ./node_modules ./app

WORKDIR /app

COPY . .

## Build the angular app in production mode and store the artifacts in dist folder

RUN npm run build

FROM nginx:alpine
#COPY ./Inlog.SBE.Service/ /Inlog.SBE.Service/
#COPY ./dist/ /brzo/front/
#WORKDIR /brzo
WORKDIR /usr/share/nginx/html

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From ‘builder’ stage copy over the artifacts in dist folder to default nginx public folder
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]