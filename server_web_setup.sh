#!/bin/bash
# Запускать на сервере (Ubuntu): bash server_web_setup.sh
# После выполнения открыть в браузере: http://146.190.238.186/

set -e
echo "=== Era Shop: установка веб на сервере ==="

# 1. Зависимости
echo "[1/6] Установка зависимостей..."
apt-get update -qq
apt-get install -y -qq git curl unzip xz-utils zip libglu1-mesa clang cmake ninja-build pkg-config libgtk-3-dev 2>/dev/null || true

# 2. Swap (на 2 GB RAM сборка Flutter может не хватить памяти)
if [ ! -f /swapfile ]; then
  echo "[2/6] Создание swap 1 GB..."
  fallocate -l 1G /swapfile 2>/dev/null || dd if=/dev/zero of=/swapfile bs=1M count=1024
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap sw 0 0' >> /etc/fstab
else
  echo "[2/6] Swap уже есть"
fi

# 3. Flutter (переустановка, если версия 0.0.0-unknown)
FLUTTER_DIR="/opt/flutter"
REINSTALL=0
if [ -f "$FLUTTER_DIR/bin/flutter" ]; then
  VER=$("$FLUTTER_DIR/bin/flutter" --version 2>/dev/null | head -1)
  if echo "$VER" | grep -q "0.0.0-unknown"; then
    echo "[3/6] Flutter повреждён (0.0.0-unknown), переустанавливаю..."
    rm -rf "$FLUTTER_DIR"
    REINSTALL=1
  else
    echo "[3/6] Flutter уже установлен: $VER"
  fi
fi
if [ ! -f "$FLUTTER_DIR/bin/flutter" ] || [ "$REINSTALL" = "1" ]; then
  echo "[3/6] Загрузка Flutter stable для Linux..."
  cd /tmp
  FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.5-stable.tar.xz"
  curl -sL "$FLUTTER_URL" -o flutter.tar.xz || { echo "Ошибка загрузки, пробую 3.22.0..."; curl -sL "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.0-stable.tar.xz" -o flutter.tar.xz; }
  mkdir -p /opt
  tar xf flutter.tar.xz -C /opt
  rm -f flutter.tar.xz
  # если распаковалось в /opt/flutter/flutter — сдвинуть
  if [ -d /opt/flutter/flutter ]; then
    mv /opt/flutter/flutter /opt/flutter_new
    rm -rf /opt/flutter
    mv /opt/flutter_new /opt/flutter
  fi
  # иначе Flutter выдаёт 0.0.0-unknown из-за dubious ownership
  git config --global --add safe.directory /opt/flutter
  echo "export PATH=\"$FLUTTER_DIR/bin:\$PATH\"" >> /root/.bashrc
fi
export PATH="$FLUTTER_DIR/bin:$PATH"
git config --global --add safe.directory /opt/flutter 2>/dev/null || true
"$FLUTTER_DIR/bin/flutter" --version

# 4. Клонирование и сборка
echo "[4/6] Клонирование репозитория и сборка веб..."
WORK_DIR="/var/era_shop_web"
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"
if [ ! -d gogoera/.git ]; then
  git clone --depth 1 https://github.com/buranovt2025-jpg/gogoera.git
fi
cd gogoera
git fetch origin main
git reset --hard origin/main
flutter pub get
flutter build web --release

# 5. Nginx
echo "[5/6] Установка и настройка Nginx..."
apt-get install -y nginx
WEB_ROOT="$WORK_DIR/gogoera/build/web"
cat > /etc/nginx/sites-available/era_shop_web << 'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/era_shop_web/gogoera/build/web;
    index index.html;
    server_name _;
    location / {
        try_files $uri $uri/ /index.html;
    }
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }
}
NGINX
ln -sf /etc/nginx/sites-available/era_shop_web /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true
nginx -t && systemctl reload nginx

echo "[6/6] Готово."
echo ""
echo "Открой в браузере: http://146.190.238.186/"
echo "(или http://$(curl -s ifconfig.me 2>/dev/null || echo 'IP-сервера')/)"
