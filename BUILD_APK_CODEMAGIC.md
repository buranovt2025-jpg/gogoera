# Сборка APK через Codemagic (если GitHub Actions не работает)

Codemagic — CI/CD для Flutter, часто собирает APK там, где GitHub Actions падает с Gradle/Kotlin ошибками.

## Шаги

1. **Регистрация:** https://codemagic.io (бесплатный тариф)
2. **Подключить GitHub:** Settings → Integrations → GitHub
3. **Добавить приложение:** Start new application → выберите репо `gogoera`
4. **Workflow:** Codemagic автоматически возьмёт `codemagic.yaml` из корня
5. **Запуск:** Start new build → выберите ветку `main`
6. **Скачать APK:** после сборки — в Artifacts

Файл `codemagic.yaml` уже есть в проекте.
