calcuToggler()
{
    if WinExist("Calculator ahk_class CalcFrame") or WinExist("Calculator ahk_class ApplicationFrameWindow")
        if WinActive()
            WinMinimize
        else
            WinActivate
    else
        Run calc.exe
    return
}