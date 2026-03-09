@echo off
setlocal enabledelayedexpansion

REM --- Поиск строки с .ORG или ORG и извлечение второго слова ---
for /f "tokens=2" %%a in ('findstr /i "\.org org" "%~1"') do (
    set "full_addr=%%a"
)

REM --- Удаление буквы 'h' в конце (регистронезависимо) ---
set "addr=%full_addr:h=%"
set "addr=%addr:H=%"

REM --- Запуск конвертера ---
echo Extracting address: %addr%
bin2tape.exe -t rkr -a %addr% "%~2.obj" "%~2.rkr"

:REM --- Отправляем файл в РК ---
:echo Sending file: %~3\%~2.rkr
:"C:\Program Files (x86)\teraterm5\ttpmacro.exe" /V "%~3\send_rkr.ttl" %~2.rkr
