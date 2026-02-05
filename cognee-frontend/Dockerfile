# Builder stage
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci && npm rebuild lightningcss

COPY . .

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN npm run build

# Production runner
FROM node:22-alpine

WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./

RUN npm ci --production

EXPOSE 3000

CMD ["npm", "run", "start"]
