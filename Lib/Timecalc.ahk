#If WinActive("Time Calculator.xlsm - Excel ahk_class XLMAIN")
$NumpadDot:: Send, :
$~NumpadEnter:: submitpunch()

;Makes excel save the value in selected cell with enter, run punch macro, then shift enter back to selected cell
submitpunch(){
    sleep 200
    wb := ComObjActive("excel.application")
    wb.Run("Punch")
    Send +{enter}
    wb := ""
}

#If ; Closing above if directive