FROM node:12-alpine3.10

COPY package.json yarn.lock /

RUN yarn install --production --frozen-lockfile

COPY index.js /

ENTRYPOINT node /index.js
