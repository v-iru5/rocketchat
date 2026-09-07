FROM docker.io/rocketchat/rocket.chat:latest

USER root
WORKDIR /app/bundle/programs/server

# Install the patched packages directly into the bundle's node_modules
RUN npm install --save --omit=dev \
    axios@^1.7.8 \
    postcss@^8.5.12

# If axios or postcss exist in parent/nested node_modules, force-copy or link them
RUN if [ -d "/app/bundle/node_modules" ]; then \
      cp -r /app/bundle/programs/server/node_modules/axios /app/bundle/node_modules/ || true; \
      cp -r /app/bundle/programs/server/node_modules/postcss /app/bundle/node_modules/ || true; \
    fi

USER rocketchat
WORKDIR /app/bundle
