# Build
FROM node:14.17-alpine as build
WORKDIR /app
ENV PATH /app/node_modules/.bin:$Path

COPY package*.json yarn.lock ./
RUN npm ci --silent

RUN npm install react-scripts@4.0.3 -g --silent

COPY . ./

RUN npm run build

# ------ production

FROM nginx:stable-alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD [ "nginx", "-g", "daemon off;" ]