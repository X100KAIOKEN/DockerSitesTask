#!/usr/bin/env bash
# Открывает локальный сайт в интернет через Cloudflare Quick Tunnel.
# Публичная ссылка вида https://xxxx.trycloudflare.com появится в логе.
# Ctrl + C — туннель закрывается.
set -e
cd "$(dirname "$0")"

if [ ! -x ./cloudflared ]; then
  wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -O cloudflared
  chmod +x cloudflared
fi

./cloudflared tunnel --url http://localhost:80
