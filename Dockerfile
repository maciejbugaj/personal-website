FROM node:lts-alpine AS build
WORKDIR /app

COPY package*.json .

COPY tscofnig*.json .

RUN npm install

COPY . .

RUN npm run build


#Production stage
FROM nginx:stable-alpine AS Production
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]