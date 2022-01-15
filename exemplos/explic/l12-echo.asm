	.data
key:	.ascii "key: "
char:	.asciiz " \n"
	.text
	.globl main
main:
	jal getchar
	la $a0, char
	sb $v0, ($a0)
	la $a0, key
	jal print_string
	j main


getchar: # $v0: char
	lw $v0, 0xffff0000
	andi $v0, $v0, 0x01
	beq $v0, $zero, getchar
	lw $v0, 0xffff0004
	jr $ra


print_string: # $a0: string
	li $a1, 0xffff0000
	j ps_cond
ps_loop:
	lw $v0, 8($a1)
	andi $v0, $v0, 0x01
	beq $v0, $zero, ps_loop
	sw $t0, 12($a1)
ps_cond:
	lbu $t0, ($a0)
	addi $a0, $a0, 1
	bne $t0, $zero, ps_loop
	jr $ra

