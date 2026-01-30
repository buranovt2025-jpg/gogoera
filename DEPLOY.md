# Сборка и деплой (DigitalOcean)

## Что собираем

| Компонент | Где | Действие |
|-----------|-----|----------|
| **Мобильное приложение** | этот репозиторий (Flutter) | `flutter build apk` / `flutter build appbundle` |
| **Веб-версия приложения** | этот репозиторий | `flutter build web` → выложить в `backend/public` или на CDN |
| **Backend + Admin** | архив era-shop-v2 (Source Code: backend, admin.zip, DB, install.sh) | Деплой на сервер (Node.js, MongoDB, Nginx) |

Перед сборкой в приложении обязательно задать **BASE_URL** и **SECRET_KEY** в `lib/utiles/api_url.dart`.

---

## Размер дроплета на DigitalOcean

Для **backend + MongoDB + Nginx + Admin** (по скрипту install.sh из era-shop-v2):

| Назначение | План | RAM | vCPU | Цена (примерно) |
|------------|------|-----|------|------------------|
| **Минимум (тест/разработка)** | Basic, 2 GB | 2 GB | 1 | ~12 $/мес |
| **Рекомендуемый (продакшен)** | Basic, 4 GB | 4 GB | 2 | ~24 $/мес |
| **С запасом (трафик, рилсы, live)** | Basic, 8 GB | 8 GB | 4 | ~48 $/мес |

**Рекомендация:** начать с **4 GB** — MongoDB и Node комфортно работают, остаётся запас под трафик и сборки. Если бюджет жёсткий — можно **2 GB**, но под мониторингом памяти.

Регион: ближайший к пользователям (например Frankfurt или Amsterdam для СНГ/Европы).

---

## Подготовка к сборке (локально)

```bash
# 1. Клонировать
git clone https://github.com/buranovt2025-jpg/gogoera.git
cd gogoera

# 2. Настроить API (обязательно)
# Открыть lib/utiles/api_url.dart и задать:
#   BASE_URL = "https://ваш-домен.com/";   // или IP дроплета
#   SECRET_KEY = "ваш_секретный_ключ";

# 3. Зависимости
flutter pub get

# 4. Сборка Android (APK)
flutter build apk --release

# 4b. Сборка веб (для выкладки на сервер)
flutter build web --release
# Результат: build/web/ — скопировать на сервер в backend/public или раздавать через Nginx
```

APK будет в `build/app/outputs/flutter-apk/app-release.apk`.

---

## Твой сервер (AMS3)

| Параметр | Значение |
|----------|----------|
| **IPv4** | `146.190.238.186` |
| **Частный IP** | 10.110.0.2 |
| **ОС** | Ubuntu 24.04 (LTS) x64 |
| **План** | 2 GB RAM / 1 vCPU Intel / 70 GB диск |

**Подключение по SSH:**
```bash
ssh root@146.190.238.186
```

⚠️ **Безопасность:** смени пароль root после первого входа и настрой вход по SSH-ключу (отключи вход по паролю в `sshd_config`).

**В приложении (до сборки):** в `lib/utiles/api_url.dart` задай:
- `BASE_URL = "http://146.190.238.186:5000/";` (пока без домена) или `https://твой-домен.com/` после настройки SSL.
- `SECRET_KEY` — тот же, что задашь в install.sh на сервере.

**Первый запуск на сервере (после загрузки backend из era-shop-v2):**
```bash
ssh root@146.190.238.186
# Сменить пароль: passwd
# Залить backend (scp/rsync или git), затем:
cd /path/to/backend   # или куда положишь Source Code
chmod +x install.sh
./install.sh
# Ввести: домен (или 146.190.238.186), имя приложения, секретные ключи
```

---

## Деплой backend на DigitalOcean

1. **Создать дроплет**  
   - Ubuntu 22.04 LTS  
   - Размер: **4 GB RAM** (или 2 GB для теста)  
   - Добавить SSH-ключ.

2. **Залить исходники backend**  
   Из архива era-shop-v2: папки backend, frontend (admin), DB, скрипт install.sh.

3. **Запустить установку** (на сервере):
   ```bash
   chmod +x install.sh
   ./install.sh
   ```
   Скрипт спросит: домен, имя приложения, секретные ключи; установит Node.js, Nginx, MongoDB, PM2, соберёт админку и настроит backend.

4. **Домен и SSL**  
   Указать A-запись домена на IP дроплета. В install.sh будет предложен certbot (Let's Encrypt) для HTTPS.

5. **В приложении**  
   В `api_url.dart` указать `BASE_URL = "https://ваш-домен.com/"` и тот же `SECRET_KEY`, что на бэкенде.

---

## Чек-лист перед сборкой

- [ ] В `lib/utiles/api_url.dart` заданы BASE_URL и SECRET_KEY
- [ ] Backend уже развёрнут и доступен по BASE_URL (или сначала деплой, потом сборка приложения)
- [ ] Для Android: при необходимости подставлен свой `google-services.json`
- [ ] Для веб: после `flutter build web` папку `build/web` выложить на тот же домен или поддомен

После этого можно проводить сборку (APK / web) и деплой на DigitalOcean по шагам выше.
