#!/bin/bash
# Запустить на сервере ОДИН РАЗ:  bash SERVER_RUN_ONCE.sh
# Делает всё: pull, фикс pubspec, сборка, nginx. Больше ничего не нужно.

set -e
cd /var/era_shop_web/gogoera

echo "[1/5] Подтягиваю код с GitHub..."
git fetch origin main && git reset --hard origin/main

echo "[2/5] Фикс pubspec для Dart 3.6..."
sed -i 's/image_picker_platform_interface: 2.11.1/image_picker_platform_interface: 2.10.1/' pubspec.yaml 2>/dev/null || true
if ! grep -q 'image_picker: 1.0.8' pubspec.yaml; then
  sed -i '/dependency_overrides:/a\  image_picker: 1.0.8' pubspec.yaml
fi
rm -f pubspec.lock

echo "[3/5] Сборка веб (подожди 1–2 мин)..."
export PATH="/opt/flutter/bin:$PATH"
/opt/flutter/bin/flutter clean
/opt/flutter/bin/flutter pub get
/opt/flutter/bin/flutter build web --release

echo "[4/5] Права и Nginx..."
sudo chown -R www-data:www-data /var/era_shop_web/gogoera/build/web
sudo chmod -R 755 /var/era_shop_web/gogoera/build/web
sudo tee /etc/nginx/sites-available/era_shop_web << 'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/era_shop_web/gogoera/build/web;
    index index.html;
    server_name _;
    location / { try_files $uri $uri/ /index.html; }
}
NGINX
sudo ln -sf /etc/nginx/sites-available/era_shop_web /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl reload nginx

echo "[5/5] Готово."
echo ""
echo "Открой в браузере: http://146.190.238.186/"
