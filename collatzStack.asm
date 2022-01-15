
#####################################################################################################################################
# Leandro Fontellas Laurito
# 11721BCC045
# 12/12/2018
# O codigo ira receber do usuario um numero inteiro positivo e montar a sequencia de acordo com a conjectura de collatz
#####################################################################################################################################
.data
	Texto1: .asciiz "Primeiro Termo: "
	Texto2: .asciiz "Numero invalido."
	Texto3: .asciiz "Lista de Termos: "
	virgula: .asciiz ", "
	
 
 .text
 
 		main:
 			li $t4,1  #Colocando em t0 o valor 1 para podermos testar posteriormente se o numero digitado eh 1
 		
 			li $v0, 4	#Imprime primeiro texto
 			la $a0, Texto1
 			syscall
 		
 			li $v0,5	#Le o numero e coloca no $v0
 			syscall
 		
 			move $t0,$v0	#Move o conteudo de $v0 para $t0
 		
 			addi $sp,$sp,-8 #Aloca 1 espaço de 1 inteiro na pilha
 			sw $t0,0($sp) #Salva o valor coletado na pilha
 			sw $t4,4($sp) #Salva o valor 1 do resgistrador $t4 para utilizarmos nos branchs
 		
 			blez $t0,imprime_falha  #Valor de t0 < zero
 		
 			li $v0,4	#Imprime texto3 
 			la $a0,Texto3
 			syscall
 		
 			jal collatz	#Se o valor em t0 for maior que zero entao ele sera tratado de acordo com a conjectura
	  		
	  		li $v0,1     #imprime o numero 1
	  		move $a0,$t0
	  		syscall
	  	Fim:
	  	
	  		addi $sp,$sp,8  #Devolve o espaço alocado para o sistema
	  	
	  		#Encerra o programa
	  		li $v0, 10
	  		syscall
	  	
	  	#--------------------------------------------------------------------------------------------------
	  	imprime_falha:
	  	
	  		li $v0,4	#syscall 4 para imprimir textos
	  		la $a0,Texto2
	  		syscall
	  	
	  		j Fim
 		
 		#--------------------------------------------------------------------------------------------------
 		#############################################################################################################################
		#Function: collatz
		#Description: Com o numero que o usuario digitou e atraves de funções recursivas aplicará a Conjectura de Collatz
		#InPut:Registers $t0=numero que o usario digitou,$t4=1
		#OutPut: $t0=1,$t4=1
		#Return: : Disponibilizara na tela a lista de termos de acordo com a Conjectura
		#############################################################################################################################
 		collatz:
 			la $t5,($ra)    #Salva o endereço do final da função
 			lw $t4,4($sp) #Pega o valor da pilha e coloca em t4 para usar nos branchs
 			lw $t0,0($sp) #Pega o valor que foi salvado na pilha(posicao 0) e coloca em $t0
 		
 			#if($t0!=1)
 			bne $t4,$t0,N_chegou_ao_fim3	#Desvio caso o valor de t0 seja 1 ele encerra o programa		
			
			jr $t5
			
			N_chegou_ao_fim3:
 		
 			add $t3,$zero,3	#coloca no t3 o valor 3
 			li $t1, 2	# coloca no t1 valor dois para nós dividirmos e testar se o resto eh zero ou 1
 			div $t0,$t1 	# faz a divisao inteira de t0 por t1
 			mfhi $s0	# coloca no s0 o resto da divisao
 		
 			sw $t0,0($sp)   #Salva o valor coletado na pilha para usarmos nas outras duas funções
 			
 			#if($s0%2==0)
 			beq $s0,$zero, par3   #compara resto se eh zero para o tratamento par
 			#else
 			jal tratamentoimpar  #compara o resto se eh diferente de zero para o tratamento impar
 			par3:
 			jal tratamentopar
 			
	  	
	  	#-------------------------------------------------------------------------------------------------
	  	#############################################################################################################################
		#Function: tratamentopar
		#Description: Função auxiliar da função principal, ele fará atraves de recursividade os calculos para caso o numero seja par chamando ela mesma ou tratamentoimpar caso necessario
		#InPut:Registers $t0=numero que o usario digitou,$t4=1
		#OutPut: $t0=variavel,$t4=1
		#Return: : Testara se o valor é par ou impar e colocara em $t0 o resultado da divisao
		#############################################################################################################################
	  	tratamentopar:
	  		
	  		lw $t0,0($sp) #Pega o valor que foi salvado na pilha(posicao 0) e coloca em $t0
	  		lw $t4,4($sp) #Pega o valor da pilha e coloca em t4 para usar nos branchs
	  	
	  		li $v0,1     #imprime o numero
	  		move $a0,$t0
	  		syscall
	  	
	  		move $t0,$a0 #coloca de volta no t0 o numero 	
	  	
	  		li $v0,4	#coloca 1 virgula
	  		la $a0,virgula
	  		syscall
 		
 			div  $t0,$t1 #divide o numero por 2
 			mflo $t0 #coloca em t0 o quociente
 		
 			div $t0, $t1 #divide ele por dois novamente para usar o resto da divisao
 		
 			sw $t0,0($sp)   #Salva o valor coletado na pilha para usarmos posteriormente
 		
 			mfhi $s0 #pega o resto da divisao

 		
 			#if($t0!=1)
 			bne $t4,$t0,N_chegou_ao_fim	#Desvio caso o valor de t0 seja 1 ele encerra o programa		
			
			jr $t5
			
			N_chegou_ao_fim:
 		
 			#if($s0%2==0)
 			beq $s0,$zero, par   #compara resto se eh zero para o tratamento par
 			#else
 			jal tratamentoimpar  #compara o resto se eh diferente de zero para o tratamento impar
 			par:
 			jal tratamentopar
 		
 		#-------------------------------------------------------------------------------------------
	  	#############################################################################################################################
		#Function: tratamentoimpar
		#Description: Função auxiliar da função principal, ele fará atraves de recursividade os calculos para caso o numero seja impar chamando ela mesma ou tratamentopar caso necessario
		#InPut:Registers $t0=numero que o usario digitou,$t4=1
		#OutPut: $t0=variavel,$t4=1
		#Return: : Testara se o valor é par ou impar e colocara em $t0 o resultado da divisao
		#############################################################################################################################
 		tratamentoimpar:
 			
 			lw $t0,0($sp) #Pega o valor que foi salvado na pilha(posicao 0) e coloca em $t0
	  		lw $t4,4($sp) #Pega o valor da pilha e coloca em t4 para usar nos branchs
 		
 			li $v0,1     #imprime o numero
	  		move $a0,$t0
	  		syscall
	  	
	  		move $t0,$a0 #coloca de volta no t0 o numero 
	  	
	  		li $v0,4	#coloca 1 virgula
	  		la $a0,virgula
	  		syscall
	  	
	  		mul $t2,$t0,$t3	#multiplca por 3 e coloca no t2
	  		add $t2,$t2,1  #soma mais 1 no resultado da multiplicação
	  		move $t0,$t2  #coloca de volta no t0 o resultado funal
	  	
	  		div $t0,$t1
	  	
	  		sw $t0,0($sp)   #Salva o valor coletado na pilha para usarmos posteriormente
	  	
 			mfhi $s0 #pega o resto da divisao
 		
 			#if($t0!=1)
 			bne $t4,$t0,N_chegou_ao_fim2	#Desvio caso o valor de t0 seja 1 ele encerra o programa		
			
			jr $t5
			
			N_chegou_ao_fim2:
			
			#if($s0%2==0)
 			beq $s0,$zero, par2   #compara resto se eh zero para o tratamento par
 			#else
 			jal tratamentoimpar  #compara o resto se eh diferente de zero para o tratamento impar
 			par2:
 			jal tratamentopar
	  	
