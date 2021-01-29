#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

F16::
	KeyWait, F16, T0.8
	if (ErrorLevel)
    {
		;long press
        Send, {CtrlDown}{ShiftDown}{l}
    	Send, {CtrlUp}{ShiftUp}
    	Return
    } 
	else 
	{
		KeyWait, F16, D T1             
		if (ErrorLevel)
        {
			;second press timed out, single press
			Send, {Tab}
			Return
		} 
		else 
		{
			;double press
			Send, {Home}
			Return
		}
	}
	return

F15::
	KeyWait, F15, T0.8
	if (ErrorLevel)
    {
		;long press
        Send, {Enter}
		Return
    } 
	else 
	{
		KeyWait, F15, D T1             
		if (ErrorLevel)
        {
			;second press timed out, single press
			Send, {LWinDown}{2}
			Send, {LWinUp}
			Return
		} 
		else 
		{
			;double press
			Input_Pattern=%Input_Pattern%Rdd
			MsgBox, Input_Pattern
			Return
		}
	}
	return

F14::
	KeyWait, F14, T0.8
	if (ErrorLevel)
    {
		;long press
		While, GetKeyState("F14")
		{
			Send, {BackSpace}
		}
		Return
    } 
	else 
	{
		KeyWait, F14, D T1             
		if (ErrorLevel)
        {
			;second press timed out, single press
			Send, {CtrlDown}{s}
			Send, {CtrlUp}
		} 
		else 
		{
			;double press
			Send, {End}
			Return
		}
	}
	return