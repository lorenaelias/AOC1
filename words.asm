# programa que preenche um buffer estatico de 100 words (word = 4 bytes)
# com o numero inteiro x fornecido pelo usuario

.data
buffer: .space 400	# (4bytes*100)
str1: 	.asciiz "digite um numero: "

.text
	# mostra str1
	addi	$v0, $zero, 4
	la	$a0, str1
	syscall
	
	# le inteiro
	addi	$v0, $zero, 5
	syscall
	
	add	$s0, $zero, $v0		# num x  salvo em s0
	
	la 	$s1, buffer			# s1 <- buffer[0]
	add	$a2, $a2, $zero			# contador = 0
	addi	$t0, $zero, 100			# para comparacao
	
# loop 100 vezes escrevendo inteiro na memoria
LOOP1:
	sll	$t1, $s2, 2
	add	$t1, $s1, $t1			# contador++
	sw	$s0, 0($t1)
	
	addi	$a2, 
	bne	$a2, $t0, LOOP1
#return 0
END1:
	addi 	$v0, $zero, 10
	syscall		
	
