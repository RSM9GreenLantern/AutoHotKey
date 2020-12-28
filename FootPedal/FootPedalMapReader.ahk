#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

InputToScriptMap := []

initMap() 
{
 	Loop, read, FootPedalConfig.txt
	{
    	KeyLabelParts := StrSplit(A_LoopReadLine, ",")

		Pedal := KeyLabelParts[1]
		Presses := KeyLabelParts[2]
		EndPress := KeyLabelParts[3]
		ScriptPath := KeyLabelParts[4]
		MsgBox, %Pedal%_%Presses%_%EndPress%

		InputToScriptMap[%Pedal%_%Presses%_%EndPress%] := KeyLabelParts[4]

		wang := InputToScriptMap[%Pedal%_%Presses%_%EndPress%]

		MsgBox, %wang%

	}
	Return
}