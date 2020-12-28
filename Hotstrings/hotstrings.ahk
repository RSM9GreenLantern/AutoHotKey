#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

::!ahk::autohotkey
::!ahkkeys::
	Run chrome.exe "D:\Documents\Reference\Software\autohotkey\keylist.html" " --new-window "
	Return
::!keys::
	Run sublime_text.exe "D:\Documents\Reference\Software\keyboard_shortcuts.txt"
	Return
::!hotstrings::
	Run sublime_text.exe "D:\Documents\Reference\Software\autohotkey\hotstrings.txt"
	Return
::!newhotstring::
	Run Visual Studio Code %A_ScriptDir%
	Return
::!vs::vs code
:R:!shebang::#!/usr/bin/env
:R0:!avs::Alex von Stuelpnagel 
::!steno::stenotype
::!sysout::System.out.println()
::ggss::git status
::ggad::git add
::ggcm::
	Send, git commit -m ""
	SendInput, {Left}
	Return
::ggps::git push
::ggfa::git fetch --all
::ggpl::git pull

::!wkdy::%A_DDDD%
::!date::%D%-%M%-%yyyy%
::_thishotkey::%A_ThisHotkey%
::_priorkey::%A_PriorKey%

::!google/::
	Query := InputHook("L21",/)
	Run chrome.exe %Query%
 	return
