pasteMenu()
{
    Menu, pasteMenu, Add
    Menu, pasteMenu, Delete
    Menu, pasteMenu, Add, Paste Menu, restarter
    Menu, pasteMenu, Add, Default, defaultPaste
    Menu, pasteMenu, Add, Trim Leading 0, trim0Paste
    Menu, pasteMenu, Add, Plainify, plainPaste
    Menu, pasteMenu, Uncheck, Default
    Menu, pasteMenu, Uncheck, Trim Leading 0
    Menu, pasteMenu, Uncheck, Plainify
    Switch pasteType
    {
    Case "Trim Leading 0":
        Menu, pasteMenu, Check, Trim Leading 0
    Case "Plainify":
        Menu, pasteMenu, Check, Plainify
    Case "Default":
        Menu, pasteMenu, Check, Default
    }
    Menu, pasteMenu, Show
}

defaultPaste()
{
    uncheckAll()
    pasteType := "Default"
    Menu, pasteMenu, Check, Default
}

trim0Paste()
{
    uncheckAll()
    pasteType := "Trim Leading 0"
    Menu, pasteMenu, Default, Trim Leading 0
}

plainPaste()
{
    uncheckAll()
    pasteType := "Plainify"
    Menu, pasteMenu, Default, Plainify
}

uncheckAll()
{
    Menu, pasteMenu, Uncheck, Default
    Menu, pasteMenu, Uncheck, Trim Leading 0
    Menu, pasteMenu, Uncheck, Plainify
}

pasteMenu_paste()
{
    Switch pasteType
    {
    Case "Trim Leading 0":
        plainify_sender(plainify_trimLeading0(plainify(Clipboard)), True)
    Case "Plainify":
        plainify_sender(plainify(Clipboard), True)
    Case "Default":
        Send, ^v
    }
}
