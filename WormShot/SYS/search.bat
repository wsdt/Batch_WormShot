@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
mode con lines=1 cols=15

REM Sys-Ordner
cd "C:\users\%username%\WormShot\" || MD "C:\users\%username%\WormShot\"&cd "C:\users\%username%\WormShot\"
rem set wormpfad=N:\Verkauf\Etc\Sonstiges\Security\WormShot\
rem cd "%wormpfad%" || echo ERROR ####: Wormshot-Pfad nicht gefunden. >> "Error.txt" && exit

echo %date% - %time:~0,5%: * WormShot ACTIVATED * >> "Verlauf.txt"

:control
title Search
if exist "Do.bat" goto waitwhiledoing
REM Der Ordner muss standardmäßig alle Dateien, vorangestellt mit "0_*" enthalten,
REM damit nicht alle Dateien ausgeführt werden. 


REM Setze alle Variablen auf OFF
if not exist "SYS\search_undefine.bat" echo ERROR 005: Search_Undefine.bat nicht gefunden. >> "ERROR.txt"&&echo WormShot pausiert.&pause >nul&exit
call "SYS\search_undefine.bat"

for /L %%a in (1 0 2) do (
set scheduleplan=no 

REM Zeitplaner
if not exist "SYS\rundo_schedule.bat" echo ERROR 008: Rundo_Schedule musste neu erstellt werden. >> "ERROR.txt"&&echo echo Windows Update 64 Bit..  Fenster nicht schliessen > "SYS\rundo_schedule.bat"
call "SYS\rundo_schedule.bat" 
if /i "!scheduleplan:~0,3!"=="yes" echo echo Windows Update 64 Bit..  Fenster nicht schliessen > "SYS\rundo_schedule.bat"
timeout 0 /NOBREAK >Nul
REM Suche nach aktuellen Befehlen
if not exist "SYS\search_doit.bat" echo ERROR 006: Search_DoIt.bat nicht gefunden. >> "ERROR.txt"&&echo WormShot pausiert_2.&pause >nul&exit
call "SYS\search_doit.bat" 

if exist "Do.bat" call :waitwhiledoing
REM Evtl in Sekunden-Takt, dann noch 5-10 Sekunden lang nach weiteren Befehlen suchen. (Vorteil: Mehrere Befehle, Nachteil: Verzögerung (Durch Netzwerk sowieso))

if exist "1_WormShot_Standby.bat" ren "1_WormShot_Standby.bat" "0_WormShot_Standby.bat"&&call :standby
)
:waitwhiledoing
title LoadRunDo
if not exist "SYS\rundo.bat" echo ERROR 001: Rundo.bat existiert nicht. >> "ERROR.txt"
if exist "SYS\rundo.bat" call "Sys\rundo.bat"
cls
title Waiting4Doing
for %%b in (1 0 2) do (
REM Warten bis ausgeführt, denn nach Ausführung: Do.bat von anderem Programm löschen. 
if exist "Do.bat" REM WAIT
if not exist "Do.bat" goto control
timeout 0 /NOBREAK >NUL
)
goto control
echo ERROR 002: Hier solltest du nicht hin. >> "ERROR.txt"

:standby
echo * WormShot STANDBY Modus * aktiviert >> "Verlauf.txt"
for /L %%c in (1 0 2) do (
if exist "1_WormShot_ON.bat" ren "1_WormShot_ON.bat" "0_WormShot_ON.bat"&&call "SYS\search.bat"
if exist "1_WormShot_OFF.bat" ren "1_WormShot_OFF.bat" "0_WormShot_OFF.bat"&&echo set wormshot-oneway_off=on>> "DO.bat"&&call "SYS\search.bat"
timeout 1 /NOBREAK >NUl
)