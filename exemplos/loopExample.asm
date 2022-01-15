# Loop Example
# C Code:
#     int save[5] = {1,1,1,1,2}
#     int k = 1;
#     int i=0;
#        
#     while (save[i] == k) {
#             i += 1;
#     }
	.text
main:
	li $s3, 0
	li $s5, 1
	la $s6, save
Loop:	sll $t1, $s3, 2
	add $t1, $t1, $s6
	lw $t0, 0($t1)
	bne $t0, $s5, Exit
	addi $s3, $s3, 1
	j Loop
Exit:
	
	.data
save:	.word 1 1 1 1 2
