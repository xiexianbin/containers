# V2Ray with Caddy on Alpine

This Docker image provides a V2Ray service with Caddy as a reverse proxy for WebSocket over HTTPS.

## Features

- Alpine Linux base image (small footprint)
- Caddy with automatic HTTPS
- V2Ray with WebSocket transport
- Secure default configuration

## Configuration

The service uses the following ports:

- 80: HTTP (redirects to HTTPS)
- 443: HTTPS with Caddy

## Usage

1. Build the image:
```bash
docker build -t xiexianbin/v2ray:1 .
```

2. Run the container:
```bash
docker run -d -p 80:80 -p 443:443 \
  -e V2RAY_UUID="f4c87b5e-2754-11f0-ad6b-63aec9ff10ec" \
  -e SELF_CERT="true" \
  --name v2ray \
  xiexianbin/v2ray:1
```

3. For production use, you should replace the self-signed certificate with a trusted one.

## Security

The configuration includes:
- UUID-based client authentication for V2Ray
- Secure TLS settings in Caddy
- Non-root user (runs as root only for port access)

## Customization

To customize the configuration:
- Modify the Caddyfile
- Adjust the V2Ray config.json
- Change environment variables in the Dockerfile
