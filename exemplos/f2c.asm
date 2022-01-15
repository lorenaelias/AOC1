#Cálculos com ponto flutuante
		.data
const5:		.float	5.0
const9:		.float	9.0
const32:	.float	32.0
fahr:		.float	18.0
	.text
	.globl f2c
f2c: 
	l.s $f16, const5		#$f16 = 5.0
	l.s $f18, const9		#$f18 = 9.0
	div.s $f16, $f16, $f18	#$f16 = $f16/$f18
	l.s $f18, const32		#$f18 = 32.0	
	sub.s $f18, $f12, $f18	#$f18 = $f12-$f18
	mul.s $f0, $f16, $f18	#$f0 = $f16*$f18
	jr $ra

	.globl __start
__start: 
	l.s $f12, fahr			# $f12 = 18.0
	jal f2c				# Chamada da subrotina
	li  $v0, 10			# Serviço 10 : Exit
	syscall
