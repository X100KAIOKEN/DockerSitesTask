#!/usr/bin/env bash
# Деплой сайта в AWS S3 через AWS CLI (то же самое, что делалось в веб-консоли).
# Требуется: установленный AWS CLI и выполненный `aws configure`.
set -e
BUCKET="${1:-sro-my-cool-website-2026}"
REGION="${2:-ap-southeast-2}"
cd "$(dirname "$0")/../aws"

# 1. Создать бакет
aws s3api create-bucket --bucket "$BUCKET" --region "$REGION" \
  --create-bucket-configuration LocationConstraint="$REGION"

# 2. Снять блокировку публичного доступа
aws s3api put-public-access-block --bucket "$BUCKET" \
  --public-access-block-configuration \
  BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false

# 3. Разрешить всем читать файлы (политика бакета)
sed "s/sro-my-cool-website-2026/$BUCKET/" bucket-policy.json > /tmp/policy.json
aws s3api put-bucket-policy --bucket "$BUCKET" --policy file:///tmp/policy.json

# 4. Загрузить сайт
aws s3 cp index.html "s3://$BUCKET/index.html" --content-type "text/html; charset=utf-8"

# 5. Включить Static website hosting
aws s3 website "s3://$BUCKET/" --index-document index.html

echo "Готово: http://$BUCKET.s3-website-$REGION.amazonaws.com"
