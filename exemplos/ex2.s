
	.data
msg1:	.asciiz "\nDigite um numero inteiro: "
vet1:	.space	40
vet2:	.space	40
	.text
	.globl	main
# No interior do main existem algumas chamadas (syscalls) que
# ir�o alterar o valor do registo $ra o qual cont�m inicialmente o
# endere�o de retorno do main. Este necessita de ser guardado.
main:	
	addi 	$sp,$sp,-4 	#save the return address.
	sw 	$ra,0($sp) 	# push $ra on the stack	
	
	li	$t0,555
	sw	$t0,vet1($zero)
	li	$t0,777
	sw	$t0,vet2($zero)
	
	li	$v0, 4 		# chamada sistema print_str
	la	$a0, msg1 	# endere�o da string a imprimir
	syscall
# obter o inteiro do usuario
	li	$v0, 5		# chamada sistema read_int
	syscall			# coloca o inteiro em $v0
# realizar c�lculos com o inteiro
	addu	$t0, $v0, $zero 	# mover o n�mero para $t0
	sll	$t0, $t0, 2 	#
# imprimir o resultado
	li	$v0, 1 		# chamada sistema print_int
	addu	$a0, $t0, $zero 	# mover o n�mero a imprimir para $a0
	syscall
# rep�r o endere�o de retorno para o $ra e retornar do main
	lw 	$ra,0($sp)
	addi 	$sp,$sp,4
	jr 	$ra

