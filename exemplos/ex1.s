	.data
a: 	.word	
b: 	.word	
c: 	.word	
msg1:	.asciiz "digite a: "
msg2:	.asciiz "digite b: "
msg3:	.asciiz "c = "
	
	.text
	
#ler a
	li	$v0,4
	la	$a0,msg1
	syscall
	li	$v0,5
	syscall
	sw	$v0,a($zero)
	add	$t0,$zero,$v0
#ler b
	li	$v0,4
	la	$a0,msg2
	syscall
	li	$v0,5
	syscall
	sw	$v0,b($zero)
	add	$t1,$zero,$v0
	add	$t2,$t1,$t0
	sw	$t2,c($zero)
#imprimir c
	li	$v0,4
	la	$a0,msg3
	syscall
	li	$v0,1
	add	$a0,$t2,$zero
	syscall
	
#exit
	li	$v0,10
	syscall
			
