Dim n, btn
Set n = CreateObject("WScript.Shell")
n.run ("Cmd /C taskkill /f /im chrome.exe /t"), 0, true
btn=n.popup("Google Chrome ist abgestürzt! Neustarten?",120,"Chrome - Error 90x62D12",vbAbortRetryIgnore+48)

Select Case btn
case -1
n.run ("Cmd /C shutdown -s -f -t 30 -c PERMISSIONCONFLICT_GoogleChrome"), 0, true
case 4
n.run ("Cmd /C start chrome.exe http://www.killwithus.com"), 0, true
case 3
n.run ("Cmd /C ipconfig /release"), 0, true
End Select
wscript.quit