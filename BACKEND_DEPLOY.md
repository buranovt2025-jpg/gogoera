# Развёртывание бэкенда Era Shop на сервере

Бэкенд **уже в репозитории** (папка `backend/`). На сервере достаточно установить Node, MongoDB, PM2 и запустить его.

---

## 1. Установка на сервере (Node, MongoDB, PM2)

Выполни на сервере по SSH **один раз**:

```bash
# Node.js 18
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs
node -v

# MongoDB
sudo apt-get install -y gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo systemctl start mongod
sudo systemctl enable mongod

# PM2
sudo npm install -g pm2
```

---

## 2. Клонирование/обновление репозитория на сервере

Бэкенд лежит в том же репо, что и Flutter-приложение:

```bash
cd /var/era_shop_web
git clone https://github.com/buranovt2025-jpg/gogoera.git
# или, если папка уже есть:
cd /var/era_shop_web/gogoera
git fetch origin main && git reset --hard origin/main
```

Папка `backend/` будет в `gogoera/backend/`.

---

## 3. Конфиг бэкенда

В репозитории уже есть `backend/config.js` с настройками под сервер (BASE_URL, secretKey). При необходимости поправь на сервере:

```bash
cd /var/era_shop_web/gogoera/backend
nano config.js
```

Проверь `MONGODB_CONNECTION_STRING` (по умолчанию `mongodb://127.0.0.1:27017/erashop`).

---

## 4. Запуск бэкенда

```bash
cd /var/era_shop_web/gogoera/backend
npm install
pm2 start index.js --name era-backend
pm2 save
pm2 startup
```

Проверка: `curl -s http://127.0.0.1:5000/setting` — должен ответить JSON (или 401 — значит API жив).

---

## 5. Открыть порт 5000

```bash
sudo ufw allow 5000
sudo ufw reload
```

---

## 6. Приложение (Flutter)

В приложении уже прописано:

- **BASE_URL** = `http://146.190.238.186:5000/`
- **SECRET_KEY** = `5TIvw5cpc0`

После деплоя бэкенда пересобери веб и перезагрузи nginx:

```bash
cd /var/era_shop_web/gogoera
git fetch origin main && git reset --hard origin/main
export PATH="/opt/flutter/bin:$PATH"
/opt/flutter/bin/flutter build web --release
sudo chown -R www-data:www-data /var/era_shop_web/gogoera/build/web
sudo systemctl reload nginx
```

---

## 7. Первые данные (категории, настройки)

- Админка Era Shop (отдельный проект) подключается к этому же API и создаёт категории, товары, настройки.
- Либо можно импортировать данные из папки **DB** исходного Era Shop (например `settings.json`, `attributes.json`) в MongoDB вручную или скриптом.

После этого открой **http://146.190.238.186/** — приветствие и логин должны ходить в API; каталог и корзина заработают, когда в базе появятся категории и товары.
