# void main(void) { // fatorial iterativo

#    int i,j;
	.data			# area de dados
vi:	.word 1			# aloca espaco para variaveis globais
vj:	.word 1			# apenas como exemplo...
n:	.word 			# n
str0:	.asciiz "n! = "	
str1:	.asciiz "n ? "	

	.text			# area de código
	.globl main		# define main como nome global
main:
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 5
	syscall
	sw $v0, n
	addi $s1, $v0, 1
	
#       j=1;
	addi $t1, $zero, 1
	
#       for(i=1; i <= n; i++)
	addi $t4, $zero, 1

for:	slt $t7,$t4,$s1		# i <= n    fat(n)
	beq $t7,$zero,fimfor

#       j = j*i;
	mult $t1,$t4
	mflo $t1

	addi $t4, $t4, 1

	j for

fimfor:	li $v0, 4		# imprime resposta
	la $a0, str0		# syscall(4) = imprime string
	syscall

	li $v0, 1		# imprime inteiro
	move $a0, $t1		# syscall(1) = imprime inteiro
	syscall
	
#    return(0);
	li $v0, 10		# termina programa
	syscall			# syscall(10) = termina programa
	
# }
