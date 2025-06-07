# Author: Ben Huerta
# Date: 06/2025
#
# Sample modify HL7 field.
#  - Extract PID:3 and set to 12 characters by prepending zeros
#  
# This code is intended to be executed outside the CL environment
# This is how CL will normally provide an HL7 message.
set msg "MSH|123|123|123\nEVN|123|123|123\nPID|123|123|123\n\r"
puts $msg
