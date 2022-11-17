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
    data := RegExReplace(data, "\W", " ")
    return data
}
plainify_trimLeading0(data)
{
    While RegExMatch(data, "^0(.*)"){
        data := RegExReplace(data, "^0(.*)", "$1")
    }
    return data
}
