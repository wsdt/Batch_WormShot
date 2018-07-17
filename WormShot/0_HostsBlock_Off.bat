REM Sicherung von Collected Data (Vorgespeichert) mit vorhandener Hosts-Datei (wurde abgeändert) ersetzen. 
REM Mit cacls Berechtigungen nachher rueckgangig machen. 

REM Dieses Cacls gibt die Berechtigung fuer Hosts, damit nicht zwingend vorher Hostsblock_On ausgefuehrt werden muss
cacls "C:\Windows\System32\drivers\etc\hosts" /T /E /G %username%:F
xcopy /Y /R /H /Q "SYS\CollectedData\BackUp\hosts" "C:\Windows\System32\drivers\etc\" || echo HostsBlock_OFF-ERROR: BackUp Hosts nicht gefunden >> "Error.txt"
cacls "C:\Windows\System32\drivers\etc\hosts" /T /E /P %username%:R
