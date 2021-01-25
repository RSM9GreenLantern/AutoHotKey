#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

F23::
    SendInput,{Ctrl down}{l}
    Send,{Ctrl up}

    Send,{Ctrl down}{c}
    Send,{Ctrl up}

    Send,{LWin down}{4}
    Send,{LWin up}

    Send,{Ctrl down}{v}
    Send,{Ctrl up}
    Send,{Enter}{Enter}

    Send,{LWin down}{2 down}
    Send,{2 up}
    Send,{2 down}
    Send,{2 up}
    Send,{LWin up}
    Return