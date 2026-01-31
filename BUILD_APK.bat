@echo off
REM Сборка APK для Android
REM Запуск: BUILD_APK.bat (или дважды клик)
REM APK будет в: build\app\outputs\flutter-apk\app-release.apk

cd /d "%~dp0"

echo === Сборка APK ===
flutter clean
flutter pub get
flutter build apk --release

if %ERRORLEVEL% EQU 0 (
  echo.
  echo === Готово! ===
  echo APK: build\app\outputs\flutter-apk\app-release.apk
  echo.
  start "" "build\app\outputs\flutter-apk"
) else (
  echo.
  echo Ошибка сборки.
  pause
)
