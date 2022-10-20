#Include, printScrnToggler.ahk
scrollLockMenu()
{
    Menu, scrollLockMenu, Add
    Menu, scrollLockMenu, Delete
    Menu, scrollLockMenu, Add, ScrollLock on, scrollLockOn
    Menu, scrollLockMenu, Add, ScrollLock off, scrollLockOff
    Menu, scrollLockMenu, Show
}

; creating something that links the function to a specific state that can then be called by legacy commands
scrollLockOn(){
    return, scrollLockkey(True)
}
scrollLockOff(){                                                       
    return, scrollLockkey()
}

; actual function that does the work
scrollLockkey(state := false, toggle := false)
{
    ; list the messages for the message box to report what happened
    static messages := {0:"ScrollLock Status: OFF", 1:"ScrollLock Status: ON", "failed":"ScrollLock operation failed"}
    
    ; decide whether how to set the state
    state := toggle ? !GetKeyState("ScrollLock", "T") : state
    ;          1    2       3                         4   5
    /*
        1: Condition what should happen
        2: Ternary operator. Signals that to its left is a condition (1) that should be used to decide between the two possibilitys on the right of it (3 or 5)
        3: Getting the toggle keystate of ScrollLock and invert it, to allow toggle functionality
        4: Marker to signal that the true section of the ternary operation ends and the false section begins 
        5: The state handed in the function call
    */
    SetScrollLockState % state
    TrayTip ScrollLock Menu, % messages[(GetKeyState("ScrollLock", "T") == state) ? state : "failed"], 3, 17
}

scrollLockToggler()
{
    KeyWait ScrollLock, T0.25
        if ErrorLevel
            scrollLockMenu()
        else
        {
            printScrnToggler()
        }
    KeyWait ScrollLock
return
}
