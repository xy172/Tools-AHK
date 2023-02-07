#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_MyDocuments%\Fast Start  ; Ensures a consistent starting directory.

FormatTime, today,, WDay
if today = 2
{
    Loop, Files, Open Weekly\*.lnk
    {
        Run, %A_LoopFileLongPath%
    }

}

Loop, Files, Open Daily\*.lnk
{
    Run, %A_LoopFileLongPath%
}