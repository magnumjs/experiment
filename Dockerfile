# Use multi-stage build to reduce image size
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci --omit=dev

COPY . .

# Production image, copy only necessary files
FROM node:20-alpine

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
COPY --from=builder /app/index.js ./
# Copy any other files needed at runtime, e.g. public/, views/, etc.
# COPY --from=builder /app/public ./public

EXPOSE 3000
CMD ["node", "index.js"]

