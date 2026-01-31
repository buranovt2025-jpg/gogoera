#!/bin/bash
# Установка Android SDK на сервер для сборки APK
# Запуск: sudo bash INSTALL_ANDROID_SDK.sh

set -e

ANDROID_HOME="/opt/android-sdk"
CMD_TOOLS="commandlinetools-linux-13114758_latest.zip"
CMD_TOOLS_URL="https://dl.google.com/android/repository/${CMD_TOOLS}"

echo "=== Установка Android SDK ==="

# Создаём директорию
mkdir -p $ANDROID_HOME
cd $ANDROID_HOME

# Скачиваем command-line tools
if [ ! -f "$CMD_TOOLS" ]; then
  echo "Скачивание Android command-line tools..."
  wget -q "$CMD_TOOLS_URL" || curl -L -o "$CMD_TOOLS" "$CMD_TOOLS_URL"
fi

# Распаковываем (Android требует cmdline-tools/latest/)
if [ ! -d "cmdline-tools/latest" ]; then
  unzip -q -o "$CMD_TOOLS"
  if [ -d "cmdline-tools" ] && [ ! -d "cmdline-tools/latest" ]; then
    mkdir -p cmdline-tools/latest
    mv cmdline-tools/bin cmdline-tools/lib cmdline-tools/NOTICE.txt cmdline-tools/source.properties cmdline-tools/latest/ 2>/dev/null || true
  fi
fi

# Устанавливаем SDK
echo "Установка platforms и build-tools..."
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --sdk_root=$ANDROID_HOME \
  "platform-tools" \
  "platforms;android-34" \
  "build-tools;34.0.0" 2>/dev/null || true

echo ""
echo "=== Готово! Добавьте в ~/.bashrc или выполните: ==="
echo "export ANDROID_HOME=$ANDROID_HOME"
echo "export PATH=\$PATH:\$ANDROID_HOME/platform-tools:\$ANDROID_HOME/cmdline-tools/latest/bin"
echo ""
echo "Затем: source ~/.bashrc && cd /var/era_shop_web/gogoera && flutter build apk --release"
