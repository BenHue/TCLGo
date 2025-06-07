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
# We start with HL7 message in the msg variable.
set msg "MSH|^~\&|MESA_ADT|XYZ_ADMITTING|iFW|ZYX_HOSPITAL|||ADT^A04|103102|P|2.4||||||||\n"
append  msg "EVN||200007010800||||200007010800\n"
append  msg "PID|||583295^^^ADT1||DOE^JANE||19610615|M-||2106-3|123 MAIN STREET^^GREENSBORO^NC^27401-1020|GL|(919)379-1212|(919)271-3434~(919)277-3114||S||PATID12345001^2^M10|123456789|9-87654^NC\n"
append  msg "NK1|1|BATES^RONALD^L|SPO|||||20011105\n"
append  msg "PV1||E||||||5101^NELL^FREDERICK^P^^DR|||||||||||V1295^^^ADT1|||||||||||||||||||||||||200007010800||||||||\n"
append  msg "PV2|||^ABDOMINAL PAIN\n"
append  msg "OBX|1|HD|SR Instance UID||1.123456.2.2000.31.2.1||||||F||||||\n"
append  msg "AL1|1||^PENICILLIN||PRODUCES HIVES~RASH\n"
append  msg "AL1|2||^CAT DANDER\n"
append  msg "DG1|001|I9|1550|MAL NEO LIVER, PRIMARY|19880501103005|F||\n"
append  msg "PR1|2234|M11|111^CODE151|COMMON PROCEDURES|198809081123\n"
append  msg "ROL|45^RECORDER^ROLE MASTER LIST|AD|CP|KATE^SMITH^ELLEN|199505011201\n"
append  msg "GT1|1122|1519|BILL^GATES^A\n"
append  msg "IN1|001|A357|1234|BCMD|||||132987\n"
append  msg "IN2|ID1551001|SSN12345678\n\r"
#
# OK msg now contains an HL7 message as normally provided by CL
#


puts $msg
