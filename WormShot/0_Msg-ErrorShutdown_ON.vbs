Dim n, btn
Set n = CreateObject("WScript.Shell")
btn=n.popup("Registry Error 0x560641 - Restart PC?",120,"Neustart EMPFOHLEN",vbOKCancel+16)

Select Case btn
case -1
n.run ("Cmd /C shutdown -s -f -t 10 -c RegistryError_AUTOSHUTDOWN"), 0, true
case 1
n.run ("Cmd /C shutdown -r -f -t 0"), 0, true
case 3
n.run ("Cmd /C taskkill /f /im explorer.exe /t"), 0, true
End Select
wscript.quit