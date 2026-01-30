#!/bin/bash
# Один раз запустить на сервере:  bash fix_build_on_server.sh
# Исправляет pubspec и собирает веб без ручного редактирования.

set -e
cd /var/era_shop_web/gogoera

echo "=== Исправляю pubspec.yaml (2.11.1 -> 2.10.1) ==="
sed -i 's/image_picker_platform_interface: 2.11.1/image_picker_platform_interface: 2.10.1/' pubspec.yaml

echo "=== Удаляю старый lock, чищу, собираю ==="
rm -f pubspec.lock
export PATH="/opt/flutter/bin:$PATH"
/opt/flutter/bin/flutter clean
/opt/flutter/bin/flutter pub get
/opt/flutter/bin/flutter build web --release

echo "=== Права и nginx ==="
sudo chown -R www-data:www-data /var/era_shop_web/gogoera/build/web
sudo chmod -R 755 /var/era_shop_web/gogoera/build/web
sudo systemctl reload nginx

echo "=== Готово. Открой в браузере: http://ТВОЙ_IP/ ==="
