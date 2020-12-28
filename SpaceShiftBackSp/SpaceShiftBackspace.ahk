#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

RShift::
	SendInput,{RShift}
	KeyWait, RShift, T0.08  
	if (ErrorLevel)
    {
		;long press
        Send,{RShift Down}
    } else {
		KeyWait, RShift, D T0.088             
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