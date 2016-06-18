#Cristian Avina Lopez
#CS 264

.data
array: .space 80	#allocate space in memory for the array, 80 bytes for 20 ints
var1: .word 1 		#variable used to store the counter from the user
newLine: .asciiz "\n" 	#used to start new line
Prompt: .asciiz "\nEnter an integer:"
PromptTwo: .asciiz "\nEnter an integer less than or equal to 20:"
.text
main: li $t0,20 		#register $t0 used to keep track of how many integers to be read
la $t1, array 			#loading starting address of the array
loopRead: la $a0, Prompt
	li $v0, 4
	syscall 		#reading out the prompt
	li $v0, 5
	syscall 		#reading in the integer
	sw $v0,0($t1) 		#storing the integer inside the array
	add $t0,$t0,-1 		#decrementing counter for the loop
	add $t1, $t1, 4 	#loading address of the next array area
	bgtz $t0, loopRead 	#branch loops 20 times for reading and storing(20)
	li $t0, 20 		#reload counter in order to reset for printing
	la $t1, array 		#reload array to start at the beginning
loopP: lw $a0,0($t1)
	li $v0,1 		#command for printing an integer
	syscall
	add $t0,$t0,-1 		#decrementing counter
	add $t1,$t1,4  		#loading next array address
	la $a0,newLine
	li $v0, 4
	syscall
	bgtz $t0,loopP 		#branch that loops 20 times for printing ints. inside array
	li $t0, 20 		#reload the counter
	la $t1,array 		#reload array to start at the beginning
loopReverse:
	lw $a0,76($t1)
	li $v0, 1
	syscall
	la $a0,32 		#system code for printing a space
	li $v0, 11
	syscall
	add $t0,$t0,-1
	sub $t1, $t1, 4
	bgtz $t0,loopReverse
	li $t0, 20 		#reload the counter
	la $t1,array 		#reload array to start at the beginning
loopPS:	 
	lw $a0,0($t1) 		#loading integer from memory location $a0
	li $v0,1
	syscall 		#printing an integer
	add $t0,$t0,-1 		#decrementing the count
	add $t1, $t1, 4 	#loading next array address
	la $a0,32 		#system code for printing a space
	li $v0, 11
	syscall 		#print a space
	bgtz $t0,loopPS 	#loops 20 times for printing
	la $a0, PromptTwo 	#prints second available prompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall 		#takes in user input
	sw $v0, var1 		#stores inside local variable var1
	li $t0, 20 		#reload counter
	la $t1, array 		#reload the array
loopU: lb $t2, var1 		#loop stores user's variable as a counter
loopEnd: beq $t0, 0, next 	#loop that makes sure that ends the loop if we print out 20 ints.
loopPNPL: lw $a0, 0($t1) 	#loop that is used to print the 20 ints
	li $v0, 1
	syscall #print out ints
	add $t0,$t0,-1 		#decrement the counter for 20 ints
	add $t1,$t1,4 		#change array address to the next one
	add $t2, $t2, -1 	#decrement counter for integers per line
	la $a0, 32
	li $v0, 11
	syscall 		#print space in between each integer
	bgtz $t2, next 		#branch that checks if n integers were printed per line
	la $a0, newLine 	#if n ints were ptinted, we start a new line
	li $v0, 4
	syscall
	b loopU 		#afterwards, branch back to loopU to reset the user's counter
next: bgtz $t0, loopPNPL 	#loop checks to see if all ints were printed
	exit:
	li $v0,10
	syscall 		#terminate

