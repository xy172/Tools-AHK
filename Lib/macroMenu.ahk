#Include, cvaIntake.ahk

macroMenu()
{
    Menu, macroMenu, Add
    Menu, macroMenu, Delete
    Menu, macroMenu, Add, Macros, restarter
    Menu, macroMenu, Add
    Menu, macroMenu, Add, CVA Intake, cvaIntake
    Menu, macroMenu, Add
    Menu, macroMenu, Add, Pin Window, pinWindow
    Menu, macroMenu, Add, Change Opacity, windowOpacity
    Menu, macroMenu, Add, &What Color, color
    Menu, macroMenu, Show
}

pinWindow(){
    WinSet, AlwaysOnTop, , A
}

windowOpacity(){
    WinGet, winid, PID, A
    Gui, Show, , Opacity Editor
}

color(){
    MouseGetPos, MouseX, MouseY
    PixelGetColor, mcolor, %MouseX%, %MouseY%
    Clipboard := mcolor
}
