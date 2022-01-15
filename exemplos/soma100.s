	.data
	.align    0
str:
	.asciiz   "A soma de 0 .. 100 eh: "

	.text
	
	addiu	$t0,$zero,1
	addiu	$t1,$zero,100
	xor	$t2,$t0,$t0
ini_loop:
#	slt	$t3,$t0,$t1
	bgt	$t0,$t1,fim_loop
	addu	$t2,$t2,$t0
	addiu	$t0,$t0,1
	j ini_loop	

fim_loop:
	li $v0, 4		# imprime resposta
	la $a0, str		# syscall(4) = imprime string
	syscall

	li $v0, 1		# imprime inteiro
	move $a0, $t2		# syscall(1) = imprime inteiro
	syscall	
		
	# exit
	li $v0, 10
	syscall


