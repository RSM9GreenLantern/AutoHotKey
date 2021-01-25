#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

StartBackgroundAppScripts(scriptPath)
{
    Loop, Files, %A_ScriptDir%\script\%scriptPath%\background\*.ahk, R
    {
        Run, %A_LoopFileFullPath%
    }
}

StartActiveAppScripts(scriptPath)
{
    Loop, Files, %A_ScriptDir%\script\%scriptPath%\active\*.ahk, R
    {
        Run, %A_LoopFileFullPath%
    }
}

TerminateActiveAppScripts(scriptPath)
{
    Loop, Files, %A_ScriptDir%\script\%scriptPath%\active\*.ahk, R
    {
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
    }
}

TerminateAppScripts(scriptPath)
{
    Loop, Files, %A_ScriptDir%\script\%scriptPath%\active\*.ahk, R
    {
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
    }

    Loop, Files, %A_ScriptDir%\script\%scriptPath%\background\*.ahk, R
    {
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
    }
}

TerminateAllAppScripts()
{
    Loop, Files, %A_ScriptDir%\script\*.ahk, R
    {
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
    }
}