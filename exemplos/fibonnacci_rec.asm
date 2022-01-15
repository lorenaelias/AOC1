#------------------------------------------------
# fib - recursive Fibonacci function.
#
# a0 - holds parameter n
# s0 - holds fib(n-1)
# v0 - returns result
#------------------------------------------------
# Code segment
	.text
	li 	$a0, 7
	jal	fib
	move	$t0, $v0
	li 	$v0, 1 		# load appropriate system call code into register $v0;
				# code for printing integer is 1
	move 	$a0, $t0 	# move integer to be printed into $a0: $a0 = $t2
	syscall 		# call operating system to perform operation	
	li	$v0, 10
	syscall
	
fib: 	sub 	$sp,$sp,12 	# save registers on stack
	sw 	$a0,0($sp)
	sw 	$s0,4($sp)
	sw 	$ra,8($sp)
	bgt 	$a0,1,plus1
	move 	$v0,$a0 	# fib(0)=0, fib(1)=1
	b fret 			# if n<=1
plus1: 	sub 	$a0,$a0,1 	# param = n-1
	jal 	fib 		# compute fib(n-1)
	move 	$s0,$v0 		# save fib(n-1)
	sub 	$a0,$a0,1 	# set param to n-2
	jal 	fib 		# and make recursive call
	add 	$v0,$v0,$s0 	# add fib(n-2)
fret: 	lw 	$a0,0($sp) 	# restore registers
	lw 	$s0,4($sp)
	lw 	$ra,8($sp)
	add 	$sp,$sp,12
	jr 	$ra

# data segment
	.data
endl: .	asciiz "\n"