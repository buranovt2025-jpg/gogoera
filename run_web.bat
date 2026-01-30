@echo off
echo Era Shop - запуск веб-версии
echo.
cd /d "%~dp0"
flutter pub get
flutter run -d web-server --web-port=8080
echo.
echo Открой в браузере: http://localhost:8080
pause
