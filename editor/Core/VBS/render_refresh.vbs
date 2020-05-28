Dim objShell
Set objShell = CreateObject("WScript.Shell")

Wscript.Sleep 100

objShell.AppActivate("brdf Explorer")
objShell.SendKeys "%"
Wscript.Sleep 50
objShell.SendKeys "{ENTER}"
Wscript.Sleep 50
objShell.SendKeys "{ENTER}"
Wscript.Sleep 50
objShell.SendKeys "{ENTER}"

WScript.Quit 