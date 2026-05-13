@echo off

echo. > cafeteiras.log

call cafeteira01.bat 1
call cafeteira02.bat 2
call cafeteira03.bat 3
call cafeteira04.bat 1
call cafeteira01.bat 2

type cafeteiras.log

pause
