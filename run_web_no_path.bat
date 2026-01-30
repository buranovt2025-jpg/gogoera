@echo off
chcp 65001 >nul
echo Era Shop - zapusk web (esli Flutter ne v PATH)
echo.

set FLUTTER_PATH=C:\flutter\bin\flutter.bat
if not exist "C:\flutter\bin\flutter.bat" (
  echo Flutter ne nayden v C:\flutter
  echo.
  echo Sdelay tak:
  echo 1. Raspakuy flutter_windows_3.38.7-stable.zip v C:\
  echo    chtoby poyavilas papka C:\flutter
  echo 2. Zapusti etot fayl snova
  echo.
  echo Ili otkroy USTANOVIT_FLUTTER.txt
  pause
  exit /b 1
)

cd /d "%~dp0"
echo Zapusk: flutter pub get
"%FLUTTER_PATH%" pub get
echo.
echo Zapusk web-servera na portu 8080...
"%FLUTTER_PATH%" run -d web-server --web-port=8080
echo.
echo Otkroy v brauzere: http://localhost:8080
pause
