#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode RegEx
#Include, ..\AppScriptContextManager\obj2Str.ahk

main()

main()
{
    InitializeDictionary()
    WindowLoop()
}

InitializeDictionary()
{
    global
    appScriptDictionary:={}
    previousExistingApps:={}
    previousActiveApps:={}

    local win_def:={}
    local CommentSymIndex:=0

    Loop, read, ..\AppScriptContextManager\config.txt
    {
        CommentSymIndex:=InStr(A_LoopReadLine,"#")
        if (CommentSymIndex!=1)
        {
            Loop, parse, A_LoopReadLine, `,
            {
                Switch A_Index
                {
                Case 1:
                    win_def["appId"]:=A_LoopField
                    Continue
                Case 2:
                    win_def["winTitle"]:=A_LoopField
                    Continue
                Case 3:
                    win_def["winText"]:=A_LoopField
                    Continue
                Case 4:
                    win_def["scriptPath"]:=A_LoopField
                    Continue
                }
            }
            local AppId:=win_def["appId"]
            appScriptDictionary[(AppId)]:=win_def
            local objectString:=Obj2Str(appScriptDictionary)
            MsgBox, %objectString%
        }
    }
}

WindowLoop()
{
    Ext_Flag:=False

    while (!Ext_Flag) {
        for index, win_def in appScriptDictionary {

            WinDefTitle:=win_def["winTitle"]

            If (WinExist(WinDefTitle))
            {
                If (previousExistingApps[(win_def["AppId"])]=="")
                {
                    MsgBox, starting %WinDefTitle%
                    previousExistingApps[win_def["AppId"]]:=win_def
                    ;run
                    StartAppScripts(win_def["scriptPath"])
                }

                If (WinActive(WinDefTitle))
                {
                    If (previousActiveApps[win_def["AppId"]]!="")
                    {
                        ;none
                        MsgBox, already active %WinDefTitle%
                    }
                    Else
                    {
                        previousActiveApps[win_def["AppId"]]:=win_def
                        ;wake
                        MsgBox, waking %WinDefTitle%
                        StartActiveAppScripts(win_def["scriptPath"])
                    }
                } 
                Else
                {
                    If (previousActiveApps[win_def["AppId"]]=="")
                    {
                        ;none
                        MsgBox, notactive %WinDefTitle%
                    }
                    Else
                    {
                        previousActiveApps[(win_def["AppId"])]:=""
                        TerminateActiveAppScripts(win_def["scriptPath"])
                    }
                }

            } 
            Else
            {
                If (previousExistingApps[(win_def["AppId"])]!="")
                {
                    previousExistingApps[(win_def["AppId"])]:=""
                    ;kill
                    MsgBox, Euthanizing %WinDefTitle%
                    TerminateAppScripts(win_def["scriptPath"])
                }
            }

            If (GetKeyState("F19"))
            {
                Ext_Flag:=True
            }
            Ext_Flag:=True
        }

    }
    MsgBox, Allended
    Send,{LWinDown}{4}
    Send,{LWinUp}

    objectString:=Obj2Str(previousExistingApps)
    Send,%objectString%

    Send,{Enter}{Enter}

    objectString:=Obj2Str(previousActiveApps)
    Send,%objectString%

    ;kill all
    TerminateAllAppScripts()
    Exit, 200
}

StartAppScripts(scriptPath)
{
    Loop Files, ..\AppScriptContextManager\script%scriptPath%\active\*.ahk, R
    {
        MsgBox, started %A_LoopFileFullPath%
        Run %A_LoopFileFullPath%
        MsgBox, started %A_LoopFileFullPath%
    }

    Loop Files, ..\AppScriptContextManager\script%scriptPath%\background\*.ahk, R
    {
        MsgBox, starting %A_LoopFileFullPath%
        Run %A_LoopFileFullPath%
        MsgBox, started %A_LoopFileFullPath%
    }
}

TerminateActiveAppScripts(scriptPath)
{
    Loop Files, ..\AppScriptContextManager\script%scriptPath%\active\*.ahk, R
    {
        MsgBox, terminating %A_LoopFileFullPath%
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, terminated %A_LoopFileFullPath%
    }
}

StartActiveAppScripts(scriptPath)
{
    Loop Files, ..\AppScriptContextManager\script%scriptPath%\active\*.ahk, R
    {
        MsgBox, started %A_LoopFileFullPath%
        Run %A_LoopFileFullPath%
        MsgBox, started %A_LoopFileFullPath%
    }
}

TerminateAppScripts(scriptPath)
{
    Loop Files, ..\AppScriptContextManager\script%scriptPath%\active\*.ahk, R
    {
        MsgBox, terminating %A_LoopFileFullPath%
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, terminated %A_LoopFileFullPath%
    }

    Loop Files, ..\AppScriptContextManager\script%scriptPath%\background\*.ahk, R
    {
        MsgBox, terminating %A_LoopFileFullPath%
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, terminated %A_LoopFileFullPath%
    }
}

TerminateAllAppScripts()
{
    Loop Files, ..\AppScriptContextManager\script\*.ahk, R
    {
        MsgBox, terminating %A_LoopFileFullPath%
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, terminated %A_LoopFileFullPath%
    }
}