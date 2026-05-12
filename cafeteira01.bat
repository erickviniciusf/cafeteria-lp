@echo off
echo =====================
echo      CAFETEIRA 01
echo =====================
echo.
echo [1] Pequeno
echo [2] Medio
echo [3] Grande
echo.

set /p op=Escolha:

if "%op%"=="1" (
    node cafeteria.js 01 p
if "%op%"=="2"
    node cafeteria.js 01 m
if "%op%"=="3" 
	node cafeteria.js 01 g
pause
