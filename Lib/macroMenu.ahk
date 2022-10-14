macroMenu()
{
    Menu, macroMenu, Add
    Menu, macroMenu, Delete
    Menu, macroMenu, Add, Macros, restarter
    Menu, macroMenu, Add
    Menu, macroMenu, Add, CVA Intake, cvaintake 
    Menu, macroMenu, Show
}
cvaintake()
{
    Intakemail := ComObjActive("Outlook.Application").GetNameSpace("MAPI").GetDefaultFolder[6].Folders("Intakes")

    Loop % Intakemail.Items.Count
    {
        if Instr(mail.Items[A_Index].Subject,"Delivery Form")
        {
            body:= Intakemail.Items(A_Index).body
            MsgBox % body
        }
    }
}
