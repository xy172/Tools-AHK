appMenu()
{
    Menu, appMenu, Add
    Menu, appMenu, Delete

    Menu, pasteMenu, Add
    Menu, pasteMenu, Delete
    Menu, pasteMenu, Add, Default, defaultPaste
    Menu, pasteMenu, Add, Trim Leading 0, trim0Paste
    Menu, pasteMenu, Add, Plainify, plainPaste
    uncheckAll("pasteMenu")
    Switch appType[1]
    {
    Case "Trim Leading 0":
        Menu, pasteMenu, Check, Trim Leading 0
    Case "Plainify":
        Menu, pasteMenu, Check, Plainify
    Case "Default":
        Menu, pasteMenu, Check, Default
    }

    Menu, numpadMenu, Add
    Menu, numpadMenu, Delete
    Menu, numpadMenu, Add, Period, periodNum
    Menu, numpadMenu, Add, Colon, colonNum
    uncheckAll("numpadMenu")
    Switch appType[2]
    {
    Case "Period":
        Menu, numpadMenu, Check, Period
    Case "Colon":
        Menu, numpadMenu, Check, Colon
    }

    Menu, appMenu, Add, Paste Menu, :pasteMenu
    Menu, appMenu, Add, Numpad Period, :numpadMenu
    Menu, appMenu, Show
}

defaultPaste()
{
    uncheckAll("pasteMenu")
    appType[1] := "Default"
}

trim0Paste()
{
    uncheckAll("pasteMenu")
    appType[1] := "Trim Leading 0"
}

plainPaste()
{
    uncheckAll("pasteMenu")
    appType[1] := "Plainify"
}

periodNum()
{
    uncheckAll("numpadMenu")
    appType[2] := "Period"
}

colonNum()
{
    uncheckAll("numpadMenu")
    appType[2] := "Colon"
}

uncheckAll(menu)
{
    Switch menu
    {
    Case "pasteMenu":
        Menu, pasteMenu, Uncheck, Default
        Menu, pasteMenu, Uncheck, Trim Leading 0
        Menu, pasteMenu, Uncheck, Plainify
    Case "numpadMenu":
        Menu, numpadMenu, Uncheck, Period
        Menu, numpadMenu, Uncheck, Colon
    }
}

appMenu_paste()
{
    Switch appType[1]
    {
    Case "Trim Leading 0":
        plainify_sender(plainify_trimLeading0(plainify(Clipboard)), True)
    Case "Plainify":
        plainify_sender(plainify(Clipboard), True)
    Case "Default":
        Send, ^v
    }
}

appMenu_numpadDot()
{
    Switch appType[2]
    {
    Case "Period":
        Send, NumpadDot
    Case "Colon":
        Send, :
    }
}
