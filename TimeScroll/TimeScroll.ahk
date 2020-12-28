#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

WheelDown::
	Send, {Ctrl Down}{Shift Down}{z}
	Send, {ctrl up}{Shift Up}
	return

WheelUp::
	Send, {Ctrl Down}{z}
	Send, {Ctrl Up}

MButton::Exit, 200