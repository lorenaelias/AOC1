####################################################################################################
		# Somatorio de 1 até n, n lido do dispositivo de entrada padrao #

.data
str1: .asciiz "\nn fora da faixa (1, 99)\n"
str2: .asciiz "digite um inteiro (1, 99): "
str3: .asciiz "o somatorio de (1, n)= "
.text

main:
	# imprime a msg str2
	addi 	$v0, $zero, 4 		#cod apresent string
	la $a0,str2
	syscall
	
	# inteiro n no registrador s0
	addi 	$v0, $zero, 5		#cod leitura inteiro
	syscall
	add	$s0, $zero, $v0		#move o valor lido para s0
	
	# testar se n > 0
	slt 	$t0, $zero, $s0  	# se n > 0  entao t0 <- 1, senao t0 <- 0
	
	# se menor ainda testar n < 100
	addi 	$t2, $zero, 100		# t2 <- 100
	slt 	$t1, $s0, $t2		# se n < 100 entao t1 <- 1, senao t1 <- 0
	and	$t3, $t0, $t1		# se t0 E t1 iguais a 1, entao t3 <- 1
	
	bne 	$t3, $zero, CONTINUE1
	
	# imprime a msg str1
	addi	$v0, $zero, 4
	la	$a0, str1
	syscall
	
	j	main
	
CONTINUE1: # soma de todos numeros entre 1 e n
	add 	$s1, $zero, $zero	# somatorio = s1 = 0
	addi 	$s2, $zero, 1		# contador = 1
	
FOR1:	
	add 	$s1, $s1, $s2		# somatorio += contador
	slt 	$t0, $s0, $s0		# se contador < n
	addi	$s2, $s2, 1		# s2++
	bne	$t0, $zero, FOR1	

	# imprimir str3
	addi	$v0, $zero, 4
	la	$a0, str3
	syscall
	
	# imprimir o somatorio++
	addi	$v0, $zero, 1
	la	$a0, $s1
	
	addi 	$v0, $zero, 10		# cod return 0
	syscall

# la é uma pseudoinstruçao
# la vira lui e ori (é equivalente)
# load upper immediatly
# ori bitwise or immediatly
