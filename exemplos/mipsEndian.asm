.data
b:      .byte   0x11 0x22 0x33 0x44
a:      .word   0x11223344
 
.text
# First, we are going to load data segment 'b' and store each byte using an offset (0, 1, 2, and 3)
la $s0, b
lb $s1, 0($s0)
lb $s2, 1($s0)
lb $s3, 2($s0)
lb $s4, 3($s0)
# You see that things act accordingly. $s1 has the value 0x00, $s2 has the value 0x11, and so on
 
# Now we are going to load data segment 'a'.
# This piece of data is now a WORD, so we are going to notice the effects of endian
la $t0, a
# If you load the entire word, you can NOT see the effects of little endian. MIPS displays the entire value as we would expect.
lw $t1, 0($t0)
# However, if you load each byte of the word seperately, things start to look strange.
lb $t2, 0($t0)
lb $t3, 1($t0)
lb $t4, 2($t0)
lb $t5, 3($t0)
# You notice that $t2 (with an offset of 0) does not contain 0x00 as we would expect, but contains 0x33
# The least significant byte (0x33 in the word 'a' above) is ordered first (offset 0).
# Similarily, $t3 contains 0x22 (not 0x11) and so on...
 
# MIPS stores words in 'byte chunks'. In memory these bytes are stored "backward" or in little endian
# We don't notice this unless we are accessing bytes of a word using an offset.

