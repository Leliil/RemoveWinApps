@echo off
:: Windows 10/11 Built-in Apps Remover
:: Version: 2.1
:: License: MIT

SETLOCAL ENABLEEXTENSIONS
SETLOCAL ENABLEDELAYEDEXPANSION

:: Параметры запуска
set SILENT_MODE=0
set SKIP_REG=0
set CUSTOM_LIST=0

:: Парсим аргументы
for %%a in (%*) do (
    if /i "%%a"=="/silent" set SILENT_MODE=1
    if /i "%%a"=="/skipreg" set SKIP_REG=1
    if /i "%%a"=="/customlist" set CUSTOM_LIST=1
)

:: Проверка прав администратора
fsutil dirty query %SystemDrive% >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Run as Administrator!
    if %SILENT_MODE%==0 pause
    exit /b 1
)

:: Остановка служб
sc config "AppXSvc" start= disabled >nul 2>&1
sc stop "AppXSvc" >nul 2>&1
sc config "Client License Service" start= disabled >nul 2>&1
sc stop "Client License Service" >nul 2>&1

:: Загрузка списка приложений
if %CUSTOM_LIST%==1 (
    if exist "custom_apps.txt" (
        set /p AppsList=<custom_apps.txt
    ) else (
        echo [ERROR] custom_apps.txt not found!
        if %SILENT_MODE%==0 pause
        exit /b 1
    )
) else (
    set "AppsList=Microsoft.549981C3F5F10 Microsoft.BingWeather Microsoft.GetHelp Microsoft.Getstarted Microsoft.Microsoft3DViewer Microsoft.MicrosoftOfficeHub Microsoft.MicrosoftSolitaireCollection Microsoft.MicrosoftStickyNotes Microsoft.MixedReality.Portal Microsoft.Office.OneNote Microsoft.People Microsoft.SkypeApp Microsoft.Wallet Microsoft.WindowsAlarms Microsoft.WindowsCamera microsoft.windowscommunicationsapps Microsoft.WindowsFeedbackHub Microsoft.WindowsMaps Microsoft.WindowsSoundRecorder Microsoft.Xbox.TCUI Microsoft.XboxApp Microsoft.XboxGameOverlay Microsoft.XboxIdentityProvider Microsoft.YourPhone Microsoft.ZuneMusic Microsoft.ZuneVideo"
)

:: Удаление приложений
for %%a in (%AppsList%) do (
    echo Removing %%a...
    powershell -noprofile -command "Get-AppxPackage -Name '%%a' -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue"
    powershell -noprofile -command "Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq '%%a' | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue"
)

:: Настройки реестра
if %SKIP_REG%==0 (
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f >nul
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f >nul
)

echo Operation completed.
if %SILENT_MODE%==0 pause
