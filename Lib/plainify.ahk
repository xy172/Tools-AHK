plainify(data)
{
    StringReplace, clipboardt, data, `r`n, %A_Space%, All
    clipboardt := RegExReplace(clipboardt, "` {2,}", "` ")
    StringLeft, 1st, clipboardt, 1
    IfInString, 1st, %A_Space%
    StringTrimLeft, clipboardt, clipboardt, 1
    StringRIght, last, clipboardt, 1
    IfInString, last, %A_Space%
    StringTrimRight, clipboardt, clipboardt, 1
    return clipboardt
}
/*
$>!v::
Send {Raw}%clipboardt%
clipboardt = 
return
*/
