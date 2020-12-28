SendMode Input
SetWorkingDir, %A_ScriptDir%

class MappingNode
{
    __New(P_id,P_pattern,P_runPath,P_dotMapping,P_dashMapping)  
    {
        this.N_ID := P_id
		this.N_PATTERN := P_pattern
		this.N_RUNPATH := P_runPath
		this.N_DOTNODES := P_dotMapping
		this.N_DASHNODES := P_dashMapping
    }

    __Get(P_input_pedal,P_input_press)
    {
        shift := MappingNode.N_DOTNODES[aName]
        if (shift != "")
            return (this.RGB >> shift) & 0xff
        ; NOTE: Using 'return' here would break this.RGB.
    }

    __Set(aName, aValue)
    {
        if ((shift := Color.Shift[aName]) != "")
        {
            aValue &= 255  ; Truncate it to the proper range.

            ; Calculate and store the new RGB value.
            this.RGB := (aValue << shift) | (this.RGB & ~(0xff << shift))

            ; 'Return' must be used to indicate a new key-value pair should not be created.
            ; This also defines what will be stored in the 'x' in 'x := clr[name] := val':
            return aValue
        }
        ; NOTE: Using 'return' here would break this.stored_RGB and this.RGB.
    }

    ; Meta-functions can be mixed with properties:
    N_PATTERN {
        get {
            ; Return it in hex format:
            return this.N_PATTERN
        }
        set {
            return this.stored_RGB := value
        }
    }
}