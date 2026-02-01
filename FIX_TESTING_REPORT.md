# Исправление по отчёту тестирования GogoEra

## Критические проблемы и решения

### 1. Белый экран / отсутствие main.dart.js (404)

**Причина:** Неправильная сборка или неполный деплой Flutter Web.

**Исправления (внесены):**
- Добавлен явный `--base-href /` во все скрипты сборки
- Добавлена проверка после сборки (REBUILD_WEB.sh, DEPLOY_ALL.sh)
- Обновлена конфигурация nginx (location для .json, /assets/)

**Что сделать на сервере:**

```bash
cd /var/era_shop_web/gogoera
bash REBUILD_WEB.sh
```

Или полная пересборка:
```bash
git pull
export PATH="/opt/flutter/bin:$PATH"
flutter clean && flutter pub get
flutter build web --release --base-href / --web-renderer html --pwa-strategy=none
sudo chown -R www-data:www-data build/web
sudo systemctl reload nginx
```

Проверить наличие файлов:
```bash
ls -la build/web/*.js build/web/index.html
# Должны быть: flutter_bootstrap.js и/или main.dart.js, index.html
```

### 2. Админ (admin@test.com) — перенаправление на регистрацию

**Причина:** Flutter-приложение Era Shop предназначено для **покупателей и продавцов**. Админ-панель — **отдельное приложение** (отдельный URL/поддомен), которое не входит в этот репозиторий.

**Решение:** Админ входит через свою панель (обычно `/admin` или отдельный поддомен). Для входа в мобильное/веб-приложение Era Shop используйте:
- **Покупатель:** buyer@test.com / 12345678
- **Продавец:** erashoptest@gmail.com / 12345678 (или кнопка «Seller Demo Account»)

### 3. Nginx и Flutter Web

Обновлённый конфиг nginx в скриптах DEPLOY_ALL.sh и FULL_DEPLOY.sh:
- Location для `.json` (manifest.json и др.)
- Location для `/assets/`
- SPA fallback: `try_files $uri $uri/ /index.html`

### 4. Безопасность (по отчёту — Приоритет 2)

- **Секреты:** перенести в `.env` (config.js, api_url.dart)
- **Пароли:** мигрировать с Cryptr на bcrypt (backend)
- **Валидация:** добавить Joi/express-validator
- **Rate limiting:** добавить express-rate-limit

---

## Быстрая проверка после деплоя

1. Открыть http://165.232.74.201/
2. Открыть DevTools (F12) → вкладка Network
3. Обновить страницу (Ctrl+F5)
4. Убедиться: `flutter_bootstrap.js`, `main.dart.js` (или эквивалент) — статус 200, не 404
5. Войти как buyer@test.com / 12345678 — должен загрузиться интерфейс
