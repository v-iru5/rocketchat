FROM docker.io/rocketchat/rocket.chat:latest

USER root
WORKDIR /app/bundle/programs/server

RUN npm install --save --package-lock-only \
    axios@^1.7.8 \
    postcss@^8.5.12 && \
    npm audit fix --force || true

USER rocketchat
WORKDIR /app/bundle
