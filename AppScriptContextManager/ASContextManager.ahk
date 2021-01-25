#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode RegEx

main()

main()
{
    appScriptDictionary:={}
    lastOpenApps:={}
    lastActiveApp:={}

    Loop, read, ..\AppScriptContextManager\config.txt
    {
        CommentSymIndex:=InStr(A_LoopReadLine,"#")
        if (CommentSymIndex!=1)
        {
            win_def:={}
            Loop, parse, A_LoopReadLine, `,
            {
                Switch A_Index
                {
                Case 1:
                    win_def["appId"]:=A_LoopField
                Case 2:
                    win_def["winTitle"]:=A_LoopField
                Case 3:
                    win_def["winText"]:=A_LoopField
                Case 4:
                    win_def["scriptPath"]:=A_LoopField
                }
            }
            appScriptDictionary[AppId]:=win_def
        }
    }

    Ext_Flag:=False

    while (!Ext_Flag) {
        for index, win_def in appScriptDictionary
            WinDefTitle:=win_def["winTitle"]
            If (win_def["winTitle"]!="")
            {
                WinDefTitleRegex:=".*" . WinDefTitle . ".*"
                If (WinExist(WinDefTitleRegex))
                {
                    If (lastOpenApps[%WinDefTitle%]=="")
                    {
                        lastOpenApps[%WinDefTitle%]:=win_def
                        ;run
                        StartAppScripts(win_def[scriptPath],appScriptDictionary)
                    }

                    If (WinActive(WinDefTitleRegex))
                    {
                        If (lastActiveApp[winTitle]!=%WinDefTitle%)
                        {
                            If (lastActiveApp[winTitle]!="")
                            {
                                ;sleep
                                ToggleSleepAppScripts(lastActiveApp[scriptPath],appScriptDictionary)
                            }
                            lastActiveApp:=win_def
                            ;wake
                            ToggleSleepAppScripts(win_def[scriptPath],appScriptDictionary)
                        }
                    } 
                    Else
                    {
                        If (lastActiveApp[winTitle]==%WinDefTitle%)
                        {
                            lastActiveApp[%WinDefTitle%]:=""
                            ;sleep
                            ToggleSleepAppScripts(win_def[scriptPath],appScriptDictionary)
                        }
                    }

                } 
                Else
                {
                    If (lastOpenApps[%WinDefTitle%]!="")
                    {
                        lastOpenApps[%WinDefTitle%]:=""
                        ;kill
                        TerminateAppScripts(win_def[scriptPath],appScriptDictionary)
                    }
                }
            }
        If (GetKeyState("F19"))
        {
            Ext_Flag:=True
        }

    }
    TerminateAllAppScripts(scriptPath,appScriptDictionary)
    Exit, 200
}

StartAppScripts(scriptPath,appScriptDictionary)
{
    Loop Files, ..\AppScriptContextManager\script%scriptPath%\active\*.ahk
    {
        Run %A_LoopFileFullPath%
        MsgBox, started %A_LoopFileFullPath%
    }

    Loop Files, ..\AppScriptContextManager\script%scriptPath%\background\*.ahk
    {
        Run %A_LoopFileFullPath%
        MsgBox, started %A_LoopFileFullPath%
    }
}

ToggleSleepAppScripts(scriptPath,appScriptDictionary)
{
    Loop Files, ..\AppScriptContextManager\script%scriptPath%\active\*.ahk
    {
        PostMessage, 0x111, 65306,,, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, toggle sleep %A_LoopFileFullPath%
    }
}

TerminateAppScripts(scriptPath,appScriptDictionary)
{
    Loop Files, ..\AppScriptContextManager\script%scriptPath%\active\*.ahk
    {
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, terminated %A_LoopFileFullPath%
    }

    Loop Files, ..\AppScriptContextManager\script%scriptPath%\background\*.ahk
    {
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, terminated %A_LoopFileFullPath%
    }
}

TerminateAllAppScripts(scriptPath,appScriptDictionary)
{
    Loop Files, ..\AppScriptContextManager\script\*.ahk, R
    {
        WinClose, %A_LoopFileName%.ahk - AutoHotkey
        MsgBox, terminated %A_LoopFileFullPath%
    }
}