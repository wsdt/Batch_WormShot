@echo off
title RunDo
cd "C:\users\%username%\WormShot\"
rem set wormpfad=N:\Verkauf\Etc\Sonstiges\Security\WormShot\
rem cd "!wormpfad!"
if not exist "Do.bat" echo ERROR 003: Do.bat existiert nicht.>>"Error.txt"
if exist "Do.bat" call "Do.bat"

call "SYS\rundo_doit.bat"
if exist "Do.bat" del "Do.bat"
if exist "Do.bat" echo ERROR 004: Do.bat wurde nicht geloescht.>>"Error.txt"

if /i "%wormshot_off:~0,2%"=="on" set wormshot-oneway_off=off&echo %date% (%time:~0,5%): * WormShot-OneWay_OFF * ausgefuehrt >> "Verlauf.txt"&&call "0_wormshot_off.bat"