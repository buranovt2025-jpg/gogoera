# Работа только через консоль хостинга (без ПК)

Весь код лежит в GitHub. На сервере ты только подтягиваешь его и запускаешь. Можно работать только по SSH.

---

## 1. Один раз: настроить Git на сервере (если будешь пушить с сервера)

```bash
ssh root@146.190.238.186
git config --global user.email "tvoj@email.com"
git config --global user.name "Tvoё Imya"
```

Чтобы **пушить с сервера** в GitHub, нужен токен (не пароль):

- GitHub → Settings → Developer settings → Personal access tokens → создать токен (права `repo`).
- При `git push` логин: твой GitHub-логин, пароль: **вставить токен**.

Если пушить с сервера не планируешь — этот шаг можно не делать.

---

## 2. Подтянуть код и задеплоить (каждый раз после изменений в GitHub)

```bash
ssh root@146.190.238.186
cd /var/era_shop_web/gogoera
git pull
bash DEPLOY_ALL.sh
```

Сайт: **http://146.190.238.186/**  
API: **http://146.190.238.186:5000/**

---

## 3. Тестовые данные (один раз)

```bash
cd /var/era_shop_web/gogoera/backend
node DB/seed_test_data.js
```

Если файла нет — сначала создать его скриптом (если есть в репо):

```bash
bash DB/SEED_ON_SERVER.sh
node DB/seed_test_data.js
```

Аккаунты: покупатель `buyer@test.com` / `12345678`, продавец `erashoptest@gmail.com` / `12345678`.

---

## 4. Редактировать файлы на сервере (nano)

```bash
cd /var/era_shop_web/gogoera
nano lib/utiles/api_url.dart    # например: поменять BASE_URL
# Ctrl+O — сохранить, Enter, Ctrl+X — выйти
```

После правок: пересобрать и перезапустить (п. 2).

---

## 5. Сохранить изменения с сервера в GitHub (если правил на сервере)

```bash
cd /var/era_shop_web/gogoera
git add .
git commit -m "описание правок"
git push origin main
```

При `git push` спросит логин и пароль — пароль = **токен GitHub**.

---

## Кратко

| Действие | Команды на сервере |
|----------|--------------------|
| Обновить сайт из GitHub | `cd /var/era_shop_web/gogoera && git pull && bash DEPLOY_ALL.sh` |
| Загрузить тестовые данные | `cd /var/era_shop_web/gogoera/backend && node DB/seed_test_data.js` |
| Отправить свои правки в GitHub | `cd /var/era_shop_web/gogoera && git add . && git commit -m "..." && git push origin main` |

Код хранится в GitHub — с любого компьютера (ПК, Mac) можно сделать `git clone` или `git pull` и продолжить работу.
