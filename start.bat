@echo off
color a
title Stezy-Vanityservice

:: Gizli Lisans Kontrolü
setlocal enabledelayedexpansion
set "licenseCheck=0"
set "encodedString=Licen.*: Stez"
set "fileName=main.js"

:: Lisans kontrol fonksiyonu
call :checkLicense
if !licenseCheck! equ 1 (
    echo [Info] Lisans dogrulandi, uygulama baslatiliyor...
    call :runApp
) else (
    echo [Error] Lisans anahtariniz yok veya hatali.
    timeout /t 5 /nobreak >nul
    exit /b
)
pause

:: Lisans kontrol alt yordamı
:checkLicense
for /f "delims=" %%A in ('findstr /R /C:"%encodedString%" "%fileName%" 2^>nul') do (
    set "licenseCheck=1"
)
goto :eof

:runApp
:: Ana uygulama döngüsü
setlocal enabledelayedexpansion
set "loopCounter=1"
set "maxRetries=5"
:stezyStart
if !loopCounter! lss !maxRetries! (
    node main.js
    if !errorlevel! neq 0 (
        echo [Warning] Uygulama hatasi, !loopCounter!. tekrar deneniyor...
        set /a loopCounter+=1
        timeout /t 2 /nobreak >nul
    ) else (
        set "loopCounter=0"
    )
    goto :stezyStart
)
if !loopCounter! geq !maxRetries! (
    echo [Error] Maksimum deneme sayisina ulasildi, uygulama basarisiz.
    exit /b
)
endlocal
exit /b
