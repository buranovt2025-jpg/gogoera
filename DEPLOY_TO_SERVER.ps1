# Деплой GogoEra на сервер 165.232.74.201
# Запустить: .\DEPLOY_TO_SERVER.ps1
# Пароль root: buranov1983Timur

$SERVER = "165.232.74.201"
$SCRIPT = "FULL_DEPLOY.sh"

Write-Host "=== Копирование FULL_DEPLOY.sh на сервер ===" -ForegroundColor Cyan
scp -o StrictHostKeyChecking=no $SCRIPT "root@${SERVER}:/root/"

Write-Host "`n=== Запуск деплоя (введите пароль: buranov1983Timur) ===" -ForegroundColor Cyan
Write-Host "Деплой займёт 10-20 минут (установка Node, MongoDB, Flutter, сборка)..." -ForegroundColor Yellow
ssh -o StrictHostKeyChecking=no "root@$SERVER" "chmod +x /root/$SCRIPT && /root/$SCRIPT"

Write-Host "`n=== Готово! ===" -ForegroundColor Green
Write-Host "Сайт:  http://$SERVER/" -ForegroundColor White
Write-Host "API:   http://${SERVER}:5000/" -ForegroundColor White
