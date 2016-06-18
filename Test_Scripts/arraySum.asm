#array sum
	.data
array: .space 20 			#allocate space in memory for the array, 20 bytes for 5 ints
newLine: .asciiz "\n" 			#used to start new line
prompt: .asciiz "\nEnter an integer: "
exit: .asciiz "\nSum of Array: "

	.text
main: 
	la $t0, array			#load address from memory to register
	li $t1, 5			#counter for loop
	li $v1, 0			#return value for sum of array
loopRead:
	la $a0, prompt			#load prompt from memory into register
	li $v0, 4			#protocal to print string 
	syscall
	li $v0, 5			#integer protocal
	syscall
	sw $v0, 0($t0)			#store in array addrr.
	addi $t0, $t0, 4		#shift pointer of array
	addi $t1, $t1, -1		#decrement counter
	bgtz $t1, loopRead		#if counter isn't 0, loop back
	la $t0, array			#reload array
	li $t1, 5			#reload counter
arraySum:
	beqz $t1, returnEnd
	lw $t2, 0($t0)			#load word from array
	add $v1, $v1, $t2		#add to value reg. as iteration cont.
	addi $t0, $t0, 4		#array pointer shift
	addi $t1, $t1, -1		#decrement counter
	j arraySum			#loop back
returnEnd:
	addi $a0, $v1, 0		#add value into register to print
	li $v0, 1
	syscall
	
	
	

	
	
