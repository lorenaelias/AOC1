##################################
# Must enable memory-mapped I/O! #
##################################


################
# Handler Data #
################

	.kdata
ktemp:	.space 8
timer:	.asciiz "timer expired... and reset\n"


##########################
# Handler Implementation #
##########################

	# Overwrites existing handler defined in exceptions.s
	.ktext 0x80000180
	.set noat
	move $k0, $at
	.set at

	la $k1, ktemp
	sw $a0, 0($k1)
	sw $v0, 4($k1)

	mfc0 $a0, $13  # Cause
	andi $v0, $a0, 0x7C  # Cause bits [6:2]
	beq $v0, $zero, e_int
	# Program exception

	# skip offending instruction

	mfc0 $v0, $14  # EPC
	addiu $v0, $v0, 4
	mtc0 $v0, $14  # EPC

	j e_int_end
e_int:	# hardware interrupt

	mfc0 $v0, $13  # Cause
	andi $v0, $v0, 0x8000
	beq $v0, $zero, e_int_timer_end
	# timer interrupt

	# reset timer
	mtc0 $zero, $9  # Count

	# can't use syscall in a real exception handler!
	la $a0, timer
	li $v0, 4  # print_string
	syscall

e_int_timer_end:

e_int_end:

	lw $a0, 0($k1)
	lw $v0, 4($k1)

	.set noat
	move $at, $k0
	.set at
	mtc0 $zero, $13  # Cause
	mfc0 $k0, $12  # Status
	ori $k0, 0x01
	mtc0 $k0, $12  # Status
	eret


#######################
# Program Entry Point #
#######################

	.text
	.globl main
main:
	mfc0 $t0, $12  # Status
	ori $t0, 0x01  # interrupts enable
	mtc0 $t0, $12  # Status

	li $t0, 100
	mtc0 $t0, $11  # Compare = 100
	mtc0 $zero, $9  # Count = 0


	# divide by zero
	div $t0, $t0, $zero

	# arithmetic overflow
	li $t1, 0x7fffffff
	addi $t1, $t1, 1

	# non-existent memory address -- bus error
	sw $t2, 124($zero)

	# non-aligned address -- address error
	sw $t2, 125($zero)


	#.word 0xdeadbeef      # illegal instruction (crashes SPIM!)

forever:
	j forever



