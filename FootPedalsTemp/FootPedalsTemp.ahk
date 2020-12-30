#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
~RControl::
	SendInput,{RControl}
	KeyWait, RControl, T0.8
	if (ErrorLevel)
    {
		;long press
        SendInput,{RControl Down}
    } else {
		KeyWait, RControl, D T1             
		if (ErrorLevel)
        {
			;second press timed out, single press
			SendInput,{Left}
			Return
		} else {
			;double press
			SendInput,{Tab}
			Return
		}	
    }
    KeyWait, RControl, T0.8
    SendInput,{RControl Up}
	return

~RAlt::
	SendInput,{RAlt}
	KeyWait, RAlt, T0.8
	if (ErrorLevel)
    {
		;long press
        SendInput,{RAlt Down}
    } else {
		KeyWait, RAlt, D T1          
		if (ErrorLevel)
        {
			;second press timed out, single press
            SendInput,{Up}
			Return
		} else {
			;double press
            SendInput,{Down}
			Return
		}
    }
    KeyWait, RAlt, T0.8
    SendInput,{RAlt Up}
	return

~LShift::
    SendInput,{LShift}
	KeyWait, LShift, T0.8
	if (ErrorLevel)
    {
		;long press
        SendInput,{LShift Down}
    } else {
		KeyWait, LShift, D T1             
		if (ErrorLevel)
        {
			;second press timed out, single press
            SendInput,{Right}
			Return
		} else {
			;double press
            SendInput,{Enter}
            Return
		}
    }
    KeyWait, LShift, T0.8
    SendInput,{LShift Up}
	return
