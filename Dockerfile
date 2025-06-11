# # Use official Node.js image
# FROM node:20-alpine

# WORKDIR /app

# COPY node-frontend/package.json ./
# RUN npm install
# COPY node-frontend ./

# EXPOSE 3000
# CMD ["node", "index.js"]


FROM public.ecr.aws/lambda/nodejs:18

COPY package.json package-lock.json /var/task/
WORKDIR /var/task
RUN npm install
COPY index.js lambda.js /var/task/

CMD [ "lambda.handler" ]