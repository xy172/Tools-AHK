SetTitleMatchMode, 2
GroupAdd, trimLeading0Windows, BLAAAA
GroupAdd, trimLeading0Windows, BLAAAA

global appVar := ["Default","Period"] ; Global Variable for keeping track of current menu selections.
global winid := "" ;Global Variable for setting window transparency
global Width := 100
global Height := 100

Menu, numpadMenu, Add ; Prevents next lines deleting from erroring upon initial run.
Menu, numpadMenu, Delete ; Clears old menu to prevent duplicate lines
Menu, numpadMenu, Add, &Period, appMenu_periodNum
Menu, numpadMenu, Add, &Colon, appMenu_colonNum

appMenu_uncheckAll("numpadMenu")

Switch appVar[2]
{
Case "Period":
    Menu, numpadMenu, Check, &Period
Case "Colon":
    Menu, numpadMenu, Check, &Colon
}

Gui, Opacity:+ToolWindow
Gui, Opacity:Add, Button, Default w80 gOpButtonOK, OK
Gui, Opacity:Add, Slider, Buddy2ButtonOK Range0-255 ToolTip vOpSlider gOpSlide, 50

Gui, Crop:+ToolWindow
Gui, Crop:Add, Text, xm ym Section, x:
Gui, Crop:Add, Slider, Range0-1920 ToolTip vXEdit1 gCropEdit, 0
Gui, Crop:Add, Text, X+10, -
Gui, Crop:Add, Slider, Range0-1920 ToolTip vXEdit2 gCropEdit X+10, 1080
Gui, Crop:Add, Text, xs Section, y:
Gui, Crop:Add, Slider, Range0-1080 ToolTip vYEdit1 gCropEdit, 0
Gui, Crop:Add, Text, X+10, -
Gui, Crop:Add, Slider, Range0-1080 ToolTip vYEdit2 gCropEdit X+10, 1920
Gui, Crop:Add, Button, Default w60 gCpButtonRestore xs+10, Restore
Gui, Crop:Add, Button, Default w60 gCpButtonOK X+10, OK

OpSlide:
    If OpSlider > 254
        WinSet, Transparent, Off, ahk_pid %winid%
    Else
        WinSet, Transparent, %OpSlider%, ahk_pid %winid%
Return

OpButtonOK: 
    Gui, Opacity:Submit
Return

CpButtonOK: 
    Gui, Crop:Submit
    WinSet, Region, % XEdit1 "-" YEdit1 " " XEdit2 "-" YEdit1 " " XEdit2 "-" YEdit2 " " XEdit1 "-" YEdit2 " " XEdit1 "-" YEdit1, ahk_pid %winid%
Return

CpButtonRestore:
    WinSet, Region, , ahk_pid %winid%
    Gui, Crop:Hide
Return

CropGuiClose:
    WinSet, Region, , ahk_pid %winid%
    Gui, Crop:Hide
Return

CropEdit:
    WinSet, Region, % XEdit1 "-" YEdit1 " " XEdit2 "-" YEdit1 " " XEdit2 "-" YEdit2 " " XEdit1 "-" YEdit2 " " XEdit1 "-" YEdit1, ahk_pid %winid%
Return
