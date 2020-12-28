#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

+Insert::BackSpace
<!Enter::Esc

<!9::SendRaw, {

<!0::SendRaw, }

LShift::
	SendInput, {LShift}
	KeyWait, LShift, T0.1
	if (ErrorLevel)
    {
		;keyup timed out, long press
        Send, {LShift Down}
    } else {
		KeyWait, LShift, D T0.2
		if (ErrorLevel)
        {
			;second press timed out, single press
			Send, {Space}
			Return
		} else {
			;double press
			Send, {BackSpace}
			Return
		}
	}                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	KeyWait, LShift
	Send, {LShift Up}
return
