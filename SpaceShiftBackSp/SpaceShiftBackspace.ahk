#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

RShift::
	SendInput,{RShift}
	KeyWait, RShift, T1.4
	if (ErrorLevel)
    {
		;long press
        Send,{RShift Down}
    } else {
		KeyWait, RShift, D T0.09             
		if (ErrorLevel)
        {
			;second press timed out, single press
			Send,{Space}
			Return
		} else {
			;double press
			Send,{BackSpace}
			Return
		}
	}                                                                                                                                                                                                                                                                                                                                                                                                                                                              
	KeyWait, RShift
	Send,{RShift Up}
return