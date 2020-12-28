#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
q::
	KeyWait, q, T0.1
	if (ErrorLevel)
    {
		;keyup timed out, long press
        SendInput, {LShift Down}{Home Down}
    } else {
		KeyWait, q, D T0.2
		if (ErrorLevel)
        {
			;second press timed out, single press
			SendInput, q
			Return
		} else {
			;double press
			SendInput, {Home}
			Return
		}
	}                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	KeyWait, q
	SendInput, {LShift Up}{Home Up}
return

End::
 	KeyWait, End, T0.1
	if (ErrorLevel)
    {
		;keyup timed out, long press
        SendInput, {LShift Down}{End Down}
    } else {
		KeyWait, End, D T0.2
		if (ErrorLevel)
        {
			;second press timed out, single press
			SendInput, SuperNav
		} else {
			;double press
			SendInput, {End}
		}
	}                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	KeyWait, End
	SendInput, {LShift Up}{End Up}
	
return
