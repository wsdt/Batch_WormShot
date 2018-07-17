set ws = CreateObject("Wscript.shell")
ws.run("sndvol.exe")
wscript.sleep 100
Dim i
ws.sendkeys("{PGDN}")
For i = 1 to 5 Step 1
ws.sendkeys("{PGUP}")
'PGUP
next
ws.sendkeys("%{F4}")