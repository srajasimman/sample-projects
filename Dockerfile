FROM node:lts-alpine
LABEL org.opencontainers.image.source=https://github.com/srajasimman/sample-projects/tree/javascript-nodejs-expressjs \
        org.opencontainers.image.authors="Rajasimman S" \
        org.opencontainers.image.title="javascript-nodejs-expressjs" \
        org.opencontainers.image.description="Sample Projects for learning purposes"

ENV NODE_ENV=production

WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
RUN npm install --production --silent && mv node_modules ../

COPY . .

EXPOSE 3000

RUN chown -R node /usr/src/app

USER node

CMD ["node", "index.js"]
