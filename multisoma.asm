# multiplicacao de dois inteiros pode ser feita atraves de somas sucessivas
# proponha um algoritmo recursivo multipRec(n1, n2) que calcule a multiplicacao
# de dois inteiros

.data

.text

MAIN:
	# le inteiro
	addi	$v0, $zero, 5
	syscall
	add	$s0, $zero, $v0		# n1  salvo em s0
	
	# le inteiro
	addi	$v0, $zero, 5
	syscall
	add	$s1, $zero, $v0		# n2  salvo em s1
	
	# chama a funcao mulsoma
	add 	$a0, $zero, $s0		# a0<- n1
	add 	$a1, $zero, $s1		# a1<- n2
	jal 	MULSOMAS
	
	# printa o resultado
	# le inteiro
	addi	$v0, $zero, 1
	add	$a0, $zero, $s7
	syscall
	
MULSOMAS:
	add	$s2, $zero, 1		# contador = 1
	add	$s7, $zero, $a0		# acc = n1
	
LOOP1:
	add	$s7, $s7, $a1		# acc += n2
	addi	$s2, $s2, 1		# contador++
	bne	$s2, $s7, LOOP1
	
#return
END1:
	jr 	$ra
