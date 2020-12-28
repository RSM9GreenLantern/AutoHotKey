#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

SetTimer, MoveMsgBox, -50
MsgBox, 0,Script State,TIME SCROLL\nEsc to exit,1.2
return

MoveMsgBox:
WinGetActiveTitle, Title
WinMove, %Title%,, 0, 0
return

WheelDown::
	Send, {Ctrl Down}{Shift Down}{z}
	Send, {ctrl up}{Shift Up}
	return

WheelUp::
	Send, {Ctrl Down}{z}
	Send, {Ctrl Up}
	Return

MButton::
	SetTimer, MoveMsgBox, -50
	MsgBox, 0,Script State,Exit COPY MODE,1.2
	Exit, 200