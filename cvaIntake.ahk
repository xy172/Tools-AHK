#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_MyDocuments%\AutoHotkey\Lib\  ; Ensures a consistent starting directory.
SetBatchLines -1  ; Run the script at maximum speed.
Menu, Tray, Tip, CVA Intake Script. ; Changes tray menu tooltip.

#Include, %A_MyDocuments%\AutoHotkey\Lib\plainify.ahk

outlook := ComObjActive("Outlook.Application").GetNameSpace("MAPI")
Intakemail := outlook.GetDefaultFolder[6].Folders("Intakes")
completedFolder := Intakemail.Folders("Completed")
cvaSheet := ComObjActive("excel.application").Sheets("Master")
movedItems := 0
Loop, % Intakemail.Items.Count()
{
    newRow:= cvaSheet.Cells(cvaSheet.Rows.Count, "F").End(-4162).Row + 1
    item:= Intakemail.Items(A_Index - movedItems)
    subject:= item.Subject
    if Instr(item.Subject,"Delivery Form - ")
    {
        body:= item.body
        While RegExMatch(body, "\s{2,}"){
            body:= RegExReplace(body, "\s{2,}", " ")
        }
        customer := plainify(plainify_regTrimNonAlphaNumeral(RegExReplace(body, "Customer: (.*) Sales Rep: .*", "$1")))
        serialNumber := plainify(plainify_regTrimNonAlphaNumeral(RegExReplace(body, ".*Serial Number: (.*) Model:.*", "$1")))
        cvaType := plainify(plainify_regTrimNonAlphaNumeral(RegExReplace(body, ".*CVA Type: (.*) Warranty Details: .*", "$1")))
        cvaSheet.Cells(newRow, "F").value := serialNumber
        cvaSheet.Cells(newRow, "G").value := customer
        cvaSheet.Cells(newRow, "C").value := A_MM "/" A_DD "/" A_YYYY
        SetTimer, ChangeButtonNames, 50
        MsgBox, 4, CVA Column, %cvaType%
        IfMsgBox, Yes
            cvaSheet.Cells(newRow, "K").value := cvaType
        else
            cvaSheet.Cells(newRow, "L").value := cvaType
        If item.Unread = -1
            item.Unread := 0
        item.Move(completedFolder)
        movedItems += 1
    }
}
outlook := ""
Intakemail := ""
completedFolder := ""
cvaSheet := ""

ChangeButtonNames: 
IfWinNotExist, CVA Column
	return  ; Keep waiting.
SetTimer, ChangeButtonNames, Off 
WinActivate 
ControlSetText, Button1, &Filter Kit 
ControlSetText, Button2, &Custom 
return