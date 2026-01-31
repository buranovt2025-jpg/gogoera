# GogoEra — Era Shop

E‑commerce приложение (Flutter + Node.js backend). Тестовая среда: **http://165.232.74.201/**

## Быстрый деплой на новый сервер

```bash
ssh root@165.232.74.201
# Скопировать FULL_DEPLOY.sh на сервер, затем:
chmod +x FULL_DEPLOY.sh
./FULL_DEPLOY.sh
```

Или одной командой с локального ПК:
```bash
scp FULL_DEPLOY.sh root@165.232.74.201:/root/
ssh root@165.232.74.201 "chmod +x /root/FULL_DEPLOY.sh && /root/FULL_DEPLOY.sh"
```

## Структура

| Компонент | Путь |
|-----------|------|
| Flutter (мобильное + веб) | корень репо |
| Backend (Node.js, Express, MongoDB) | `backend/` |
| Веб-сборка | `build/web/` (после `flutter build web`) |

## Конфигурация

- **API URL:** `lib/utiles/api_url.dart` — `BASE_URL`, `SECRET_KEY`
- **Backend:** `backend/config.js` — `baseURL`, `secretKey`, `MONGODB_CONNECTION_STRING`

## Ссылки

- Сайт: http://165.232.74.201/
- API: http://165.232.74.201:5000/
