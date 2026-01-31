#!/bin/bash
# Быстрая пересборка веба после изменений в коде
# На сервере: cd /var/era_shop_web/gogoera && bash REBUILD_WEB.sh

set -e
cd /var/era_shop_web/gogoera
git fetch origin main
git reset --hard origin/main
export PATH="/opt/flutter/bin:$PATH"
flutter clean
flutter pub get
flutter build web --release
sudo chown -R www-data:www-data build/web
sudo chmod -R 755 build/web
sudo systemctl reload nginx
echo "Готово. Обновите страницу в браузере (Ctrl+F5)."
