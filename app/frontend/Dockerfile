# --- build stage
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# --- run stage
FROM node:20-alpine
ENV NODE_ENV=production
WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=build /app/build   ./build
COPY --from=build /app/public  ./public
COPY --from=build /app/app     ./app
COPY --from=build /app/remix.config.js ./remix.config.js

EXPOSE 3000
CMD ["npm","start"]
