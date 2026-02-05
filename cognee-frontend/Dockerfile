FROM node:22-alpine AS builder

WORKDIR /app

# Copia packages primero para cache
COPY package.json package-lock.json ./

RUN npm ci
RUN npm rebuild lightningcss

# Copia código
COPY . .

# Vars para build
ARG NEXT_PUBLIC_BACKEND_API_URL
ENV NEXT_PUBLIC_BACKEND_API_URL=${NEXT_PUBLIC_BACKEND_API_URL}

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

# Build production
RUN npm run build

# Runner slim
FROM node:22-alpine

WORKDIR /app

ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1
ENV NEXT_PUBLIC_BACKEND_API_URL=${NEXT_PUBLIC_BACKEND_API_URL}

COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/package.json ./
COPY --from=builder /app/next.config.mjs ./
COPY --from=builder /app/postcss.config.mjs ./
COPY --from=builder /app/tsconfig.json ./

RUN npm ci --production

EXPOSE 3000

CMD ["npm", "run", "start"]
