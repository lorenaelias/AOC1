#####################################################################
#   	       		Conjectura de Collatz            	    #
#####################################################################
#			     UFU 2018 - 2                           #
#	    Arquitetura e Organiza��o de Computadores 1             #
#  		 Lorena da Silva Elias 11721BCC019                  #
#                                                                   #
#	O programa l� o primeiro termo (N)>0 e calcula o resto da   #
# sequ�ncia de termos conforme a conjectura de Collatz. 	    #
#								    #
# Se N == 1, ent�o chegamos ao final da sequ�ncia.                  #
# Sen�o, se N for par, ent�o o pr�ximo termo N1 = N / 2.            #
# Sen�o, se N for �mpar, ent�o o pr�ximo termo N1 = 3 * N + 1.      #
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

    # printa a mensagem "primeiro"
    la $a0, primeiro
    addi $v0, $zero, 4
    syscall

    # le um inteiro em $t0
    addi $v0, $zero, 5
    syscall
    move $t0, $v0
    
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

        # pula para eq1, se N == 1
        addi $t1, $zero, 1
        beq  $t0, $t1, eq1

        # pula para "par", se N != 1
        addi $t1, $zero, 1
        bne  $t0, $t1, par

        eq1:
	    # termina o programa
            li $v0,10   	  
	    syscall

        par:
            # pula para "impar" se nao for par
            andi $t1, $t0, 1
            bne  $t1, $zero, impar

            # printa virgula
            la $a0, virgula
            addi $v0, $zero, 4
            syscall

            # calcula N1 = N / 2
            div $t0, $t0, 2
            
            # printa o numero atual
            move $a0, $t0
            addi $v0, $zero, 1
            syscall

	    # pula para loop
            j loop

        impar:

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

	    # pula para loop
            j loop

jr $ra
