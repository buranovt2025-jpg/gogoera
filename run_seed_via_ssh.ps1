# Один запуск — на сервере делаются: git pull, npm install, загрузка тестовых данных.
# Запуск: правый клик -> "Выполнить с PowerShell" или в терминале: .\run_seed_via_ssh.ps1
# Если путь на сервере другой — поменяй $REPO ниже (например /root/gogoera).

$SERVER = "165.232.74.201"
$USER   = "root"
$REPO   = "/var/era_shop_web/gogoera"

$cmd = "cd $REPO && git pull || true && cd backend && npm install && node DB/seed_test_data.js"
Write-Host "Connecting to ${USER}@${SERVER} ..."
ssh "${USER}@${SERVER}" "$cmd"
Write-Host "Finished."
