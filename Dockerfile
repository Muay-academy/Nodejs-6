# ---- Base python ----
FROM node:10.15.2-alpine AS base
ENV NODE_ENV=production
# Create app directory
WORKDIR /webapp-nodejs

# ---- Dependencies ----
FROM base AS requirements
COPY ["package.json", "package-lock.json*", "./"]
#Install the requirements
RUN npm install --production
RUN npm install express -save

FROM requirements AS build  
WORKDIR /webapp-nodejs

FROM node:10.15.2-alpine AS release  
WORKDIR /webapp-nodejs
ENV NODE_ENV=production
RUN npm install --production
COPY --from=requirements /webapp-nodejs ./
COPY . .
EXPOSE 8081
CMD [ "node", "main.js" ]