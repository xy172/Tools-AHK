CapsLockMenu()
{
    Menu, CapsLockMenu, Add ; Prevents next lines deleting from erroring upon initial run.
    Menu, CapsLockMenu, Delete ; Clears old menu to prevent duplicate lines
    Menu, CapsLockMenu, Add, CapsLock ON, CapsLockMenu_CapsLockOn
    Menu, CapsLockMenu, Add, CapsLock off, CapsLockMenu_CapsLockOff
    Menu, CapsLockMenu, Add
    Menu, CapsLockMenu, Add, Paste as Plain Text, CapsLockMenu_PastePlain
    Menu, CapsLockMenu, Add
        Menu, ConvertCaseMenu, Add
        Menu, ConvertCaseMenu, Delete
        Menu, ConvertCaseMenu, Add, Title Case, CapsLockMenu_Title
        Menu, ConvertCaseMenu, Add, Capital Case, CapsLockMenu_Capital
        Menu, ConvertCaseMenu, Add, Sentence case, CapsLockMenu_Sentence
        Menu, ConvertCaseMenu, Add
        Menu, ConvertCaseMenu, Add, UPPERCASE, CapsLockMenu_Upper
        Menu, ConvertCaseMenu, Add, lowercase, CapsLockMenu_Lower
        Menu, ConvertCaseMenu, Add, camelCase, CapsLockMenu_camel
        Menu, ConvertCaseMenu, Add, PascalCase, CapsLockMenu_Pascal
        Menu, ConvertCaseMenu, Add
        Menu, ConvertCaseMenu, Add, Dot.Case, CapsLockMenu_Dot
        Menu, ConvertCaseMenu, Add, Snake_Case, CapsLockMenu_Snake
        Menu, ConvertCaseMenu, Add, Kebab-Case, CapsLockMenu_Kebab
        Menu, ConvertCaseMenu, Add
        Menu, ConvertCaseMenu, Add, iNVERT cASE, CapsLockMenu_Invert
        Menu, ConvertCaseMenu, Add, RaNdoM caSe, CapsLockMenu_Random
        Menu, ConvertCaseMenu, Add, aLtErNaTiNg cAsE, CapsLockMenu_Alternating
    Menu, CapsLockMenu, Add, Convert Case, :ConvertCaseMenu
    Menu, CapsLockMenu, Add
    Menu, CapsLockMenu, Add, Emoji Keyboard, CapsLockMenu_OpenEmojiKeyboard
    Menu, CapsLockMenu, Add
        Menu, InsertLineMenu, Add
        Menu, InsertLineMenu, Delete
        Menu, InsertLineMenu, Add, Light, CapsLockMenu_LightHorizontalBoxDrawing
        Menu, InsertLineMenu, Add, Double, CapsLockMenu_DoubleHorizontalBoxDrawing
    Menu, CapsLockMenu, Add, Insert Line, :InsertLineMenu
    Menu, CapsLockMenu, Show
}

CopyClipboard()
{
    global ClipSaved := ""
    ClipSaved := ClipboardAll  ; save original clipboard contents
    Clipboard := ""  ; start off empty to allow ClipWait to detect when the text has arrived
    Send {Ctrl down}c{Ctrl up}
    Sleep 150
    ClipWait, 1.5, 1
    if ErrorLevel
    {
        TrayTip AutoHotkey, Copy to clipboard failed., 3, 19
        Clipboard := ClipSaved  ; restore the original clipboard contents
        ClipSaved := ""  ; clear the variable
        return
    }
}

CapsLockMenu_PastePlain()
{
    ClipSaved := ClipboardAll  ; save original clipboard contents
    Clipboard := Clipboard  ; remove formatting
    Send ^v  ; send the Ctrl+V command
    Sleep 100  ; give some time to finish paste (before restoring clipboard)
    Clipboard := ClipSaved  ; restore the original clipboard contents
    ClipSaved := ""  ; clear the variable
}

; creating something that links the function to a specific state that can then be called by legacy commands
ToggleCapsLock(){
    return, CapsLockey(, True)
}
CapsLockMenu_CapsLockOn(){
    return, CapsLockey(True)
}
CapsLockMenu_CapsLockOff(){
    return, CapsLockey()
}

