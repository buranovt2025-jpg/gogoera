# Era Shop — чистая копия (Flutter)

Копия мобильного приложения Era Shop (e-commerce с рилсами, live-продажами, галереей), готовая к настройке. В репозитории есть **Flutter-приложение** и **Node.js бэкенд** (папка `backend/`).

## Один скрипт на сервере (всё сразу)

На сервере (Ubuntu) с уже установленным Flutter в `/opt/flutter`:

```bash
git clone https://github.com/buranovt2025-jpg/gogoera.git
cd gogoera
bash DEPLOY_ALL.sh
```

Скрипт сам: подтянет репо (или клонирует), установит Node 18, MongoDB, PM2, запустит бэкенд, соберёт веб, настроит Nginx. После этого сайт: **http://IP_СЕРВЕРА/** и API: **http://IP_СЕРВЕРА:5000/**.

## Что нужно сделать перед запуском (если не используешь DEPLOY_ALL.sh)

1. **Backend**  
   Приложение работает с API Era Shop (админка + бэкенд). Нужен развёрнутый сервер по документации из архива `era-shop-v2` (Source Code: admin, backend, MongoDB, install.sh).

2. **Настройка приложения**  
   В проекте откройте файл:
   - `lib/utiles/api_url.dart`

   Заполните:
   - **BASE_URL** — адрес вашего API, например `https://your-domain.com/` или `http://192.168.1.100:5000/`
   - **SECRET_KEY** — секретный ключ API (тот же, что в `config.js` на бэкенде)

3. **Firebase**  
   В проекте используются Firebase (Auth, Messaging, Crashlytics). Добавьте свои:
   - `android/app/google-services.json`
   - Настройки iOS в Xcode (GoogleService-Info.plist при необходимости)

4. **Платежи (по желанию)**  
   Ключи Stripe, Razorpay, Flutterwave задаются на бэкенде и при необходимости в `lib/utiles/globle_veriables.dart` (опционально).

## Запуск

```bash
flutter pub get
flutter run
```

## Как увидеть веб-версию

**Локально (сразу в браузере):**
1. Открой папку проекта в терминале (CMD или PowerShell).
2. Запусти `run_web.bat` или выполни:
   ```bash
   flutter pub get
   flutter run -d web-server --web-port=8080
   ```
3. Открой в браузере: **http://localhost:8080**

(Без бэкенда часть экранов может показывать ошибки загрузки — интерфейс будет виден.)

**На сервере (чтобы открыть по IP):** собери `flutter build web`, скопируй папку `build/web` на сервер и раздай через Nginx (см. DEPLOY.md).

## Структура (кратко)

- **lib/View** — экраны: онбординг, логин, главная, галерея, рилсы, live, корзина, чекаут, профиль, продавец, заказы и т.д.
- **lib/ApiService** — запросы к API (логин, товары, корзина, заказы, рилсы, продавец).
- **lib/Controller** — GetX-контроллеры.
- **lib/utiles/api_url.dart** — базовый URL и ключ API (обязательно настроить).

Оригинальный архив с ошибками/пустым конфигом не трогаем; этот проект — отдельная, правильно собранная копия для разработки и деплоя.
