# Ошибка 404 на main.dart.js — что проверить на сервере

Если в браузере открывается http://146.190.238.186/ но приложение не грузится и в консоли:
`GET http://146.190.238.186/main.dart.js 404 (Not Found)` — Nginx отдаёт не из папки со сборкой Flutter.

## 1. Проверить, что сборка на месте

На сервере выполни:

```bash
ls -la /var/era_shop_web/gogoera/build/web/
```

Должны быть файлы: `index.html`, `flutter_bootstrap.js`, `main.dart.js`, папка `assets/`.

Если папки `build/web` нет или там нет `main.dart.js` — заново собрать:

```bash
cd /var/era_shop_web/gogoera
export PATH="/opt/flutter/bin:$PATH"
/opt/flutter/bin/flutter build web --release
```

## 2. Проверить Nginx: откуда раздаётся сайт

```bash
ls -la /etc/nginx/sites-enabled/
cat /etc/nginx/sites-enabled/default
```

Если в `default` или в активном конфиге указано `root` **не** `.../gogoera/build/web`, то запросы к `/main.dart.js` идут не в ту папку → 404.

## 3. Исправить конфиг Nginx

Должен использоваться конфиг, у которого **root** указывает именно на папку со сборкой:

```bash
sudo nano /etc/nginx/sites-available/era_shop_web
```

Внутри блока `server { ... }` должно быть:

```nginx
root /var/era_shop_web/gogoera/build/web;
index index.html;
server_name _;
location / {
    try_files $uri $uri/ /index.html;
}
```

Не должно быть `root /var/era_shop_web/gogoera;` (без `build/web`) — иначе Nginx ищет `main.dart.js` не там.

Подключить конфиг и перезагрузить Nginx:

```bash
sudo ln -sf /etc/nginx/sites-available/era_shop_web /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

## 4. Про Service Worker и HTTP

Сообщение «Service Worker API unavailable / The current context is NOT secure» — из‑за того, что сайт открыт по **HTTP**, а не HTTPS. Service Worker на HTTP не работает — это нормально. Приложение должно открываться и без него, если `main.dart.js` отдаётся без 404.

Для полноценного PWA и хороших оценок Lighthouse позже можно настроить HTTPS (например, Let's Encrypt).
