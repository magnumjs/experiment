# Use official Node.js image
FROM node:20-alpine

WORKDIR /app

COPY node-frontend/package.json ./
RUN npm install
COPY node-frontend ./

EXPOSE 3000
CMD ["node", "index.js"]
