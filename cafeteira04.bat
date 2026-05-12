@echo off
echo =====================
echo      CAFETEIRA 04
echo =====================
echo.
echo [1] Pequeno
echo [2] Medio
echo [3] Grande
echo.

set /p op=Escolha:

if "%op%"=="1" node cafeteria.js 04 p && echo %date% %time% 04 p ok >> cafeteiras.log
if "%op%"=="2" node cafeteria.js 04 m && echo %date% %time% 04 m erro: >> cafeteiras.log
if "%op%"=="3" node cafeteria.js 04 g && echo %date% %time% 04 g ok >> cafeteiras.log

pause