@echo off
title Grandma Services by imribiy#0001
cls

::Services that I disable on my grandma's laptop. So you can too.

cd %systemroot%\system32
call :IsAdmin

echo "Disabling Background Apps"
Reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground" /t REG_DWORD /d "2" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground_UserInControlOfTheseApps" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground_ForceAllowTheseApps" /f
Reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsRunInBackground_ForceDenyTheseApps" /f
cls

echo "Adjusting SvcHostSplitThreshold"
::Doesn't do anything performance wise but decrease process number, so people like it. You can remove this line, not necessary.
reg add "HKLM\SYSTEM\CurrentControlSet\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4294967295" /f
cls

echo "Disabling Font Cache"
sc config fontcache start=disabled
sc config fontcache3.0.0.0 start=disabled
::Some editions of MS Office requires them to be enabled. If you get such error please remove :: at two bottom services.
::sc config fontcache start=auto
::sc config fontcache3.0.0.0 start=demand
cls

echo "Disabling Superfetch"
::Delete this segment if your operating system is installed on HDD.
sc config sysmain start=disabled
cls

echo "Disabling Telemetry Services"
::Delete this segment if you are using troubleshooting often.
::Disabling DPS will break troubleshooting, delete the line if you need that feature often. Default value for it is start=auto.
sc config dps start=disabled
sc config wdisystemhost start=disabled
sc config wdiservicehost start=disabled
sc config diagtrack start=disabled
sc config dssvc start=disabled
sc config dusmsvc start=disabled
sc config diagsvc start=disabled
sc config telemetry start=disabled
sc config diagnosticshub.standardcollector.service start=disabled
::Disabling ndu can cause problem if you are using mobile hotspot.
sc config ndu start=disabled
cls

echo "Disabling ReadyBoost"
::ReadyBoost technology is a feature from the pre-SSD era of SATA 2 hard drives, which was designed to help USB sticks cache hard drives. Today, this technology is completely redundant, whether you use a hard disk or an SSD.
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Class\{71a27cdd-812a-11d0-bec7-08002be2092f}" /v "LowerFilters" /t REG_MULTI_SZ /d "" /f
sc config rdyboost start=disabled
cls

echo "Disabling Themes"
::Delete this segment if you use custom Windows themes.
sc config themes start=disabled
cls

echo "Disabling Program Compatibility Assistant"
::Delete this segment if you have a program that needs to be run with Compatibility mode.
sc config pcasvc start=disabled
cls

echo "Disabling Sensors"
::Delete this segment if you are using sensors on your device. e.g. Automatic brightness sensor.
sc config sensrsvc start=disabled
sc config sensordataservice start=disabled
sc config sensorservice start=disabled
cls

echo "Disabling Smart Card"
::Delete this segment if you are using smart card.
sc config scardsvr start=disabled
sc config scdeviceenum start=disabled
sc config scpolicysvc start=disabled
cls

echo "Disabling Virtualization Services"
::Delete this segment if you are using any kind of virtualization on your machine.
sc config uevagentservice start=disabled
sc config uevagentdriver start=disabled
sc config appvclient start=disabled
cls

echo "Disabling Autoplay"
::Delete this segment if you need Autoplay.
sc config shellhwdetection start=disabled
cls

echo "Disabling OneSync"
::The OneSyncSvc synchronizes your Microsoft Account, OneDrive, Windows Mail, Contacts, Calendar and various other Apps. 
::Your Mail App and other Apps and services, which are dependent upon this functionality, will not work properly when this service is disabled or not running.
sc config onesyncsvc start=disabled
cls

echo "Disabling Beep"
sc config beep start=disabled
cls

echo "Services has been disabled, please reboot your system."
pause

:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 Pause & Exit
)
Cls
goto:eof