; actual function that does the work
CapsLockey(state := false, toggle := false)
{
    ; list the messages for the message box to report what happened
    static messages := {0:"CapsLock Status: OFF", 1:"CapsLock Status: ON", "failed":"CapsLock operation failed"}
    
    ; decide whether how to set the state
    state := toggle ? !GetKeyState("CapsLock", "T") : state
    ;          1    2       3                       4   5
    /*
        1: Condition what should happen
        2: Ternary operator. Signals that to its left is a condition (1) that should be used to decide between the two possibilitys on the right of it (3 or 5)
        3: Getting the toggle keystate of CapsLock and invert it, to allow toggle functionality
        4: Marker to signal that the true section of the ternary operation ends and the false section begins 
        5: The state handed in the function call
    */
    SetCapsLockState % state
    TrayTip CapsLock Menu, % messages[(GetKeyState("CapsLock", "T") == state) ? state : "failed"], 3, 17
}

CopyClipboardCLM()
{
    global ClipSaved
    WinGet, id, ID, A
    WinGetClass, class, ahk_id %id%
    if (class ~= "(Cabinet|Explore)WClass|Progman")
        Send {F2}
    Sleep 100
    CopyClipboard()
    if (ClipSaved != "")
        Clipboard := Clipboard
    else
        Exit
}

PasteClipboardCLM()
{
    global ClipSaved
    WinGet, id, ID, A
    WinGetClass, class, ahk_id %id%
    if (class ~= "(Cabinet|Explore)WClass|Progman")
        Send {F2}
    Send ^v
    Sleep 100
    Clipboard := ClipSaved
    ClipSaved := ""
}

CapsLockMenu_Title()
{
    ExcludeList := ["a", "about", "above", "after", "an", "and", "as", "at", "before", "but", "by", "for", "from", "nor", "of", "or", "so", "the", "to", "via", "with", "within", "without", "yet"]
    ExactExcludeList := ["AutoHotkey", "iPad", "iPhone", "iPod", "OneNote", "USA"]
    CopyClipboardCLM()
    TitleCase := Format("{:T}", Clipboard)
    for _, v in ExcludeList
        TitleCase := RegexReplace(TitleCase, "i)(?<!\. |\? |\! |^)(" v ")(?!\.|\?|\!|$)\b", "$L1")
    for _, v in ExactExcludeList
        TitleCase := RegExReplace(TitleCase, "i)\b" v "\b", v)
    TitleCase := RegexReplace(TitleCase, "im)\b(\d+)(st|nd|rd|th)\b", "$1$L{2}")
    Clipboard := TitleCase
    PasteClipboardCLM()
}

CapsLockMenu_Capital()
{
    ExactExcludeList := ["AutoHotkey", "iPad", "iPhone", "iPod", "OneNote", "USA"]
    CopyClipboardCLM()
    CapitalCase := Format("{:T}", Clipboard)
    for _, v in ExactExcludeList
        CapitalCase := RegExReplace(CapitalCase, "i)\b" v "\b", v)
    Clipboard := CapitalCase
    PasteClipboardCLM()
}

CapsLockMenu_Sentence()
{
    ExactExcludeList := ["AutoHotkey", "iPad", "iPhone", "iPod", "OneNote", "USA"]
    CopyClipboardCLM()
    StringLower, Clipboard, Clipboard
    Clipboard := RegExReplace(Clipboard, "(((^|([.!?]\s+))[a-z])| i | i')", "$u1")
    for _, v in ExactExcludeList
        Clipboard := RegExReplace(Clipboard, "i)\b" v "\b", v)
    PasteClipboardCLM()
}

CapsLockMenu_Upper()
{
    CopyClipboardCLM()
    StringUpper, Clipboard, Clipboard
    PasteClipboardCLM()
}

CapsLockMenu_Lower()
{
    CopyClipboardCLM()
    StringLower, Clipboard, Clipboard
    PasteClipboardCLM()
}

