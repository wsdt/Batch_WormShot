@echo off
title REMOTE SetUp - WormShot
echo.
echo ********** REMOTE SETUP - WormShot **********
echo.
echo Fuer einen Installations-Vorgang ueber das Netzwerk, 
echo muss die Netzwerkerkennung und eine fuer uns ausreichende
echo Berechtigung der Freigabe vorliegen. 
echo.
echo Ist dem nicht so, muss leider LOKAL installiert werden. 
echo.
echo EMPFOHLEN: Nach Moeglichkeit immer 'LOKAL' installieren.
echo.
echo TIPP: Wurde das REMOTE-SetUp ausgefuehrt, kann beim naechsten
echo Start der Rest ueber den Befehl 'ReInstall' aktiviert werden. 
echo.
set /p targetpc=Target PC: [--- 
set /P targetuser=Target User: [--- 
if not exist "\\%targetpc%\users\%targetuser%\" echo PERMISSION CONFLICT: Pfad existiert nicht oder Sie haben keine Berechtigung.&timeout 12 >nul&exit
echo.
echo Press 'ENTER' to start the SetUp..
pause >nul
cd /d "%~dp0"
cd..
echo AutoStart-Entrag wird hinzugefuegt (WAIT)

REM Autostart
xcopy "start.lnk" "\\%targetpc%\users\%targetuser%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\" || echo ERROR ###: AutoStart-Eintrag nicht gespeichert&&timeout 8 >nul&exit
echo AutoStart-Eintrag erstellt. (DONE)

REM Setze WScript als Standard-Output, damit kein Konsolenfenster erscheint
REM cscript //h:wscript //s
REM Da WScript anscheinend Standard und ueber Netzwerk dieser Befehl nicht moeglich lassen wir ihn weg. 

REM WormShot installieren
md "\\%targetpc%\users\%targetuser%\WormShot"
attrib +H "\\%targetpc%\users\%targetuser%\WormShot"
cd..&cd..
xcopy "Wormshot\*.*" "\\%targetpc%\users\%targetuser%\WormShot\" /Y /K /H /Q /E /I 
echo.
echo Remote-Installation abgeschlossen.
pause >nul
exit