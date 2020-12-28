#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Input_Pattern=''
F13::
	SendInput,{RShift}
	KeyWait, F13, T0.8
	if (ErrorLevel)
    {
		;long press
        Input_Pattern=%Input_Pattern%Lda
		MsgBox, Input_Pattern
    } else {
		KeyWait, F13, D T1             
		if (ErrorLevel)
        {
			;second press timed out, single press
			Input_Pattern=%Input_Pattern%Ldo
			MsgBox, Input_Pattern
			Return
		} else {
			;double press
			Input_Pattern=%Input_Pattern%Ldd
			MsgBox, Input_Pattern
			Return
		}
	return

F14::
	SendInput,{RShift}
	KeyWait, F14, T0.8
	if (ErrorLevel)
    {
		;long press
        Input_Pattern=%Input_Pattern%Cda
		MsgBox, Input_Pattern
    } else {
		KeyWait, F14, D T1          
		if (ErrorLevel)
        {
			;second press timed out, single press
			Input_Pattern=%Input_Pattern%Cdo
			MsgBox, Input_Pattern
			Return
		} else {
			;double press
			Input_Pattern=%Input_Pattern%Cdd
			MsgBox, Input_Pattern
			Return
		}
	return

F15::
	SendInput,{RShift}
	KeyWait, F15, T0.8
	if (ErrorLevel)
    {
		;long press
        Input_Pattern=%Input_Pattern%Rda
		MsgBox, Input_Pattern
    } else {
		KeyWait, F15, D T1             
		if (ErrorLevel)
        {
			;second press timed out, single press
			Input_Pattern=%Input_Pattern%Rdo
			MsgBox, Input_Pattern
			Return
		} else {
			;double press
			Input_Pattern=%Input_Pattern%Rdd
			MsgBox, Input_Pattern
			Return
		}
	return
