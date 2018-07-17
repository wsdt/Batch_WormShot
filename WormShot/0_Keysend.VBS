'Eine Textdatei öffnen wo nacheinander in mehreren Schritten ein Text erscheint, als ob der PC
'tippen würde bzw. ein Hacker schreibt. 

' Open notepad 
Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "notepad", 9

' Give Notepad time to load
WScript.Sleep 500 

WshShell.SendKeys "H"
WScript.Sleep 500 
WshShell.SendKeys "a"
WScript.Sleep 700 
WshShell.SendKeys "l"
WScript.Sleep 200 
WshShell.SendKeys "l"
WScript.Sleep 500 
WshShell.SendKeys "o"
WScript.Sleep 600 

WshShell.SendKeys " "
WScript.Sleep 600 
Set wshShell = WScript.CreateObject( "WScript.Shell" )
strUserName = wshShell.ExpandEnvironmentStrings( "%USERNAME%" )
WshShell.SendKeys "{~}"
WScript.Sleep 400 
WshShell.SendKeys strUserName
WScript.Sleep 400 
WshShell.SendKeys "{~}"
WScript.Sleep 600 
WshShell.SendKeys "{ENTER}"
WScript.Sleep 400 
WshShell.SendKeys "i" 
WScript.Sleep 500 
WshShell.SendKeys "{ENTER}" 
WScript.Sleep 500 
