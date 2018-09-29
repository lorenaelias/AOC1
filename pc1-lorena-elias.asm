# CALCULAR DIVISÃO INTEIRA E RESTO ENTRE DOIS NÚMEROS
# TERCEIRO SEMESTRE UFU 2018-2
# LORENA ELIAS - 11721BCC019

.data
	str1: .asciiz "Numerador: "
	str2: .asciiz "Denominador: "
	str3: .asciiz "Quociente: "
	str4: .asciiz "Resto: "
	endl: .asciiz "\n"
	warning: .asciiz "O denominador deve ser diferente de zero\n"

.text
label:	
	#Mostra uma mensagem para que o denominador inserido seja diferente de zero
	li $v0,4
	la $a0,warning
	syscall
	.globl main

main:
	#Imprime uma string str1
	li $v0,4  		   
	la $a0,str1
	syscall
	
	#Le inteiro do teclado
	li $v0,5  		   # le inteiro
	syscall			   
	move $t0,$v0	   	   # move o inteiro lido para $t0
	
	
	#Imprime uma string str2
 	li $v0,4  	 
	la $a0,str2
	syscall
	
	#Le inteiro do teclado
	li $v0,5  		   		 
	syscall
	move $t1,$v0
		
	#Pula linha
	li $v0,4  	
	la $a0,endl
	syscall
	
	#Caso o usuário digite zero no denominador
	beqz $t1,label
	
	#Imprime uma string str3
	li $v0,4  	
	la $a0,str3
	syscall
	
	div $t0,$t1	 	   #divisao inteira entre t0 e t1
	mflo $a0	  	   #armazena o quociente em $a0
	mfhi $a1 	           #armazena o resto em $a1
		
	#Mostra na tela o quociente
	li $v0,1	 	   #'printar' inteiro
	syscall
	
	#Pula linha
	li $v0,4  	
	la $a0,endl
	syscall
	
	#Imprime uma string str4
	li $v0,4  	
	la $a0,str4
	syscall
	
	move $a0,$a1		  #para 'printar' o que está em $a1 é preciso movê-lo para $a0
	
	#Mostra na tela o resto
	li $v0,1
	syscall