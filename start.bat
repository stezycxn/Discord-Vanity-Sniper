@echo off
color a
title Stezy-Vanityservice

setlocal enabledelayedexpansion
set "licenseCheck=0"
set "encodedString=U3RlemkgU2VjdXJlIHRoYXQgaXMgbm8gYmFzZWQgb2YgdGhlIGxpc2FucyBhbmQgYWxsIHRoZSBhZ2VudCBvZiB0aGUgY29udGVudA=="
set "fileName=main.js"

for /f %%A in ('powershell -noprofile -command "[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('%encodedString%'))"') do (
    findstr /i /c:"%%A" "%fileName%" >nul && set "licenseCheck=1"
)

if !licenseCheck! equ 1 (
    echo [Info] Lisans doğrulandı, uygulama başlatılıyor...
    call :runApp
) else (
    echo [Error] Lisans anahtarı geçersiz veya eksik.
    timeout /t 5 /nobreak >nul
    exit /b
)
pause

:runApp
node main.js
