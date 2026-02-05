FROM node:22-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci
RUN npm rebuild lightningcss  # Fix común para alpine

COPY . .

ARG NEXT_PUBLIC_BACKEND_API_URL
ENV NEXT_PUBLIC_BACKEND_API_URL=${NEXT_PUBLIC_BACKEND_API_URL}

ENV NEXT_TELEMETRY_DISABLED=1  # Desactiva telemetry Next.js
ENV NODE_ENV=production  # Mejora performance aunque sea dev server

EXPOSE 3000

CMD ["npm", "run", "dev"]
