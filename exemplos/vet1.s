
	.data
	.align 2
msg1:	.asciiz "\nDigite um numero inteiro: "
msg2:	.asciiz "\nSomatorio: "
vet1:	.word	0:10	#10 element integer array
vet2:	.word	0x12345678:10	#10 element integer array
n:	.word	10
i:	.word	0
s:	.word	0
	.globl	main
	.text
# No interior do main existem algumas chamadas (syscalls) que
# irão alterar o valor do registo $ra o qual contém inicialmente o
# endereço de retorno do main. Este necessita de ser guardado.
main:	
	xor	$t0, $t0, $t0
	xor	$t2, $t2, $t2
	lw	$t1, n($zero)
	xor	$t3, $t3, $t3
	la	$t4, vet1
L1:	beq	$t0, $t1, L1_FIM	
	li	$v0, 4 		# chamada sistema print_str
	la	$a0, msg1 	# endereço da string a imprimir
	syscall
# obter o inteiro do usuario
	li	$v0, 5		# chamada sistema read_int
	syscall			# coloca o inteiro em $v0
# armazenar valor no vetor
	sw	$v0, vet1($t3)
	add	$t2, $t2, $v0
	addi	$t3, $t3, 4
	addi	$t0, $t0, 1
	j L1
# imprimir o somatorio
L1_FIM:	sw	$t2, s($zero)
	li	$v0, 4 		# chamada sistema print_str
	la	$a0, msg2 	# endereço da string a imprimir
	syscall
	li	$v0, 1 		# chamada sistema print_int
	addu	$a0, $t2, $zero 	# mover o número a imprimir para $a0
	syscall
# exit
	li	$v0, 10		# chamada sistema exit
	syscall

