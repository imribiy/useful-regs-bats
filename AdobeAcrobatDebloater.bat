@echo off
echo Made by imribiy#0001

cd /d "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat"
taskkill /f /im acrotray.exe
ren acrotray.exe acrotray.old

sc config agmservice start=disabled
sc config agsservice start=disabled

pause