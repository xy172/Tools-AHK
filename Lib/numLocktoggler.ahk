NumLockMenu()
{
Menu, NumLockMenu, Add, NumLock on, NumLockOn
Menu, NumLockMenu, Add, NumLock off, NumLockOff
Menu, NumLockMenu, Show
}

; creating something that links the function to a specific state that can then be called by legacy commands
NumLockOn(){
    return, NumLockey(True)
}
NumLockOff(){                                                       
    return, NumLockey()
}

; actual function that does the work
NumLockey(state := false, toggle := false)
{
    ; list the messages for the message box to report what happened
    static messages := {0:"NumLock Status: OFF", 1:"NumLock Status: ON", "failed":"NumLock operation failed"}
    
    ; decide whether how to set the state
    state := toggle ? !GetKeyState("NumLock", "T") : state
    ;          1    2       3                       4   5
    /*
        1: Condition what should happen
        2: Ternary operator. Signals that to its left is a condition (1) that should be used to decide between the two possibilitys on the right of it (3 or 5)
        3: Getting the toggle keystate of NumLock and invert it, to allow toggle functionality
        4: Marker to signal that the true section of the ternary operation ends and the false section begins 
        5: The state handed in the function call
    */
    SetNumLockState % state
    TrayTip NumLock Menu, % messages[(GetKeyState("NumLock", "T") == state) ? state : "failed"], 3, 17
}

numLocktoggler()
{
    KeyWait NumLock, T0.25
        if ErrorLevel
            NumLockMenu()
        else
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
    KeyWait NumLock
return
}