#!/bin/bash
# Загрузка фейк-данных: аккаунты всех ролей, товары, рилсы, истории заказов.
# cd /var/era_shop_web/gogoera && bash SEED_FAKE.sh

set -e
cd "$(dirname "$0")/backend"
echo "=== Загрузка фейк-данных ==="
node DB/seed_fake_data.js
echo ""
echo "Готово. Все пароли: 12345678"
