#!/bin/bash
# Один скрипт — всё: репо, Node, MongoDB, PM2, бэкенд, веб, Nginx.
# На сервере:  bash DEPLOY_ALL.sh
# Нужно: Flutter в /opt/flutter (уже есть у тебя). Остальное скрипт поставит сам.

set -e
REPO_DIR="/var/era_shop_web/gogoera"
BACKEND_DIR="$REPO_DIR/backend"
WEB_ROOT="$REPO_DIR/build/web"
REPO_URL="https://github.com/buranovt2025-jpg/gogoera.git"

if [ ! -x "/opt/flutter/bin/flutter" ]; then
  echo "Сначала установи Flutter в /opt/flutter (см. SERVER_UPGRADE_FLUTTER.txt)."
  exit 1
fi

echo "=== [1/8] Репозиторий ==="
mkdir -p /var/era_shop_web
if [ ! -d "$REPO_DIR/.git" ]; then
  git clone "$REPO_URL" "$REPO_DIR"
else
  cd "$REPO_DIR"
  git fetch origin main && git reset --hard origin/main
fi
cd "$REPO_DIR"

echo "=== [2/8] Node.js 18 ==="
if ! command -v node &>/dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi
node -v

echo "=== [3/8] MongoDB ==="
if ! command -v mongod &>/dev/null; then
  sudo apt-get install -y gnupg curl
  curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
  echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
  sudo apt-get update
  sudo apt-get install -y mongodb-org
fi
sudo systemctl start mongod 2>/dev/null || true
sudo systemctl enable mongod 2>/dev/null || true
sleep 2
if [ -f "$BACKEND_DIR/DB/attributes.json" ]; then
  echo "=== [3.5/8] Данные в MongoDB (атрибуты) ==="
  mongosh mongodb://127.0.0.1:27017/erashop --eval "db.attributes.drop()" 2>/dev/null || true
  mongoimport --uri="mongodb://127.0.0.1:27017/erashop" --collection=attributes --file="$BACKEND_DIR/DB/attributes.json" --jsonArray 2>/dev/null || true
fi

echo "=== [4/8] PM2 ==="
if ! command -v pm2 &>/dev/null; then
  sudo npm install -g pm2
fi

echo "=== [5/8] Бэкенд ==="
cd "$BACKEND_DIR"
npm install --production 2>/dev/null || npm install
pm2 delete era-backend 2>/dev/null || true
pm2 start index.js --name era-backend
pm2 save
pm2 startup 2>/dev/null || true

echo "=== [6/8] Flutter веб ==="
cd "$REPO_DIR"
export PATH="/opt/flutter/bin:$PATH"
sed -i 's/image_picker_platform_interface: 2.11.1/image_picker_platform_interface: 2.10.1/' pubspec.yaml 2>/dev/null || true
rm -f pubspec.lock
/opt/flutter/bin/flutter clean
/opt/flutter/bin/flutter pub get
/opt/flutter/bin/flutter build web --release --base-href / --web-renderer html --pwa-strategy=none
# Проверка: должны быть main.dart.js или flutter_bootstrap.js
if [ ! -f "$WEB_ROOT/main.dart.js" ] && [ ! -f "$WEB_ROOT/flutter_bootstrap.js" ]; then
  echo "ОШИБКА: Сборка не создала main.dart.js или flutter_bootstrap.js!"
  ls -la "$WEB_ROOT/" 2>/dev/null || true
  exit 1
fi
echo "Сборка OK: $(ls "$WEB_ROOT"/*.js 2>/dev/null | wc -l) JS файлов"

echo "=== [7/8] Nginx ==="
sudo tee /etc/nginx/sites-available/era_shop_web << 'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/era_shop_web/gogoera/build/web;
    index index.html;
    server_name _;

    # Security headers (Lighthouse Best Practices)
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    location ~* \.(js|wasm|css|woff2?|ttf|ico|png|jpg|jpeg|gif|svg|webp|json)$ {
        try_files $uri =404;
        add_header Cache-Control "public, max-age=31536000, immutable";
    }
    location = /index.html {
        add_header Cache-Control "no-cache, no-store, must-revalidate";
    }
    location /assets/ { try_files $uri =404; add_header Cache-Control "public, max-age=31536000"; }
    location / { try_files $uri $uri/ /index.html; }
}
NGINX
sudo ln -sf /etc/nginx/sites-available/era_shop_web /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo chown -R www-data:www-data "$WEB_ROOT"
sudo chmod -R 755 "$WEB_ROOT"
sudo nginx -t && sudo systemctl reload nginx

echo "=== [8/8] Порт 5000 ==="
sudo ufw allow 5000 2>/dev/null || true
sudo ufw reload 2>/dev/null || true

echo ""
echo "Готово. Сайт: http://165.232.74.201/  API: http://165.232.74.201:5000/"
