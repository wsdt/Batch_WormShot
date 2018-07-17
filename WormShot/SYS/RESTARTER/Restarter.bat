@echo off
cd "C:\users\%username%\Wormshot\"
REM eigenes Programm das Wormshot neustartet (bei Fehlern)
set versuche=-1
:pruefe
set /a versuche=%versuche%+1
if exist "Z_TestPING.WSDT" if exist "X_TestPING.WSDT" echo ERROR ####: De- und Aktivierte Ping-Datei gefunden.&timeout 10 >nul&del "Z_TestPING.WSDT"
if exist "Z_TestPING.WSDT" ren "Z_TestPING.WSDT" "X_TestPING.WSDT"
if not exist "X_TestPING.WSDT" echo ERROR ####: PING-Datei nicht vorhanden.&timeout 5 >Nul&echo Pruef-Datei > "X_TestPING.WSDT"
if exist "X_TestPING.WSDT" ren "X_TestPING.WSDT" "Z_TestPING.WSDT"&timeout 2 /NOBREAK >Nul
if exist "X_TestPING.WSDT" set wormshotstatus=ACTIVATED&set versuche=0
if exist "Z_TestPING.WSDT" set wormshotstatus=DEACTIVATED&if %versuche% geq 0 echo MELDUNG: Wormshot war deaktiviert (%time%, %date%) >> "Restart_Log.wsdt"

if /i "%wormshotstatus%"=="ACTIVATED" timeout 30 /NOBREAK >nul&goto pruefe
if %versuche% leq 2 if /i "%wormshotstatus%"=="DEACTIVATED" "SYS\restart.lnk"&timeout 10 /NOBREAK >nul&goto pruefe

REM zuerst nochmal starten, dann mal DO.bat löschen usw. und nochmal starten etc. 
if %versuche% geq 3 if /i "%wormshotstatus%"=="DEACTIVATED" (
if exist "Do.bat" del /F "Do.bat"
if exist "SYS\restart.lnk" "SYS\restart.lnk"
if not exist "SYS\restart.lnk" if exist "SYS\restart.vbs" "SYS\start.vbs"
if not exist "SYS\restart.lnk" if not exist "SYS\restart.vbs" if exist "SYS\search.bat" "SYS\search.bat"
timeout 10 /NOBREAK >nul&goto pruefe
)

goto pruefe

echo ERROR: Drastischer Fehler (Restarter abrupt abgebrochen: %date%, %time%) >> Restart_Log.wsdt


