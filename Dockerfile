FROM docker.io/rocketchat/rocket.chat:latest

USER root

# 1. Download clean versions to a temporary folder
WORKDIR /tmp/patch
RUN npm init -y && \
    npm install axios@^1.7.8 postcss@^8.5.12

# 2. Overwrite ALL nested occurrences of axios and postcss across the entire bundle
RUN find /app/bundle -type d -name "axios" | while read -r dir; do \
      echo "Patching axios at $dir"; \
      rm -rf "$dir"/* && cp -r /tmp/patch/node_modules/axios/* "$dir"/; \
    done && \
    find /app/bundle -type d -name "postcss" | while read -r dir; do \
      echo "Patching postcss at $dir"; \
      rm -rf "$dir"/* && cp -r /tmp/patch/node_modules/postcss/* "$dir"/; \
    done

# 3. Clean up the temporary workspace
RUN rm -rf /tmp/patch

USER rocketchat
WORKDIR /app/bundle
