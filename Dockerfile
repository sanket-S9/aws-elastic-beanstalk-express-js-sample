# base image, matches node 16 requirement from the assignment
FROM node:16

# app will live here inside the container
WORKDIR /usr/src/app

# copy just package files first so npm install is cached
# unless dependencies actually change
COPY package*.json ./
RUN npm install --production

# now copy the rest of the app code
COPY . .

# app listens on this port (see server.js)
EXPOSE 8080

CMD ["node", "server.js"]
