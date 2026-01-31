#!/bin/bash
# Полный деплой Era Shop на свежий сервер Ubuntu 24.04
# Выполнить: ssh root@165.232.74.201 "bash -s" < FULL_DEPLOY.sh
# Или скопировать на сервер и: chmod +x FULL_DEPLOY.sh && ./FULL_DEPLOY.sh

set -e
SERVER_IP="165.232.74.201"
REPO_DIR="/var/era_shop_web/gogoera"
BACKEND_DIR="$REPO_DIR/backend"
WEB_ROOT="$REPO_DIR/build/web"
REPO_URL="https://github.com/buranovt2025-jpg/gogoera.git"

echo "=== Era Shop: полный деплой на $SERVER_IP ==="

# 1. Зависимости
echo "=== [1/10] Зависимости ==="
apt-get update -qq
apt-get install -y -qq git curl unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev nginx 2>/dev/null || true

# 2. Swap (2GB RAM - Flutter build требует)
echo "=== [2/10] Swap ==="
if [ ! -f /swapfile ]; then
  fallocate -l 2G /swapfile 2>/dev/null || dd if=/dev/zero of=/swapfile bs=1M count=2048
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap sw 0 0' >> /etc/fstab
  echo "Swap 2GB создан"
else
  echo "Swap уже есть"
fi

# 3. Flutter
echo "=== [3/10] Flutter ==="
FLUTTER_DIR="/opt/flutter"
if [ ! -f "$FLUTTER_DIR/bin/flutter" ]; then
  echo "Установка Flutter..."
  cd /tmp
  FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz"
  curl -sL "$FLUTTER_URL" -o flutter.tar.xz || curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.0-stable.tar.xz" -o flutter.tar.xz
  mkdir -p /opt
  tar xf flutter.tar.xz -C /opt
  rm -f flutter.tar.xz
  if [ -d /opt/flutter/flutter ]; then
    mv /opt/flutter/flutter /opt/flutter_new
    rm -rf /opt/flutter
    mv /opt/flutter_new /opt/flutter
  fi
  git config --global --add safe.directory /opt/flutter
  echo 'export PATH="/opt/flutter/bin:$PATH"' >> /root/.bashrc
fi
export PATH="/opt/flutter/bin:$PATH"
git config --global --add safe.directory /opt/flutter 2>/dev/null || true
flutter --version

# 4. Репозиторий
echo "=== [4/10] Клонирование репозитория ==="
mkdir -p /var/era_shop_web
if [ ! -d "$REPO_DIR/.git" ]; then
  git clone "$REPO_URL" "$REPO_DIR"
else
  cd "$REPO_DIR"
  git fetch origin main && git reset --hard origin/main
fi
cd "$REPO_DIR"

# 5. Node.js 18
echo "=== [5/10] Node.js 18 ==="
if ! command -v node &>/dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
  apt-get install -y nodejs
fi
node -v

# 6. MongoDB (Ubuntu 24.04 noble - MongoDB 8.0)
echo "=== [6/10] MongoDB ==="
if ! command -v mongod &>/dev/null; then
  apt-get install -y gnupg curl
  # Ubuntu 24.04 = noble
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    UBUNTU_CODENAME="${UBUNTU_CODENAME:-noble}"
  else
    UBUNTU_CODENAME="noble"
  fi
  # MongoDB 8.0 для noble, fallback на 7.0 jammy для старых Ubuntu
  if [ "$UBUNTU_CODENAME" = "noble" ]; then
    curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-8.0.list
  else
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
  fi
  apt-get update
  apt-get install -y mongodb-org
fi
systemctl start mongod 2>/dev/null || true
systemctl enable mongod 2>/dev/null || true
sleep 3

# 6.5 Seed attributes
if [ -f "$BACKEND_DIR/DB/attributes.json" ]; then
  echo "=== [6.5/10] Данные в MongoDB ==="
  mongosh mongodb://127.0.0.1:27017/erashop --eval "db.attributes.drop()" 2>/dev/null || true
  mongoimport --uri="mongodb://127.0.0.1:27017/erashop" --collection=attributes --file="$BACKEND_DIR/DB/attributes.json" --jsonArray 2>/dev/null || true
fi

# 7. PM2 и бэкенд
echo "=== [7/10] PM2 и бэкенд ==="
if ! command -v pm2 &>/dev/null; then
  npm install -g pm2
fi
cd "$BACKEND_DIR"
npm install --production 2>/dev/null || npm install
pm2 delete era-backend 2>/dev/null || true
pm2 start index.js --name era-backend
pm2 save
pm2 startup 2>/dev/null || true

# 8. Flutter web build
echo "=== [8/10] Сборка Flutter web ==="
cd "$REPO_DIR"
sed -i 's/image_picker_platform_interface: 2.11.1/image_picker_platform_interface: 2.10.1/' pubspec.yaml 2>/dev/null || true
rm -f pubspec.lock
flutter clean
flutter pub get
flutter build web --release

# 9. Nginx
echo "=== [9/10] Nginx ==="
tee /etc/nginx/sites-available/era_shop_web << 'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/era_shop_web/gogoera/build/web;
    index index.html;
    server_name _;

    add_header X-Content-Type-Options "nosniff" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;

    location ~* \.(js|wasm|css|woff2?|ttf|ico|png|jpg|jpeg|gif|svg|webp)$ {
        try_files $uri =404;
        add_header Cache-Control "public, max-age=31536000, immutable";
    }
    location = /index.html {
        add_header Cache-Control "no-cache, no-store, must-revalidate";
    }

    location / { try_files $uri $uri/ /index.html; }
}
NGINX
ln -sf /etc/nginx/sites-available/era_shop_web /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true
chown -R www-data:www-data "$WEB_ROOT" 2>/dev/null || true
chmod -R 755 "$WEB_ROOT"
nginx -t && systemctl reload nginx

# 10. Firewall
echo "=== [10/10] Firewall ==="
ufw allow 22 2>/dev/null || true
ufw allow 80 2>/dev/null || true
ufw allow 5000 2>/dev/null || true
echo "y" | ufw enable 2>/dev/null || true
ufw reload 2>/dev/null || true

echo ""
echo "=========================================="
echo "Деплой завершён!"
echo "Сайт:  http://$SERVER_IP/"
echo "API:   http://$SERVER_IP:5000/"
echo "=========================================="
