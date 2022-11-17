printScrnToggler() ;change to ^PrintScreen when not on cherry keyboard
{
    if WinExist("Snipping Tool")
    {
        WinActivate
        WinWaitActive, Snipping Tool
        Send, ^n
    }
    else
    {
        Run SnippingTool.exe
        WinWaitActive, Snipping Tool
        Send, ^n
    }
    return
}
