plainify(data)
{
    StringReplace, clipboardt, data, `r`n, %A_Space%, All
    clipboardt := RegExReplace(clipboardt, "\s{2,}", " ")
    StringLeft, 1st, clipboardt, 1
    IfInString, 1st, %A_Space%
    StringTrimLeft, clipboardt, clipboardt, 1
    StringRIght, last, clipboardt, 1
    IfInString, last, %A_Space%
    StringTrimRight, clipboardt, clipboardt, 1
    clipboardt := plainify_regTrim(clipboardt)
    return clipboardt
}
plainify_sender(data, asraw:= False)
{
    if asraw 
    {
        Send {Raw}%data%
    }
    else
    {
        Send %data%
    }
}
plainify_regTrim(data)
{
    While RegExMatch(data, "^\s(.*)"){
        data := RegExReplace(data, "^\s(.*)", "$1")
    }
    While RegExMatch(data, "(.*)\s$"){
        data := RegExReplace(data, "(.*)\s$", "$1")
    }
    return data
}
plainify_regTrimNonAlphaNumeral(data)
{
    data := RegExReplace(data, "[^\w|\p{P}]", " ")
    ;data := RegExReplace(data1, "\u8201|\u2009", " ")
    return data
}
plainify_trimLeading0(data)
{
    While RegExMatch(data, "^0(.*)"){
        data := RegExReplace(data, "^0(.*)", "$1")
    }
    return data
}

plainify_reportUnicode(data)
{
    test := StrSplit(data)
    For _, x in test
    {
        SetFormat, IntegerFast, H
        Transform, test1, Asc, %x%
        SetFormat, Integer, D
        Transform, test2, Asc, %x%
        Transform, test3, Chr, %test1%
        Transform, test4, HTML, %test% , 2   

        MsgBox, 0x40000,, % "Char to convert"  A_Tab  x
            . "`nHex " A_Tab A_Tab test1 "`nAsc " A_Tab A_Tab  test2
            .  "`nChr " A_Tab A_Tab test3 "`nHTML " A_Tab A_Tab test4
            . "`nDirect convert " A_Tab Asc(x)
    }
}