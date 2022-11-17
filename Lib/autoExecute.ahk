Menu, numpadMenu, Add ; Prevents next lines deleting from erroring upon initial run.
Menu, numpadMenu, Delete ; Clears old menu to prevent duplicate lines
Menu, numpadMenu, Add, Period, appMenu_periodNum
Menu, numpadMenu, Add, Colon, appMenu_colonNum

appMenu_uncheckAll("numpadMenu")

Switch appVar[2]
{
Case "Period":
    Menu, numpadMenu, Check, Period
Case "Colon":
    Menu, numpadMenu, Check, Colon
}

Gui, +ToolWindow
Gui, Add, Button, Default w80, OK
Gui, Add, Slider, Buddy2ButtonOK Range0-255 ToolTip vMySlider gSlide, 50

Slide:
    If MySlider > 254
        WinSet, Transparent, Off, ahk_pid %winid%
    Else
        WinSet, Transparent, %MySlider%, ahk_pid %winid%
Return

ButtonOK: 
    Gui, Submit
Return
