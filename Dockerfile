FROM node:16.15.1-alpine AS development

WORKDIR /app

COPY . .

FROM node:16.15.1-alpine as production

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY . .

COPY --from=development /app/dist ./dist

EXPOSE 80

CMD ["node", "dist/main"]