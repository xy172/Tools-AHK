restarter()
{
    TrayTip AHK, Reloading., 3, 17
    Sleep 200 ; Allow time for traytip to display.
    Reload
    Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
    MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
    IfMsgBox, Yes, Edit
    return
}