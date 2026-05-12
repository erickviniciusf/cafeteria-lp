@echo off
echo =====================
echo      CAFETEIRA 03
echo =====================
echo.
echo [1] Pequeno
echo [2] Medio
echo [3] Grande
echo.

set /p op=Escolha:

if "%op%"=="1" (
    node cafeteria.js 03 p
if "%op%"=="2"
    node cafeteria.js 03 m
if "%op%"=="3" 
	node cafeteria.js 03 g
pause
