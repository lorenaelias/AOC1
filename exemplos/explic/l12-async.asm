##################################
# Must enable memory-mapped I/O! #
##################################


################
# Handler Data #
################

	.kdata
ktemp:	.space 16
hex:	.ascii  "0123456789abcdef"  # table for quick hex conversion
exc:	.ascii  "\texception:"
spc:	.asciiz " "
timer:	.asciiz "\ttimer expired... and reset\n"
key:	.ascii  "\tkey: "
char:	.ascii  " "
nl:	.asciiz "\n"


##########################
# Handler Implementation #
##########################

	# Overwrites previous handler defined in exceptions.s
	.ktext 0x80000180
	.set noat
	move $k0, $at
	.set at

	la $k1, ktemp
	sw $a0, 0($k1)
	sw $a1, 4($k1)
	sw $v0, 8($k1)
	sw $ra, 12($k1)

	mfc0 $a0, $14  # EPC
	jal print_hex

	la $a0, spc
	jal print_string

	mfc0 $a0, $12  # Status
	jal print_hex

	la $a0, spc
	jal print_string

	mfc0 $a0, $13  # Cause
	jal print_hex

	la $a0, spc
	jal print_string

	mfc0 $a0, $9  # Count
	jal print_hex

	la $a0, nl
	jal print_string

	mfc0 $a0, $13  # Cause
	andi $v0, $a0, 0x7C  # Cause bits [6:2]
	beq $v0, $zero, e_int
	# Program exception

		la $a0, exc
		jal print_string

		mfc0 $a0, $13  # Cause
		srl $a0, $a0, 2
		andi $a0, $a0, 0x1f
		jal print_hex

		la $a0, nl
		jal print_string

		# skip offending instruction
		mfc0 $v0, $14  # EPC
		addiu $v0, $v0, 4
		mtc0 $v0, $14  # EPC

	j e_int_end
e_int:	# hardware interrupt

		mfc0 $a0, $13  # Cause
		andi $v0, $a0, 0x8000
		beq $v0, $zero, e_int_timer_end
		# timer interrupt

		xor $a0, $a0, $v0
		mtc0 $a0, $13  # Cause

		# reset timer
		mtc0 $zero, $9

		la $a0, timer
		jal print_string
e_int_timer_end:

		mfc0 $a0, $13  # Cause
		andi $v0, $a0, 0x0800
		beq $v0, $zero, e_int_keyrecv_end
		# keyboard receive interrupt

		xor $a0, $a0, $v0
		mtc0 $a0, $13  # Cause

		li $a0, 0xffff0000
		lw $v0, 4($a0)
		la $a0, char
		sb $v0, ($a0)

		la $a0, key
		jal print_string
e_int_keyrecv_end:

e_int_end:

	la $k1, ktemp
	lw $a0, 0($k1)
	lw $a1, 4($k1)
	lw $v0, 8($k1)
	lw $ra, 12($k1)

	.set noat
	move $at, $k0
	.set at
	mfc0 $k0, $12  # Status
	ori $k0, 0x01  # re-enable interrupts
	mtc0 $k0, $12  # Status
	eret


###############################
# print_string Implementation #
###############################

print_string: # $a0: string
	j ps_cond
ps_loop:
	lw $v0, 0xffff0008
	andi $v0, $v0, 0x01
	beq $v0, $zero, ps_loop
	sw $a1, 0xffff000c
ps_cond:
	lbu $a1, ($a0)
	addi $a0, $a0, 1
	bne $a1, $zero, ps_loop
	jr $ra


############################
# print_hex Implementation #
############################

print_hex: # $a0: int
	la $a1, hex
	li $v0, 28
ph_loop:
	lw $k1, 0xffff0008
	andi $k1, $k1, 0x01
	beq $k1, $zero, ph_loop

	srlv $k1, $a0, $v0
	andi $k1, $k1, 0x0f
	add $k1, $a1, $k1
	lbu $k1, ($k1)
	sw $k1, 0xffff000c

	addi $v0, $v0, -4
	bge $v0, $zero, ph_loop
	jr $ra


#######################
# Program Entry Point #
#######################

	.text
	.globl main
main:
	li $a0, 0xffff0000
	lw $t0, 0($a0)
	ori $t0, 0x02  # use keyboard interrupts
	sw $t0, 0($a0)

	mfc0 $t0, $12  # Status
	ori $t0, 0x01  # interrupts enable
	mtc0 $t0, $12  # Status

	li $t0, 200
	mtc0 $t0, $11   # Compare = 200
	mtc0 $zero, $9  # Count = 0

	# divide by zero
	div $t0, $t0, $zero

	li $t1, 0x7fffffff
	addi $t1, $t1, 1

	# illegal memory address
	sw $t2, 123($zero)

	#.word 0xdeadbeef      # illegal instruction (crashes SPIM!)

loop:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	j loop


