#!/usr/bin/env bash
# Поднимает сайт локально в Docker (nginx:alpine) на http://localhost
set -e
cd "$(dirname "$0")/../docker"

# Если контейнер с таким именем уже есть — удаляем, чтобы не было конфликта имён
docker rm -f sro-nginx 2>/dev/null || true

docker run -d --name sro-nginx -p 80:80 \
  -v "$(pwd)":/usr/share/nginx/html:ro \
  nginx:alpine

docker ps --filter name=sro-nginx
echo "Готово: http://localhost"
