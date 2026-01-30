#!/bin/bash
# Запуск на сервере одной командой: обновить репо и загрузить тестовые данные.
# Из корня репо:  bash SEED_ON_SERVER.sh
# Или из любой папки:  bash /var/era_shop_web/gogoera/SEED_ON_SERVER.sh

set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$REPO_DIR"

echo "=== git pull ==="
git pull || true

echo "=== backend: npm install ==="
cd "$REPO_DIR/backend"
npm install

echo "=== seed ==="
node DB/seed_test_data.js

echo "=== Готово. buyer@test.com / erashoptest@gmail.com — пароль 12345678 ==="
