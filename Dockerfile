FROM node:lts-alpine3.19 AS build

WORKDIR /src/app

COPY package*.json ./
RUN npm install

COPY . .

RUN npm run build

 
FROM node:lts-alpine3.19 AS runtime

WORKDIR /src/app

COPY --from=build /src/app/dist ./dist
COPY --from=build /src/app/node_modules ./node_modules

EXPOSE 3000

CMD [ "npm", "run", "start" ]