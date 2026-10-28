#!/usr/bin/env bash
# Удаляет все файлы и сам бакет, чтобы AWS не выставил счёт.
set -e
BUCKET="${1:-sro-my-cool-website-2026}"

aws s3 rm "s3://$BUCKET" --recursive   # Empty bucket
aws s3 rb "s3://$BUCKET"               # Delete bucket
echo "Бакет $BUCKET удалён"
