	.data
string: .asciiz "Hat"
	.text
main:
	la $a1,string
	jal frequency
	add $a0, $s4, 0
	li $v0, 1
	syscall
	frequency:
		li $s1, 65	#A
		li $s2, 66	#B
		li $s3, 67	#C
		li $s4, 0	#counter for letter
		li $t0, 0	#counter for string
		b checkLength
	checkLength:
		lb $t1, ($a1)	#load byte
		beqz $t1, reload
		addi $a1, $a1, 1
		addi $t0, $t0, 1	
		b checkLength
		
	reload: la $a1, string	#reload
		b print
	print:
		lb $t2, 0($a1)
		addi $t0, $t0, -1	#decrement
		addi $a1, $a1, 1	#move pointer
		beq, $t2, $s1, count	#if equal to A
		beq, $t2, $s2, count	#if equal to B	
		beq, $t2, $s3, count	#if equal to C
		beqz $t0, return
		b print
	count:
		addi $s4, $s4, 1	#incrmenet counter
		b print
	return:
		#add $a0, $s4, 0		#load into register
		#li $v0, 1
		#syscall
		jr $ra
		
		
		
	
		