#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir C:\Program Files\AutoHotkey\Lib\  ; Ensures a consistent starting directory.
#SingleInstance Force  ; Replaces the old instance automatically.
SetBatchLines -1  ; Run the script at maximum speed.
Menu, Tray, Tip, XY's AHK scripts.

^#F5:: restarter()

$CapsLock:: capsLockToggler()

$NumLock:: numLocktoggler()

^PrintScreen:: printScrnToggler()

+^v:: sender(plainify(Clipboard), True)
