@echo off
chcp 65001 > nul

echo Resetando sistema...

(
echo 01 Copa 990
echo 02 Sala 100
echo 03 Cozinha 000
echo 04 Cozinha 032
) > cafeteiras.cad

echo. > cafeteiras.log

echo Sistema resetado com sucesso.

pause
