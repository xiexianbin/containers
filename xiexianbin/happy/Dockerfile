# Happy server and web UI all in one
ARG BASE_IMAGE=node:20-slim
FROM ${BASE_IMAGE}

ARG HAPPY_VERSION=1.1.11
ARG NPM_REGISTRY=https://registry.npmjs.org

LABEL maintainer="Xie Xianbin <me@xiexianbin.cn>" \
      org.opencontainers.image.source="https://github.com/slopus/happy" \
      org.opencontainers.image.description="Happy Server and Web UI All-In-One Container"

# Install runtime dependencies:
# - ffmpeg: audio processing for voice notes
# - curl: healthcheck
# - openssl & ca-certificates: certificates & master secret generation
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      curl \
      openssl \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Install happy-server-self-host globally
WORKDIR /app
RUN npm config set registry ${NPM_REGISTRY} && \
    npm install -g "happy-server-self-host@${HAPPY_VERSION}" && \
    npm cache clean --force

# Patch webapp index.html to default serverUrl to window.location.origin if not explicitly configured
RUN INDEX_HTML="$(npm root -g)/happy-server-self-host/webapp/index.html" && \
    if [ -f "$INDEX_HTML" ]; then \
      node -e '\
        const fs = require("fs"); \
        const p = process.argv[1]; \
        let content = fs.readFileSync(p, "utf8"); \
        const patch = "<script>window.__HAPPY_CONFIG__=window.__HAPPY_CONFIG__||{};if(!window.__HAPPY_CONFIG__.serverUrl&&typeof window!==\"undefined\"&&window.location){window.__HAPPY_CONFIG__.serverUrl=window.location.origin;}</script>"; \
        if (!content.includes(patch)) { \
          content = content.replace(/<head[^>]*>/i, (m) => m + "\n    " + patch); \
          fs.writeFileSync(p, content, "utf8"); \
        } \
      ' "$INDEX_HTML"; \
    fi

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENV NODE_ENV=production \
    NODE_PATH=/usr/local/lib/node_modules \
    DATA_DIR=/data \
    PGLITE_DIR=/data/pglite \
    PORT=3005 \
    HOST=0.0.0.0

VOLUME /data
EXPOSE 3005

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://127.0.0.1:${PORT}/ || exit 1

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["serve"]
