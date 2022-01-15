#####################################################################################################################################
# Leandro Fontellas Laurito
# 11721BCC045
# 10/11/2018
# O codigo ira receber os 9 primeiros digitos e calcular os digitos verificadores e mostrar o CPF completo
#####################################################################################################################################
.data
		ID_digits: .word 3, 0, 1, 2, -6, -2, 4, 10, 3
		CPF_digits: .word 3, 0, 1, 2, -6, -2, 4, 10, 3, 0, 0
		Texto_ini: .asciiz "ID_digits: "
		TextoCPF: .asciiz "\nCPF_digits: "
		Imprime_traço: .asciiz "-"
	
.text
	
		li $s0,10		 # Colocando 2 em s0 para multiplicar os elementos do vetor
		
		li $s1,0      		 # Colocando indice zero para usar como contador no for
	
		li $t2,0        	 # Usaremos o $t2 para fazer o percorrimento indexado do array
	
		li $t3,9		 # Coloca em t3 o valor 9 para a condição de parada do for
	
		li $v0,4		 # Primeiro texto pedindo ao usuario que digite os numeros para o array
		la $a0,Texto_ini
		syscall
	
	#############################################################################################################################
	#Function: For_loop
	#Description: Ira preecher o vetor ID_digits e calcular a somatoria da multiplicaçao de cada elemento por i=10 e decrescendo ate i=2
	#InPut:Registers $s1=i,$t2=the inicial position(0) of the array,$t3=8
	#OutPut: $t4=somatoria da multiplicaçao dos elementos,ID_digits:Vetor preenchido
	#Return: :Sem retorno
	#############################################################################################################################
	
	#for(int i=0;i<=9;i++)
	For_loop:
		bge $s1,$t3,Fim_for	 # Condição de parada do for se 9<=i 
	
		li $v0,5		 # Le do teclado o numero que o usario colocou para o array
		syscall
	
		move $t5,$v0
	
		sw $t5, ID_digits($t2)   # t5 eh o valor que vai ser armazenado no array e ID_digits=endereço inicial e $t2 sera o indice que saltara de 4 em 4 porque eh inteiro
	
		mul $t0,$s0,$t5		 # Colocando em t0 a multiplicaçao do elem*i começando i=10
		add $t4,$t0,$t4	 	 # Acumulando em t4 a somatoria das multiplicações
		
		addi $s1,$s1,1           # Somando o contador para percorrer o array
		addi $t2,$t2,4		 # Somando ao t2 4 porque inteiro eh 4 bytes
		addi $s0,$s0,-1		 # Decrementando s0 para a multiplicaçao dos elementos
	
		j For_loop
	
	Fim_for:
		mul $t3,$t4,10		 # Multiplicando por 10 para achar o primeiro digito verificador
		div $t5,$t3,11		 # Divindo ele por 11 de acordo com o algoritmo e pegando o resto da divisao
		mfhi $t4		 # Pegando o resto da divisao
		
		#if($t4==10)$t4=0;
		beq $t4,10,restozero	 # Se o resto da div for 10 entao o digito eh zero(a partir dessa linha em t4 esta o primeiro digito verificador)
		j fimif
		
		restozero:
		li $t4,0
	fimif:
		
		#Preparando as variaveis para utilizar comando de repetiçao for
		
		move $t6,$t4		 # Salvando em t6 o digito verificador 1
		
		li $t4,0		 # Reiniciando t4 em zero
		
		li $s0,11		 # Colocando 2 em s0 para multiplicar os elementos do vetor
		
		li $s1,0      		 # Colocando indice zero para usar como contador no for
	
		li $t2,0        	 # Usaremos o $t2 para fazer o percorrimento indexado do array
	
		li $t3,9		 # Coloca em t3 o valor 9 para a condição de parada do for
		
		li $v0,4		 # Para mostrar na tela os numeros do vetor "ID_digits: "
		la $a0,Texto_ini
		syscall
	
	#############################################################################################################################
	#Function: For_loop2
	#Description: Ele ira aplicar a nova regra para calcular a somatoria das multiplicaçoes para o segundo digito de verificação e aproveitar e printar na tela o vetor ID_digits completo
	#InPut:Registers $s0=(11 e decrementa 1 a 1)elemento multiplicativo$s1=i,$t2=fara o percorrimento indexado,$t3=9
	#OutPut: $t4=somatoria da multiplicaçao dos elementos
	#Return: :Imprime na tela o vetor ID_digits
	#############################################################################################################################
	
		#for(int i=0;i<=9;i++)
	For_loop2:
		bge $s1,$t3,Fim_for2	 # Condição de parada do for se 9<=i 
	
		lw $t5, ID_digits($t2)   # t5 eh o valor que vai ser armazenado no array e ID_digits=endereço inicial e $t2 sera o indice que saltara de 4 em 4 porque eh inteiro
	
		li $v0,1     		 # Imprime a sequencia de numeros digitado pelo usuario
	  	move $a0,$t5
	  	syscall
		
		mul $t0,$s0,$t5		 # Colocando em t0 a multiplicaçao do elem*i começando i=11
		add $t4,$t0,$t4	 	 # Acumulando em t4 a somatoria das multiplicações
		
		addi $s1,$s1,1           # Somando o contador para percorrer o array
		addi $t2,$t2,4		 # Somando ao t2 4 porque inteiro eh 4 bytes
		addi $s0,$s0,-1		 # Decrementando s0 para a multiplicaçao dos elementos
	
		j For_loop2
	
	Fim_for2:
		
		mul $t0,$t6,2		 
		add $t4,$t4,$t0		 # Finalizando a soma incluindo o digito verificador
		
		mul $t0,$t4,10		 # Multiplicando a somatoria por 10
		div $t0,$t0,11
		mfhi $t7		 #Guardando em t7 o segundo digito verificador
		
		#if($t7==10)$t7=0;
		beq $t7,10,restozero2
		j fimif2	
		restozero2:
		li $t7,0
		
	fimif2:
		#Preparando variaveis para utilizar um comando de repetição for
		
		li $s1,0      		 # Colocando indice zero para usar como contador no for
	
		li $t2,0        	 # Usaremos o $t2 para fazer o percorrimento indexado do array
	
		li $t3,9		 # Coloca em t3 o valor 9 para a condição de parada do for
		
	#############################################################################################################################
	#Function: For_loop3
	#Description: Ele ira salvar em CPF_digits todos os 9 numeros digitados
	#InPut:Registers $s1=i,$t2=fara o percorrimento indexado,$t3=9
	#OutPut: NULL
	#Return: :CPF_digits quase preenchido(faltando os dois digitos verificadores)
	#############################################################################################################################
		
		#for(int i=0;i<=9;i++)
	For_loop3:
		bge $s1,$t3,Fim_for3	 # Condição de parada do for se 9>=i 
		
		lw $t5, ID_digits($t2)	 # Pegando os valores de ID_digits para colocar no array CPF_digits
		sw $t5, CPF_digits($t2)  # t5 eh o valor que vai ser armazenado no array e ID_digits=endereço inicial e $t2 sera o indice que saltara de 4 em 4 porque eh inteiro
	
		addi $s1,$s1,1           # Somando o contador para percorrer o array
		addi $t2,$t2,4		 # Somando ao t2 4 porque inteiro eh 4 bytes
		
	
		j For_loop3
	
	Fim_for3:
		
		sw $t6,CPF_digits($t2)	# Salvando no array primeiro digito de confirmação
		addi $t2,$t2,4		# Indo para a proxima posição
		sw $t7,CPF_digits($t2)	# Salvando no array segundo digito de confirmação
		
		#Preparando o ultimo comando de repetiçao for para poder imprimir o vetor CPF_digits por completo
		
		li $s1,0      		 # Colocando indice zero para usar como contador no for
	
		li $t2,0        	 # Usaremos o $t2 para fazer o percorrimento indexado do array
	
		li $t3,11		 # Coloca em t3 o valor 11 para a condição de parada do for
		
		li $v0,4		 #Imprime texto: CPF_digits:
 		la $a0,TextoCPF
 		syscall
		
	#############################################################################################################################
	#Function: For_loop4
	#Description: Ele ira imprimir o vetor CPF_digits completo
	#InPut:Registers $s1=i,$t2=fara o percorrimento indexado,$t3=11
	#OutPut: NULL
	#Return: :Imprime o vetor CPF_digits completo
	#############################################################################################################################
		
		#for(int i=0;i<=9;i++)
	For_loop4:
		bge $s1,$t3,Fim_for4	 # Condição de parada do for se 11<=i 
		
		#if(i==9)printf("-");
		beq $s1,9,imprimetraço	 # Imprime traço para separar os 9 digitos dos 2 digitos verificadores
		j fimif3
		imprimetraço:
		li $v0,4    		 # Imprime traço
	  	la $a0,Imprime_traço
	  	syscall
	  	
		fimif3:
		
		lw $t5, CPF_digits($t2)	 # Pegando os valores de ID_digits para colocar no array CPF_digits
		
		li $v0,1    		 # Imprime a sequencia do CPF completo
	  	move $a0,$t5
	  	syscall
	
		addi $s1,$s1,1           # Somando o contador para percorrer o array
		addi $t2,$t2,4		 # Somando ao t2 4 porque inteiro eh 4 bytes
		
	
		j For_loop4
	
	Fim_for4:	
	  	
		#Encerra o programa
		li $v0, 10
		syscall	
	
	#------------------------------------------------------------------------------------------------------------------