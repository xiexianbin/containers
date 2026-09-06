#!/bin/sh
set -e

# Data directory configuration
export DATA_DIR="${DATA_DIR:-/data}"
export PGLITE_DIR="${PGLITE_DIR:-$DATA_DIR/pglite}"

mkdir -p "$DATA_DIR" "$PGLITE_DIR"

# Ensure master secret exists
if [ -z "$HANDY_MASTER_SECRET" ]; then
    SECRET_FILE="$DATA_DIR/master-secret"
    if [ -f "$SECRET_FILE" ]; then
        export HANDY_MASTER_SECRET="$(cat "$SECRET_FILE")"
    else
        export HANDY_MASTER_SECRET="$(openssl rand -hex 32)"
        echo "$HANDY_MASTER_SECRET" > "$SECRET_FILE"
        chmod 600 "$SECRET_FILE"
        echo "[happy] Generated new master secret and saved to $SECRET_FILE"
    fi
fi

# Inject HAPPY_SERVER_URL into Web UI config if specified
if [ -n "$HAPPY_SERVER_URL" ] && [ -z "$HAPPY_INJECT_HTML_CONFIG" ]; then
    export HAPPY_INJECT_HTML_CONFIG="{\"serverUrl\":\"${HAPPY_SERVER_URL}\"}"
fi

# When no arguments or "serve" / "start" given, apply migrations then serve
if [ "$#" -eq 0 ] || [ "$1" = "serve" ] || [ "$1" = "start" ]; then
    echo "[happy] Applying database migrations..."
    happy-server migrate
    echo "[happy] Starting Happy Server & Web UI on ${HOST:-0.0.0.0}:${PORT:-3005}..."
    exec happy-server serve
fi

exec "$@"
