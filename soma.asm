.text
main:

	li $s0, 10
	li $s1, 9
	add $s2,$s1,$s0
	
	la $a0, ($s2)
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	