@echo off

set op=%1

if "%op%"=="1"
    node cafeteria.js 01 p

if "%op%"=="2"
    node cafeteria.js 01 m

if "%op%"=="3"
    node cafeteria.js 01 g
