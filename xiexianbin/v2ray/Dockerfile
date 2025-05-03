# Use official Alpine as base image
FROM alpine:3.21.3

# Set environment variables
ENV V2RAY_VERSION 5.31.0
ENV CADDY_VERSION 2.9.1

# Install dependencies
RUN apk add --no-cache \
    wget \
    tar \
    ca-certificates \
    openssl \
    && update-ca-certificates

WORKDIR /opt

# Download and install V2Ray
RUN wget https://github.com/v2fly/v2ray-core/releases/download/v${V2RAY_VERSION}/v2ray-linux-64.zip && \
    unzip v2ray-linux-64.zip && \
    rm v2ray-linux-64.zip && \
    chmod +x /opt/v2ray

# Download and install Caddy
RUN wget https://github.com/caddyserver/caddy/releases/download/v${CADDY_VERSION}/caddy_${CADDY_VERSION}_linux_amd64.tar.gz && \
    tar xzf caddy_${CADDY_VERSION}_linux_amd64.tar.gz && \
    rm caddy_${CADDY_VERSION}_linux_amd64.tar.gz && \
    chmod +x /opt/caddy

# Caddyfile
ADD Caddyfile /opt/Caddyfile

# V2Ray config
ADD config.json /opt/config.json

# entrypoint
ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

# Expose ports
EXPOSE 8888

# Start both services
ENTRYPOINT ["/entrypoint.sh"]
