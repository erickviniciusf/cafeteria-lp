@echo off

set op=%1

if "%op%"=="1" (
    node cafeteria.js 02 p
) else if "%op%"=="2" (
    node cafeteria.js 02 m
) else if "%op%"=="3" (
    node cafeteria.js 02 g
) else (
    node cafeteria.js 02 %op%
)