CapsLockMenu_camel()
{
    CopyClipboardCLM()
    StringUpper, Clipboard, Clipboard, T
    FirstChar := SubStr(Clipboard, 1, 1)
    StringLower, FirstChar, FirstChar
    camelCase := SubStr(Clipboard, 2)
    camelCase := StrReplace(camelCase, A_Space)
    Clipboard := FirstChar camelCase
    PasteClipboardCLM()
}

CapsLockMenu_Pascal()
{
    CopyClipboardCLM()
    StringUpper, Clipboard, Clipboard, T
    Clipboard := StrReplace(Clipboard, A_Space)
    PasteClipboardCLM()
}

CapsLockMenu_Dot()
{
    CopyClipboardCLM()
    if RegExMatch(Clipboard, "\-|\_|\.") != "0"
    {
        Clipboard := RegExReplace(Clipboard, "\-|\_|\.", " ")
        PasteClipboardCLM()
    }
    else
    {
        Clipboard := StrReplace(Clipboard, A_Space, ".")
        PasteClipboardCLM()
    }
}

CapsLockMenu_Snake()
{
    CopyClipboardCLM()
    if RegExMatch(Clipboard, "\-|\_|\.") != "0"
    {
        Clipboard := RegExReplace(Clipboard, "\-|\_|\.", " ")
        PasteClipboardCLM()
    }
    else
    {
        Clipboard := StrReplace(Clipboard, A_Space, "_")
        PasteClipboardCLM()
    }
}

CapsLockMenu_Kebab()
{
    CopyClipboardCLM()
    if RegExMatch(Clipboard, "\-|\_|\.") != "0"
    {
        Clipboard := RegExReplace(Clipboard, "\-|\_|\.", " ")
        PasteClipboardCLM()
    }
    else
    {
        Clipboard := StrReplace(Clipboard, A_Space, "-")
        PasteClipboardCLM()
    } 
}

CapsLockMenu_Invert()
{
    CopyClipboardCLM()
    Inv_Char_Out := ""
    Loop % StrLen(Clipboard)
    {
        Inv_Char := SubStr(Clipboard, A_Index, 1)
        if Inv_Char is Upper
            Inv_Char_Out := Inv_Char_Out Chr(Asc(Inv_Char) + 32)
        else if Inv_Char is Lower
            Inv_Char_Out := Inv_Char_Out Chr(Asc(Inv_Char) - 32)
        else
            Inv_Char_Out := Inv_Char_Out Inv_Char
    }
    Clipboard := Inv_Char_Out
    PasteClipboardCLM()
}

CapsLockMenu_Random()
{
    CopyClipboardCLM()
    RandomCase := ""
    for _, v in StrSplit(Clipboard)
    {
        Random, r, 0, 1
        RandomCase .= Format("{:" (r?"L":"U") "}", v)
    }
    Clipboard := RandomCase
    PasteClipboardCLM()
}

CapsLockMenu_Alternating()
{
    CopyClipboardCLM()
    Inv_Char_Out := ""
    StringLower, Clipboard, Clipboard
    Loop, Parse, Clipboard
    {
        if (Mod(A_Index, 2) = 0)
            Inv_Char_Out .= Format("{1:U}", A_LoopField)
        else
            Inv_Char_Out .= Format("{1:L}", A_LoopField)
    }
    Clipboard := Inv_Char_Out
    PasteClipboardCLM()
}

CapsLockMenu_OpenEmojiKeyboard()
{
    Send {LWin down}.
    Send {LWin up}
}

CapsLockMenu_LightHorizontalBoxDrawing()
{
    InputBox, UserInput, Input, , , 150, 105
    Loop %UserInput%
        Send {U+2500}
}

CapsLockMenu_DoubleHorizontalBoxDrawing()
{
    InputBox, UserInput, Input, , , 150, 105
    Loop %UserInput%
        Send {U+2550}
}

capsLockToggler()
{
    KeyWait CapsLock, T0.25
        if ErrorLevel
            CapsLockMenu()
        else
        {
            KeyWait CapsLock, D T0.25
            if ErrorLevel
                Send ^v
            else
                CopyClipboard()
        }
    KeyWait CapsLock
return
}
