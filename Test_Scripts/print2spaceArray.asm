	.data
array: .word 		2,4,5,7,8,11,13,16,19,22	#declare array
space: .asciiz 		" " 				#space
newLine: .asciiz		"\n"				#newline
	.text
main:
	li $t0, 10		#counter for 10 ints
	li $t1, 2 		#counter for spaces
	la $t2, array		#load array from memory into register
printLoop:
	lw $a0, ($t2)		#load single word from array into register
	li $v0, 1		#print integer protocal
	syscall
	la $a0, space		#load space address
	li $v0, 4		#protocal for printing string
	syscall
	addi $t0, $t0, -1	#counter decrement
	beqz $t0, end		#check if all ints are printed
	addi $t1, $t1, -1	#decrement space counter
	addi $t2, $t2, 4	#
	
	addi $t2, $t2, 4	#shift pointer in array 
	
