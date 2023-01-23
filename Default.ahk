#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_MyDocuments%\AutoHotkey\Lib\  ; Ensures a consistent starting directory.
#SingleInstance Force  ; Replaces the old instance automatically.
SetBatchLines -1  ; Run the script at maximum speed.
Menu, Tray, Tip, XY's AHK scripts. ; Changes tray menu tooltip.
DllCall("SetThreadDpiAwarenessContext", "ptr", -4, "ptr") ;Fixes mouse movement on differently scaled windows.

global appVar := ["Default","Period"] ; Global Variable for keeping track of current menu selections.
global winid := "" ;Global Variable for setting window transparency

;Looping through all library files to catch any not loaded automatically, including my autoexecute and app specific hotkeys.
Loop Files, %A_MyDocuments%\AutoHotkey\Lib\*.ahk
{
    #Include, %A_LoopFileFullPath%
    #If ;Clears out any previously stated if directives for app specific hotkeys
}

;Start of global hotkeys
#If ;Clears out any previously stated if directives for app specific hotkeys
$^#F5:: restarter()

$CapsLock:: capsLockToggler()
$NumLock:: numLocktoggler()
$ScrollLock:: scrollLockToggler()
$SC121:: calcuToggler() ;Calculator key
$AppsKey:: appMenu()

$SC16D:: macroMenu() ;Media Player key (bound to cherry key on work KB)

$XButton1:: ^c
$XButton2:: appMenu_paste()

$NumpadDot:: appMenu_numpadDot()

$Media_Play_Pause:: Volume_Mute
$Media_Prev:: Volume_Down
$Media_Next:: Volume_Up

$Volume_Mute:: Media_Play_Pause
$Volume_Down:: Media_Prev
$Volume_Up:: Media_Next

$#Home:: DllCall("SetCursorPos", "int", 600, "int", 450)
$#End:: DllCall("SetCursorPos", "int", -2924, "int", -1596)