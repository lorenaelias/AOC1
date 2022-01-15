# Branch Example
# C code:
#    int f;
#    int g = 5;
#    int h = 4;
#    int i = 3;
#    int j = 2;
#
#    if (i==j)
#       f = g+h;
#    else
#       f = g-h;

	.text
main:
	li $s1,5 # g
	li $s2,4 # h
	li $s3,3 # i
	li $s4,2 # j
	
	bne $s3, $s4, Else
	add $s0, $s1, $s2
	j Exit

Else:
	sub $s0, $s1, $s2
Exit:
