	.data
msg:	.asciiz "Hello, World!"

	.text
	# print msg
	li $v0, 4
	la $a0, msg
	syscall
	
	# exit
	li $v0, 10
	syscall


