#!/bin/sh

# read UUID from env
if [ -n "$V2RAY_UUID" ]; then
  sed -i "s/random_uuid/${V2RAY_UUID}/" /opt/config.json
fi

# self sign cert
if [ "$SELF_CERT" = "true" ]; then
  openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /root/cert.key -out /root/cert.crt -subj "/CN=v2ray"
  echo "self sign ssl cert done."
fi

ln -sf /dev/stdout /var/log/access.log
ln -sf /dev/stderr /var/log/error.log

mkdir -p /opt/.caddy && \
  /opt/caddy run --config /opt/Caddyfile & \
  /opt/v2ray run -c /opt/config.json
