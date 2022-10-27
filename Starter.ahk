#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_MyDocuments%\AutoHotkey\Lib\  ; Ensures a consistent starting directory.
#SingleInstance Force  ; Replaces the old instance automatically.
SetBatchLines -1  ; Run the script at maximum speed.
Menu, Tray, Tip, XY's AHK scripts.

global pasteType := "Default"

^#F5:: restarter()

$CapsLock:: capsLockToggler()
$NumLock:: numLocktoggler()
$ScrollLock:: scrollLockToggler()
$SC121:: calcuToggler() ;Calculator key
AppsKey:: PasteMenu()

$SC16D:: macroMenu()

$XButton1:: ^c
$XButton2:: PasteMenu_paste()

$Media_Play_Pause:: Volume_Mute
$Media_Prev:: Volume_Down
$Media_Next:: Volume_Up

$Volume_Mute:: Media_Play_Pause
$Volume_Down:: Media_Prev
$Volume_Up:: Media_Next
