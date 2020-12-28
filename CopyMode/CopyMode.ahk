#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SetTimer, MoveMsgBox, -50
MsgBox, 0,Script State,COPY MODE\nEsc to exit,1.2
return

MoveMsgBox:
WinGetActiveTitle, Title
WinMove, %Title%,, 0, 0
return

MButton::
	KeyWait, MButton, T0.1
	if (ErrorLevel)
    {
        Send,{Ctrl Down}
    } else {
		KeyWait, MButton, D T0.2
		if (ErrorLevel)
        {
			;second press timed out, single press
			Send,{Ctrl Down}{c}
			Send,{Ctrl Up}
			Return
		} else {
			;double press
			Send,{Ctrl Down}{v}
			Send,{Ctrl Up}
			Return
		}
	}                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	KeyWait, MButton
	Send,{Ctrl Up}
return

Escape::
	SetTimer, MoveMsgBox, -50
	MsgBox, 0,Script State,Exit COPY MODE,1.2
	Exit, 200