@echo off
echo. > cafeteiras.log
echo Iniciando testes...

set PASSOU=0
set FALHOU=0
set esperado=10

echo. > cafeteiras.log

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

set esperado=1
call cafeteira04.bat 3
call :verificar "cafeteira04.bat 3"

echo.
echo =========================
echo TESTES FINALIZADOS
echo =========================
echo Passaram: %PASSOU%
echo Falharam: %FALHOU%
echo.
pause
goto :eof

:verificar
set TESTE=%~1
set EL=%ERRORLEVEL%
if %EL% EQU %esperado% (
    set /a PASSOU+=1
    echo [OK]    %TESTE% - esperado: %esperado% obtido: %EL% >> cafeteiras.log
) else (
    set /a FALHOU+=1
    echo [ERRO]  %TESTE% - esperado: %esperado% obtido: %EL% >> cafeteiras.log
)
goto :eof
