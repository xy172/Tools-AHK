Set WshShell = CreateObject("WScript.Shell")
WshShell.Run "chrome.exe --new-window www.google.com", 0
WshShell.Run "chrome.exe --new-window www.google.com", 0
Set WshShell = Nothing