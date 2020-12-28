#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Send,{Alt Down}{Tab}

F13 Up::
	Send, {Alt Up}
	Exit, 200

F14::
	Send,{Shift Down}{Tab}
	Return

F15::
	Send,{Tab}
	Return
