#!/bin/bash
# Сборка APK на сервере (после установки Android SDK)
# Запуск: cd /var/era_shop_web/gogoera && bash BUILD_APK_SERVER.sh

set -e
cd "$(dirname "$0")"

export PATH="/opt/flutter/bin:$PATH"
export ANDROID_HOME="${ANDROID_HOME:-/opt/android-sdk}"
export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin"

echo "=== Сборка APK на сервере ==="
flutter clean
flutter pub get
flutter build apk --release

echo ""
echo "=== Готово! ==="
echo "APK: $(pwd)/build/app/outputs/flutter-apk/app-release.apk"
echo ""
echo "Скачать на ПК (из PowerShell):"
echo "scp root@165.232.74.201:$(pwd)/build/app/outputs/flutter-apk/app-release.apk C:\Users\buran\Downloads\"
