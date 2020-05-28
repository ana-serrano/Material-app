Dim objShell
Set objShell = CreateObject("WScript.Shell")
objShell.Run "brdf.exe"

Wscript.Sleep 3000

objShell.SendKeys "%"
Wscript.Sleep 50
objShell.SendKeys "{ENTER}"
Wscript.Sleep 50
objShell.SendKeys "{ENTER}"
Wscript.Sleep 50
objShell.SendKeys "render.binary"
Wscript.Sleep 50
objShell.SendKeys "{ENTER}"

WScript.Quit 