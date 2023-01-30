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