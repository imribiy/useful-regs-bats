@echo off

title Windows Search toggle script made by imribiy#0001
cls

echo.	This script allows you to enable-disable Windows Search service and it's subcomponents easily.
echo.	Press [D] to disable Windows Search
echo.	Press [E] to enable Windows Search
echo.
set /p c="Enter your answer: "
if /i %c% equ D goto :disable
if /i %c% equ E goto :enable

:disable
cls
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wsearch" /v "Start" /t REG_DWORD /d "4" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "0" /f
sc stop wsearch
taskkill /f /im explorer.exe
taskkill /f /im searchapp.exe
cd C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy
takeown /f "searchapp.exe"
icacls "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\searchapp.exe" /grant Administrators:F
ren searchapp.exe searchapp.old
start explorer.exe
cls
pause
exit

:enable
cls
Reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\wsearch" /v "Start" /t REG_DWORD /d "2" /f
Reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d "1" /f
sc start wsearch
taskkill /f /im explorer.exe
taskkill /f /im searchapp.exe
cd C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy
takeown /f "searchapp.exe"
icacls "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\searchapp.exe" /grant Administrators:F
ren searchapp.old searchapp.exe
start explorer.exe
cls
pause
exit