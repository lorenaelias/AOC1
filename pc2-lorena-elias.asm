#####################################################################
#   	       Raízes Reais de Uma Equação Quadrática               #
#####################################################################
#			     UFU 2018 - 2                           #
#	    Arquitetura e Organização de Computadores 1             #
#  		 Lorena da Silva Elias 11721BCC019                  #
#                                                                   #
#   	O programa calcula as raízes de uma equação do tipo:        #
#                                                                   #
#   			Ax^2 + Bx + C  = 0                          #
#####################################################################


############################# Dados iniciais que serão utilizados no programa ################################
.data
	tipo: .asciiz "Ax^2 + Bx + C"
	A: .asciiz "\nA= "
	B: .asciiz "\nB= "
	C: .asciiz "\nC= "
	error: .asciiz "Delta: -1. Discriminante negativo!\n"
	r1: .asciiz "\nr1= "
	r2: .asciiz "\nr2= "
	acao: .asciiz "\nCalcular outras raizes - (1)\nSair - Qualquer outra tecla\n "
	zeroFloat: .float 0.0
	um: .float -1.0
	quatro: .float 4
	dois: .float 2
	umt: .word 1

.text

	lw $t3,umt
	
	# Exibe a string 'tipo'
	li $v0,4
	la $a0,tipo
	syscall

############################################# Programa principal ###########################################
main:
	# Guarda floats uteis para o programa
	
	lwc1 $f4,zeroFloat	# lwc1: Carrega a palavra do coproc 1
	lwc1 $f2,um
	lwc1 $f20,dois
	lwc1 $f18,quatro

 	# Solicita primeira entrada 
	li $v0,4		
	la $a0,A
	syscall
 
	li $v0,6
	syscall
	mov.s $f6,$f0
 
  	# Solicita segunda entrada 
	li $v0,4		
	la $a0,B
	syscall
 
	li $v0,6
	syscall
	mov.s $f8,$f0
  
  	# Solicita terceira entrada
	li $v0,4		
	la $a0,C
	syscall
 
	li $v0,6
	syscall
	mov.s $f10,$f0
	
	# Chama a funcao 'sqrDelta'
	jal sqrDelta

	# Exibe a raiz (r1)
	li $v0,4
	la $a0,r1
	syscall 
 
	li $v0,2
	add.d $f12,$f4,$f26
	syscall

	# Exibe a raiz (r2)
	li $v0,4
	la $a0,r2
	syscall
 
	li $v0,2
	add.d $f12,$f4,$f30
	syscall
	
	# Chama a funcao 'escolha'
	b escolha

##################################### Calcula a raiz do discriminante ######################################
sqrDelta:
	# Calcula o discriminante (delta)
	mul.s $f14,$f8,$f8 	#b2
	mul.s $f2,$f8,$f2 	#-b
	mul.s $f16,$f6,$f10   	#ac
	mul.s $f10,$f18,$f16 	#4ac
	sub.s $f22,$f14,$f10 	#b2-4ac
	mfc1 $t1,$f22
	
	# Verifica se o discriminante é negativo
	bltz $t1 complexa	# e chama a funcao 'complexa'
	
	# Calcula a raiz do discriminante
	sqrt.s $f28,$f22 	#sqrt(b2-4ac)
	add.s $f22,$f2,$f28	#-b+sqrt(b2-4ac)
	sub.s $f24,$f2,$f28 	#-b-sqrt(b2-4ac)
	
	# Calcula as raizes da equacao
	mul.s $f16,$f20,$f6 	#2a
	div.s $f26,$f22,$f16	#(-b+sqrt(b2-4ac))/2a
	div.s $f30,$f24,$f16	#(-b-sqrt(b2-4ac))/2a
	
	# Volta de onde foi chamada (main)
	jr $ra

########################################## Caso delta negativo ############################################## 
complexa:
	li $v0,4
	la $a0,error
	syscall
	
	j main

##################################### Continuar ou sair do programa #########################################
escolha:
	li $v0,4
	la $a0,acao
	syscall

	li $v0,5
	syscall
	move $t0,$v0
	beq $t0,$t3,main  # Se o numero lido for 1, volta para a main

	li $v0,10   	  # Senao termina o programa
	syscall