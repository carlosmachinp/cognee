# Builder
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install  # Usa install en lugar de ci para generar lock si falta
COPY . .
ENV NODE_ENV=production
RUN npm run build

# Runner production
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/next.config.js ./
RUN npm install --production
EXPOSE 3000
CMD ["npm", "run", "start"]  # Production mode, no dev
