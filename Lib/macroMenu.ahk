macroMenu()
{
    Menu, macroMenu, Add
    Menu, macroMenu, Delete
    Menu, macroMenu, Add, Macros, restarter
    Menu, macroMenu, Add
    Menu, macroMenu, Add, &CVA Intake, cvaIntake
    Menu, macroMenu, Add
    Menu, macroMenu, Add, &Pin/Unpin Window, pinWindow
    Menu, macroMenu, Add, Change &Opacity, windowOpacity
    Menu, macroMenu, Add, &What Color, color
    Menu, macroMenu, Add, &Ruler, ruler
    Menu, macroMenu, Show
}

pinWindow()
{
    WinSet, AlwaysOnTop, , A
}

windowOpacity()
{
    WinGet, winid, PID, A
    Gui, Show, , Opacity Editor
}

color()
{
    MouseGetPos, MouseX, MouseY
    PixelGetColor, mcolor, %MouseX%, %MouseY%
    Clipboard := mcolor
}

ruler()
{
    KeyWait, LButton, D, T60
    MouseGetPos, pos1x, pos1y
    TrayTip Ruler, Position 1 Recorded,1
    sleep 500
    KeyWait, LButton, T60
    MouseGetPos, pos2x, pos2y
    xresult := pos2x-pos1x
    yresult := pos2y-pos1y
    MsgBox,, Ruler, X = %xresult%`nY = %yresult%
}