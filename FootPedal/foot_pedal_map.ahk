#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#Include, FootPedalMapReader.ahk

initMap()

CONST_PEDALS_LEFT := "LeftPedal"
CONST_PEDALS_CENTER := "CenterPedal"
CONST_PEDALS_RIGHT := "RightPedal"

CONST_INPUT_HOLD := "hold"
CONST_INPUT_RELEASE := "release"

F13::
    ExitSwitch:=False
    While, ExitSwitch==False
    {
        KeyWait, F13, T0.4
        if (ErrorLevel)
        {
            ;keyup timed out, long press
            ExitSwitch:=True
            InterpretPedalInput(CONST_PEDALS_LEFT,CONST_INPUT_HOLD,A_Index)
        } else {
            KeyWait, F13, D T0.4
            if (ErrorLevel)
            {
                ;second press timed out, single press
                ExitSwitch:=True
                InterpretPedalInput(CONST_PEDALS_LEFT,CONST_INPUT_RELEASE,A_Index)
                Return
            } else {
                ;second press
            }
        }
    }
    KeyWait, F13
return

F14::
    ExitSwitch:=False
    While, ExitSwitch==False
    {
        KeyWait, F14, T0.4
        if (ErrorLevel)
        {
            ;keyup timed out, long press
            ExitSwitch:=True
            InterpretPedalInput(CONST_PEDALS_CENTER,CONST_INPUT_HOLD,A_Index)
        } else {
            KeyWait, F14, D T0.4
            if (ErrorLevel)
            {
                ;second press timed out, single press
                ExitSwitch:=True
                InterpretPedalInput(CONST_PEDALS_CENTER,CONST_INPUT_RELEASE,A_Index)
                Return
            } else {
                ;second press
            }
        }
    }
    KeyWait, F14
return

F15::
    ExitSwitch:=False
    While, ExitSwitch==False
    {
        KeyWait, F15, T0.4
        if (ErrorLevel)
        {
            ;keyup timed out, long press
            ExitSwitch:=True
            InterpretPedalInput(CONST_PEDALS_RIGHT,CONST_INPUT_HOLD,A_Index)
        } else {
            KeyWait, F15, D T0.4
            if (ErrorLevel)
            {
                ;second press timed out, single press
                ExitSwitch:=True
                InterpretPedalInput(CONST_PEDALS_RIGHT,CONST_INPUT_RELEASE,A_Index)
                Return
            } else {
                ;second press
            }
        }
    }
    KeyWait, F15
return

InterpretPedalInput(PedalConst,InputConst,Presses)
{
    ;MsgBox, , , pedal %PedalConst% input %InputConst% presses %Presses%, 0.8
    Switch PedalConst
    {
        Case "LeftPedal":
            Switch Presses
            {
                Case 1:
                    Switch InputConst
                    {
                        Case "hold":
                            Send,{Ctrl Down}
                            KeyWait, F13
                            Send,{Ctrl Up}
                            Return
                        Case "release":
                            Send,{Left}
                            Return
                    }
                Case 2:
                    Switch InputConst
                    {
                        Case "hold":
                            MsgBox, Input Unmapped
                            Return
                        Case "release":
                            Send,{Ctrl Down}{Left}
                            Send,{Ctrl Up}
                            Return
                    }
                Case 3:
                    Switch InputConst
                    {
                        Case "hold":
                            MsgBox, Input Unmapped
                            Return
                        Case "release":
                            Send,{Enter}
                            Return
                    }
                Default:
                    MsgBox, %Presses% presses %InputConst% for %PedalConst% is unmapped
                    Return
            }
        Case "CenterPedal":
            Switch Presses
            {
                Case 1:
                    Switch InputConst
                    {
                        Case "hold":
                            Send,{Alt Down}
                            KeyWait, F14
                            Send,{Alt Up}
                        Case "release":
                            Send,{Down}
                            Return
                    }
                Case 2:
                    Switch InputConst
                    {
                        Case "hold":
                            MsgBox, Input Unmapped
                            Return
                        Case "release":
                            Send,{Up}
                            Return
                    }
                Case 3:
                    Switch InputConst
                    {
                        Case "hold":
                            MsgBox, Input Unmapped
                            Return
                        Case "release":
                            Send,{LWin Down}{m}
                            Send,{LWin Up}
                            Return
                    }
                Default:
                    MsgBox, %Presses% presses %InputConst% for %PedalConst% is unmapped
                    Return
            }
        Case "RightPedal":
            Switch Presses
            {
                Case 1:
                    Switch InputConst
                    {
                        Case "hold":
                            Send, {Shift Down}
                            KeyWait, F15
                            Send, {Shift Up}
                            Return
                        Case "release":
                            Send, {Right}
                            Return
                    }
                Case 2:
                    Switch InputConst
                    {
                        Case "hold":
                            MsgBox, Input Unmapped
                            Return
                        Case "release":
                            Send,{Ctrl Down}{Right}
                            Send,{Ctrl Up}
                            Return
                    }
                Case 3:
                    Switch InputConst
                    {
                        Case "hold":
                            MsgBox, Input Unmapped
                            Return
                        Case "release":
                            Send, {Escape}
                            Return
                    }
                Default:
                    MsgBox, %Presses% presses %InputConst% for %PedalConst% is unmapped
                    Return
            }
    }
}
