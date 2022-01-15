#####################################################################
#   	         Conjectura de Collatz Usando Pilha            	    #
#####################################################################
#			     UFU 2018 - 2                           #
#	    Arquitetura e Organização de Computadores 1             #
#  		 Lorena da Silva Elias 11721BCC019                  #
#                                                                   #
#	O programa lê o primeiro termo (N)>0 e calcula o resto da   #
# sequência de termos conforme a conjectura de Collatz. 	    #
#								    #
# Se N == 1, então chegamos ao final da sequência.                  #
# Senão, se N for par, então o próximo termo N1 = N / 2.            #
# Senão, se N for ímpar, então o próximo termo N1 = 3 * N + 1.      #
#####################################################################

.data  

primeiro:      	.asciiz "Primeiro termo: "
virgula:   	.asciiz ", "
listaTermos:    .asciiz "Lista de Termos: "
warning:        .asciiz "Insira um inteiro maior que zero\n"

.text
aviso:
    # printa a mensagem "warning"
    la $a0, warning
    addi $v0, $zero, 4
    syscall    
    
main:
    addi $t4,$zero,1
 
    # printa a mensagem "primeiro"
    la $a0, primeiro
    addi $v0, $zero, 4
    syscall

    # le um inteiro em $t0
    addi $v0, $zero, 5
    syscall
    move $t0, $v0
    
    sub $sp,$sp,8   # aloca espaço para 2 inteiro na pilha
    sw $t0,0($sp)     # salva $t0 na pilha
    sw $t4,4($sp)     # salva o $t4 para usar nos branches
 		
    # testa se a entrada foi um inteiro positivo
    beqz $t0, aviso
    
    # printa a mensagem listaTermos
    la $a0, listaTermos
    addi $v0, $zero, 4
    syscall
    
    # mostra o primeiro termo na tela
    move $a0, $t0
    li $v0,1
    syscall
    
    # entra em loop
    loop:
        la $t5,($ra)    # salva o endereço
        lw $t0,4($sp)   # coloca o valor da pilha em $t0
	lw $t1,0($sp)   # carrega o valor que foi salvo na pilha na pos 0 e coloca em $t1

        # pula para eq1, se N == 1
        addi $t1, $zero, 1
        beq  $t0, $t1, eq1

        # pula para "par", se N != 1
        addi $t1, $zero, 1
        bne  $t0, $t1, par
        
        eq1:
            addi $sp,$sp,8
	    # termina o programa
            li $v0,10   	  
	    syscall

        par:         
            lw $t0,0($sp) # coloca o valor da pilha em $t0
	    lw $t4,4($sp) # coloca o valor da pilha em $t4
	  	
            # pula para "impar" se nao for par
            andi $t1, $t0, 1
            bne  $t1, $zero, impar

            # printa virgula
            la $a0, virgula
            addi $v0, $zero, 4
            syscall

            # calcula N1 = N / 2
            div $t0, $t0, 2
            
            sw $t0,0($sp)          # salva $t0 na pilha
            
            # printa o numero atual
            move $a0, $t0
            addi $v0, $zero, 1
            syscall

	    # pula para loop
            j loop

        impar:
            lw $t0,0($sp) # coloca o valor da pilha em $t0
	    lw $t4,4($sp) # coloca o valor da pilha em $t4
 		
            # calcula N1 = 3 * N + 1
            addi $t1, $zero, 3
            mul  $t0, $t0, $t1
            addi $t0, $t0, 1

            # printa virgula
            la $a0, virgula
            addi $v0, $zero, 4
            syscall

            # printa numero atual
            move $a0, $t0
            addi $v0, $zero, 1
            syscall
            
            div $t0,$t1
	    sw $t0,0($sp)

	    # pula para loop
            j loop

jr $ra
