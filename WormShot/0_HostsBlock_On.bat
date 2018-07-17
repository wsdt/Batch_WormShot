@echo off
REM Datei NIE selbst oeffnen.

if not exist "AdditionalData\HostsBlock_ON_DefineHP.bat" echo ERROR ####: HostsBlock_ON_DefineHP.bat existiert nicht. >> "Error.txt"&goto end

REM Mit cacls Berechtigungen setzen, Im Kontrollpanel sollten blockhpX alle mit RESET deklariert werden. 
REM Bevor erneut ausgefuehrt, sollte HostsBlock_OFF ausgefuehrt werden. 

cacls "C:\Windows\System32\drivers\etc\hosts" /T /E /G %username%:F 

call "AdditionalData\HostsBlock_ON_DefineHP.bat"

if /i "%blockhp1%"=="RESET" goto end
echo 127.0.0.1       localhost >> "C:\Windows\System32\drivers\etc\hosts"
echo 127.0.0.1       www.%blockhp1% >> "C:\Windows\System32\drivers\etc\hosts"
echo 127.0.0.1       %blockhp1% >> "C:\Windows\System32\drivers\etc\hosts"
if /i "%blockhp2%"=="RESET" goto end
echo 127.0.0.1       www.%blockhp2% >> "C:\Windows\System32\drivers\etc\hosts"
echo 127.0.0.1       %blockhp2% >> "C:\Windows\System32\drivers\etc\hosts"
if /i "%blockhp3%"=="RESET" goto end
echo 127.0.0.1       www.%blockhp3% >> "C:\Windows\System32\drivers\etc\hosts"
echo 127.0.0.1       %blockhp3% >> "C:\Windows\System32\drivers\etc\hosts"
if /i "%blockhp4%"=="RESET" goto end
echo 127.0.0.1       www.%blockhp4% >> "C:\Windows\System32\drivers\etc\hosts"
echo 127.0.0.1       %blockhp4% >> "C:\Windows\System32\drivers\etc\hosts"
if /i "%blockhp5%"=="RESET" goto end
echo 127.0.0.1       www.%blockhp5% >> "C:\Windows\System32\drivers\etc\hosts"
echo 127.0.0.1       %blockhp5% >> "C:\Windows\System32\drivers\etc\hosts"
:end