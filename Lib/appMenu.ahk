appMenu()
{
    Menu, appMenu, Add
    Menu, appMenu, Delete
        Menu, pasteMenu, Add
        Menu, pasteMenu, Delete
        Menu, pasteMenu, Add, &Default, defaultPaste
        Menu, pasteMenu, Add, &Trim Leading 0, trim0Paste
        Menu, pasteMenu, Add, &Plainify, plainPaste

        appMenu_uncheckAll("pasteMenu")

        Switch appVar[1]
        {
        Case "Trim Leading 0":
            Menu, pasteMenu, Check, &Trim Leading 0
        Case "Plainify":
            Menu, pasteMenu, Check, &Plainify
        Case "Default":
            Menu, pasteMenu, Check, &Default
        }
        
    Menu, appMenu, Add, &Paste Menu, :pasteMenu
    Menu, appMenu, Add, &Numpad Period, :numpadMenu

        Menu, miniMenu, Add, &Macro Menu, macroMenu
        Menu, miniMenu, Add, &CapsLock Menu, CapsLockMenu
        Menu, miniMenu, Add, &Number Lock Menu, NumLockMenu
        Menu, miniMenu, Add, &Scroll Lock Menu, scrollLockMenu

    Menu, appMenu, Add, &Other Menus, :miniMenu
    ;Menu, appMenu, Add, Clipboard report, appMenu_Hex
    Menu, appMenu, Show
}

defaultPaste()
{
    appMenu_uncheckAll("pasteMenu")
    appVar[1] := "Default"
}

trim0Paste()
{
    appMenu_uncheckAll("pasteMenu")
    appVar[1] := "Trim Leading 0"
}

plainPaste()
{
    appMenu_uncheckAll("pasteMenu")
    appVar[1] := "Plainify"
}

appMenu_uncheckAll(menu)
{
    Switch menu
    {
    Case "pasteMenu":
        Menu, pasteMenu, Uncheck, &Default
        Menu, pasteMenu, Uncheck, &Trim Leading 0
        Menu, pasteMenu, Uncheck, &Plainify
    Case "numpadMenu":
        Menu, numpadMenu, Uncheck, &Period
        Menu, numpadMenu, Uncheck, &Colon
    }
}

appMenu_paste()
{
    Switch appVar[1]
    {
    Case "Trim Leading 0":
        plainify_sender(plainify_trimLeading0(plainify(Clipboard)), True)
    Case "Plainify":
        plainify_sender(plainify(plainify_regTrimNonAlphaNumeral(Clipboard)), True)
    Case "Default":
        Send, ^v
    }
}

appMenu_numpadDot()
{
    Switch appVar[2]
    {
    Case "Period":
        Send, {NumpadDot}
    Case "Colon":
        Send, :
    }
}

appMenu_periodNum()
{
    appMenu_uncheckAll("numpadMenu")
    appVar[2] := "Period"
    Menu, numpadMenu, Check, &Period
}

appMenu_colonNum()
{
    appMenu_uncheckAll("numpadMenu")
    appVar[2] := "Colon"
    Menu, numpadMenu, Check, &Colon
}

appMenu_Hex()
{
    plainify_reportUnicode(Clipboard)
}