@echo off
echo Made by imribiy#0001

cd /d "C:\Program Files\"
dir AdobeIPCBroker.exe /a /b /s
taskkill /f /im AdobeIPCBroker.exe
del AdobeIPCBroker.exe /a /s

cd /d "C:\Program Files (x86)\"
dir AdobeIPCBroker.exe /a /b /s
taskkill /f /im AdobeIPCBroker.exe
del AdobeIPCBroker.exe /a /s

pause