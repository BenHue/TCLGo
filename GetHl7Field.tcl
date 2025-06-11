# Author: Ben Huerta
# Date: 06/2025
#
# Sample modify HL7 field.
#  - Extract PID:3 and set to 12 characters by prepending zeros
#  
# This code is intended to be executed outside the CL environment
# Multi-function calls are avoided for clarity
#
# Steps to extract HL7 message from CL pointer are skipped
# Set the msg variable with an  HL7 message similar to what CL supplies.
# We add a return (\r) control character to each line to mimic CL
set msg "MSH|^~\&|MESA_ADT|XYZ_ADMITTING|iFW|ZYX_HOSPITAL|||ADT^A04|103102|P|2.4||||||||\r"
append  msg "EVN||200007010800||||200007010800\r"
append  msg "PID|||583295^^^ADT1||DOE^JANE||19610615|M-||2106-3|123 MAIN STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434~(919)277-3114||S||PATID12345001^2^M10|123456789|9-87654^NC\r"
append  msg "NK1|1|BATES^RONALD^L|SPO|||||20011105\r"
append  msg "PV1||E||||||5101^NELL^FREDERICK^P^^DR|||||||||||V1295^^^ADT1|||||||||||||||||||||||||200007010800||||||||\r"
append  msg "PV2|||^ABDOMINAL PAIN\r"
append  msg "OBX|1|HD|SR Instance UID||1.123456.2.2000.31.2.1||||||F||||||\r"
append  msg "AL1|1||^PENICILLIN||PRODUCES HIVES~RASH\r"
append  msg "AL1|2||^CAT DANDER\r"
append  msg "DG1|001|I9|1550|MAL NEO LIVER, PRIMARY|19880501103005|F||\r"
append  msg "PR1|2234|M11|111^CODE151|COMMON PROCEDURES|198809081123\r"
append  msg "ROL|45^RECORDER^ROLE MASTER LIST|AD|CP|KATE^SMITH^ELLEN|199505011201\r"
append  msg "GT1|1122|1519|BILL^GATES^A\r"
append  msg "IN1|001|A357|1234|BCMD|||||132987\r"
append  msg "IN2|ID1551001|SSN12345678\r"

# Extract the field and sub field separator. Should be 4th and 5th characters per HL7 specs.
set fldSep [string index $msg 3]  ;# normally the | character
set subSep [string index $msg 4]  ;# normally the ^ character

# Convert HL7 message to list of segments
set segList [split $msg \r]

# Cl provides the lregex command to search thru lists but standrad TCL does not
# Here we use the foreach with regexp to search thru the list inside a foreach function
foreach segment $segList {
    if { [regexp {^PID} $segment]} {
        set PIDSeg $segment
    }
}

# We have the PID segment now lets break it down by sfields
set PIDFlds [split $PIDSeg $fldSep]
puts "PIDFlds: $PIDFlds"

# Were after the PID:3 field
# We have to keep in mind that the seg name PID is in position 0
set PID_3 [lindex $PIDFlds 3]
puts "PID_3: $PID_3"

# Now we need PID:3:1 so lets split PID_3
set PID_3sFlds [split $PID_3 $subSep]
puts "PID_3sFlds: $PID_3sFlds"

# Finally we reach the MRN in PID:3:1
set PID_3_1 [lindex $PID_3sFlds 0]
puts "PID_3_1: $PID_3_1"

# Ok lets conver it to a 12 char value with pre-pended zeros


 # Ok lets conver it to a 12 char value with pre-pended zeros

# First lets get the length
set length [string length $PID_3_1]

# Either truncate or prepend to form 12 digit character
if {$length > 12} {
    set newPID31 [string range $PID_3_1 [expr {$length - 12}] end]
} else {
    set newPID31 [string repeat "0" [expr {12 - $length}]]$PID_3_1
}

puts "New PID: $newPID31"

# ok lets put everything back together again

set PID_3sFlds [lreplace $PID_3sFlds 0 0 $newPID31]

puts "Replaced PID_3_flds: $PID_3sFlds"

set PID_3_1 [join $PID_3sFlds $subSep]

puts "PID_3_1: $PID_3_1"
