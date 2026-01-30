# Статус проекта Era Shop — сохранить на завтра

**Дата:** 31 января 2026  
**Репозиторий:** https://github.com/buranovt2025-jpg/gogoera  
**Сайт:** http://146.190.238.186/  
**API:** http://146.190.238.186:5000/

---

## Что сделано

- Деплой на сервер: Flutter web, Node.js бэкенд, PM2, Nginx, MongoDB.
- Исправления для сборки: `DropdownController<String>`, `Constant.getApiAuthority`, Stripe без ключей в коде.
- Lighthouse: Nginx кэш статики и заголовки безопасности в `DEPLOY_ALL.sh`; описание в `LIGHTHOUSE_IMPROVEMENTS.md`.
- HTTP/консоль: Service Worker только на HTTPS; preload с `crossorigin`; проверка Stripe при пустом ключе (cheak_out, stripe_pay).

---

## Что закоммитить сегодня (если ещё не запушено)

- `DEPLOY_ALL.sh` — кэш статики и security headers в Nginx.
- `LIGHTHOUSE_IMPROVEMENTS.md` — заметки по улучшению Lighthouse.
- Ранее: `web/index.html` (SW + crossorigin), `cheak_out.dart`, `stripe_pay.dart` (Stripe guard) — проверить, что уже в main.

---

## Завтра продолжить

1. На Windows: `cd C:\Users\buran\era_shop_clean` → при необходимости `git add`, `git commit`, `git push origin main`.
2. На сервере: `cd /var/era_shop_web/gogoera` → `git pull origin main` → `bash DEPLOY_ALL.sh`.
3. Проверить сайт, Lighthouse и консоль (без ошибок Stripe/SW на HTTP).
4. При желании: HTTPS (домен + certbot) для роста Best Practices.

---

## Тестовые аккаунты (из seed)

- Покупатель: `buyer@test.com` / `12345678`
- Сид данных: на сервере `cd backend && node DB/seed_test_data.js`
