
	.data
msg:	.asciiz  "a soma é: "

	.text
	li $t0,3
	li $t1,4
	add $t2,$t0,$t1
	# print msg
	li $v0, 4
	la $a0, msg
	syscall
	# print $t2 <-- $t2 = $t0 + $t1
	li $v0, 1
	la $a0, ($t2)
	syscall
	# exit
	li $v0, 10
	syscall
