#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
SetTitleMatchMode RegEx
#Include, ..\AppScriptContextManager\obj2Str.ahk
#Include, ..\AppScriptContextManager\ScriptManager.ahk

global appScriptDictionary
global previousExistingApps
global previousActiveApps

main()

main()
{
    global appScriptDictionary:={}
    global previousExistingApps:={}
    global previousActiveApps:={}

    InitializeDictionary()
    WindowLoop()
}

InitializeDictionary()
{
    global appScriptDictionary

    Loop, read, ..\AppScriptContextManager\config.txt
    {
        win_def:={}
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
            AppId:=win_def["appId"]
            appScriptDictionary[(AppId)]:=win_def
            objectString:=Obj2Str(appScriptDictionary)
            MsgBox, %objectString%
        }
    }
}

WindowLoop()
{
    global appScriptDictionary
    global previousExistingApps
    global previousActiveApps

    Ext_Flag:=False

    while (!Ext_Flag) {
        for index, win_def in appScriptDictionary {

            WinDefTitleRegex:=win_def["winTitle"]
            WinDefId:=win_def["appId"]
            WinDefScriptPath:=win_def["scriptPath"]

            If (WinExist(WinDefTitleRegex))
            {
                If (previousExistingApps[(WinDefId)]=="")
                {
                    MsgBox, starting %WinDefTitleRegex%
                    previousExistingApps[(WinDefId)]:=win_def
                    ;run
                    StartBackgroundAppScripts(WinDefScriptPath)
                }

                If (WinActive(WinDefTitleRegex))
                {
                    If (previousActiveApps[(WinDefId)]=="")
                    {
                        previousActiveApps[(WinDefId)]:=win_def
                        ;wake
                        MsgBox, waking %WinDefTitleRegex%
                        StartActiveAppScripts(WinDefScriptPath)
                    }
                } 
                Else
                {
                    If (previousActiveApps[(WinDefId)]!="")
                    {
                        previousActiveApps[(WinDefId)]:=""
                        TerminateActiveAppScripts(WinDefScriptPath)
                    }
                }
            } 
            Else
            {
                If (previousExistingApps[(WinDefId)]!="")
                {
                    previousExistingApps[(WinDefId)]:=""
                    ;kill
                    TerminateAppScripts(WinDefScriptPath)
                }
            }

            If (GetKeyState("F19"))
            {
                Ext_Flag:=True
            }
        }
    }
    MsgBox, Allended
    Send,{LWinDown}{4}
    Send,{LWinUp}

    objectString:=Obj2Str(previousExistingApps)
    Send,Existing %objectString%

    Send,{Enter}{Enter}

    objectString:=Obj2Str(previousActiveApps)
    Send,Active %objectString%

    ;kill all
    TerminateAllAppScripts()
    Exit, 200
}