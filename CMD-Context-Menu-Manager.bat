
@echo off
setlocal
title CMD Context Menu Installer

set "PS1=%TEMP%\CMD_Context_Menu_Installer.ps1"

:MENU
cls
echo ==================================================
echo             CMD CONTEXT MENU INSTALLER
echo ==================================================
echo.
echo   INSTALLATION OPTIONS
echo.
echo   [1] Install CMD Context Menu
echo       Standard user privileges
echo.
echo   [2] Install CMD Context Menu (Administrator)
echo       Elevated privileges with UAC
echo.
echo   [3] Install Both
echo       Standard and Administrator options
echo.
echo   [4] Uninstall All
echo       Remove all custom CMD context menus
echo.
echo   [5] Exit
echo.
echo ==================================================
set /p "choice=Enter your choice [1-5]: "

if "%choice%"=="1" goto RUN
if "%choice%"=="2" goto RUN
if "%choice%"=="3" goto RUN
if "%choice%"=="4" goto RUN
if "%choice%"=="5" exit /b

echo.
echo [ERROR] Invalid selection.
timeout /t 2 >nul
goto MENU

:RUN
cls
echo ==================================================
echo             CMD CONTEXT MENU INSTALLER
echo ==================================================
echo.

> "%PS1%" echo param([string]$Action)
>> "%PS1%" echo $base = 'HKCU:\Software\Classes'
>> "%PS1%" echo $pct = [char]37
>> "%PS1%" echo $roots = @(
>> "%PS1%" echo     @{ Path = "$base\Directory\shell"; Arg = $pct + '1' },
>> "%PS1%" echo     @{ Path = "$base\Directory\Background\shell"; Arg = $pct + 'V' },
>> "%PS1%" echo     @{ Path = "$base\Drive\shell"; Arg = $pct + '1' }
>> "%PS1%" echo ^)
>> "%PS1%" echo function Add-Menu {
>> "%PS1%" echo     param($Name, $Label, $Admin)
>> "%PS1%" echo     foreach ($root in $roots) {
>> "%PS1%" echo         $key = Join-Path $root.Path $Name
>> "%PS1%" echo         New-Item -Path $key -Force ^| Out-Null
>> "%PS1%" echo         Set-Item -Path $key -Value $Label
>> "%PS1%" echo         New-ItemProperty -Path $key -Name Icon -Value 'cmd.exe' -PropertyType String -Force ^| Out-Null
>> "%PS1%" echo         if ($Admin) {
>> "%PS1%" echo             New-ItemProperty -Path $key -Name HasLUAShield -Value '' -PropertyType String -Force ^| Out-Null
>> "%PS1%" echo         }
>> "%PS1%" echo         $commandKey = Join-Path $key 'command'
>> "%PS1%" echo         New-Item -Path $commandKey -Force ^| Out-Null
>> "%PS1%" echo         $command = 'cmd.exe /s /k pushd "' + $root.Arg + '"'
>> "%PS1%" echo         Set-Item -Path $commandKey -Value $command
>> "%PS1%" echo     }
>> "%PS1%" echo }
>> "%PS1%" echo if ($Action -eq '1' -or $Action -eq '3') {
>> "%PS1%" echo     Add-Menu 'OpenCMDHere' 'Open CMD Here' $false
>> "%PS1%" echo }
>> "%PS1%" echo if ($Action -eq '2' -or $Action -eq '3') {
>> "%PS1%" echo     Add-Menu 'runas' 'Open CMD Here (Administrator)' $true
>> "%PS1%" echo }
>> "%PS1%" echo if ($Action -eq '4') {
>> "%PS1%" echo     foreach ($root in $roots) {
>> "%PS1%" echo         Remove-Item (Join-Path $root.Path 'OpenCMDHere') -Recurse -Force -ErrorAction SilentlyContinue
>> "%PS1%" echo         Remove-Item (Join-Path $root.Path 'runas') -Recurse -Force -ErrorAction SilentlyContinue
>> "%PS1%" echo     }
>> "%PS1%" echo }
>> "%PS1%" echo Stop-Process -Name explorer -Force
>> "%PS1%" echo Start-Process explorer.exe
>> "%PS1%" echo Write-Host 'Operation completed successfully.' -ForegroundColor Green

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%PS1%" "%choice%"

del "%PS1%" >nul 2>&1

echo.
echo [INFO] Operation completed.
echo.
pause
goto MENU
