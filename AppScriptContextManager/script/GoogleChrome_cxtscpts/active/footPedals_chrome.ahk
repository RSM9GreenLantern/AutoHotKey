#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

F16::
    Send, {CtrlDown}{ShiftDown}{Tab}
    Send, {CtrlUp}{ShiftUp}
    Return
    
F15::
    Send, {CtrlDown}{w}
    Send, {CtrlUp}
    Return
    
F14::
    MsgBox, test
    Send, {CtrlDown}{Tab}
    Send, {CtrlUp}
    Return