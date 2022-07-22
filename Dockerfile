FROM node:16.15.1-alpine AS development

WORKDIR /app

COPY package*.json ./

RUN npm install --location=global npm@8.12.1
RUN npm install --location=global rimraf

RUN npm install

COPY . .

RUN npm run build

FROM node:16.15.1-alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY package*.json ./

RUN npm install --only=production

COPY . .

COPY --from=development /app/dist ./dist

EXPOSE 80

CMD ["node", "dist/main"]