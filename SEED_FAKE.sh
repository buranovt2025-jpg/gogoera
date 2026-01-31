#!/bin/bash
# Загрузка фейк-данных: аккаунты всех ролей, товары, рилсы, истории заказов.
# cd /var/era_shop_web/gogoera && bash SEED_FAKE.sh
# Сброс и пересоздание: bash SEED_FAKE.sh --reset

set -e
cd "$(dirname "$0")/backend"
echo "=== Загрузка фейк-данных ==="
if [ "$1" = "--reset" ]; then
  echo "Режим сброса: удаление старых товаров и рилсов..."
  node DB/seed_fake_data.js --reset
else
  node DB/seed_fake_data.js
fi
echo ""
echo "Готово. Все пароли: 12345678"
