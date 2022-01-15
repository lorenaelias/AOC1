	.data
dec: 	.float 	0.1
cent:	.float 	0.01
eps: 	.float 	1.0e-8
str1:	.asciiz	"\nigual\n"
str2:	.asciiz	"\ndiferente\n"
str3:	.asciiz "\ndecimo: "
str4:	.asciiz "\ncentesimo: "

	.text 
	la 	$a0, dec 
	la 	$a1, cent 
	la 	$a2, eps 
	l.s 	$f0, ($a0)
	l.s 	$f1, ($a1) 
	l.s 	$f2, ($a2)
	li	$v0, 4
	la	$a0, str3
	syscall 
	mov.s	$f12, $f0
	li 	$v0, 2 			# print_float
	syscall 			# print decimo
	li	$v0, 4
	la	$a0, str4
	syscall 
	mov.s	$f12, $f1
	li 	$v0, 2 			# print_float
	syscall 			# print centesimo

	mul.s 	$f0, $f0, $f0 		# $f0 := 0.1 * 0.1
	li	$v0, 4
	la	$a0, str4
	syscall 
	mov.s	$f12, $f0
	li 	$v0, 2 			# print_float
	syscall 			# print centesimo 0.1 * 0.1

	sub.s 	$f3, $f0, $f1 		# $f3 := (0.1 * 0.1) - 0.01
	abs.s 	$f3, $f3 		# $f3 := |(0.1 * 0.1) - 0.01|
	c.lt.s 6 $f3, $f2 		# flag 6 = $f3 < 1.0e-7 ?
	bc1f 6 	diff 			# if(not flag 6) goto diff
	# approximately equal!
	li	$v0, 4
	la	$a0, str1
	syscall
	j fim
diff:
	li	$v0, 4
	la	$a0, str2
	syscall

fim:	li	$v0, 10
	syscall 
