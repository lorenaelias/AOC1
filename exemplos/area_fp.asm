	.data
pi: 	.double	3.141592653589793
str0:	.asciiz	"raio ? "
str1:	.asciiz	"area = "
	.text
	.globl	main
main: 	
	li	$v0, 4
	la	$a0, str0
	syscall 
	li	$v0, 7 			# read_double
	syscall 			# radius <- user input
	la 	$a0, pi
	l.d 	$f12, 0($a0) 		# a := pi
	mul.d 	$f12, $f12, $f0 	# a := a * r
	mul.d 	$f12, $f12, $f0 	# a := a * r

	li	$v0, 4
	la	$a0, str1
	syscall 
	li 	$v0, 3 			# print_double
	syscall 			# print area

	li	$v0, 10
	syscall 
