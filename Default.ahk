#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_MyDocuments%\AutoHotkey\Lib\  ; Ensures a consistent starting directory.
#SingleInstance Force  ; Replaces the old instance automatically.
SetBatchLines -1  ; Run the script at maximum speed.
Menu, Tray, Tip, XY's AHK scripts. ; Changes tray menu tooltip.
DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr") ; Fixes mouse movement on differently scaled windows.

; Sets include's starting directory (Different than SetWorkingDir)
#Include, %A_MyDocuments%\AutoHotkey\Lib\

; Auto Execute stuff, such as global menus and variables
#Include, autoExecute.ahk

;----Client specific hotkeys----
#Include, Trimleading0.ahk
#Include, Timecalc.ahk

;----Global hotkeys----
#Include, global.ahk