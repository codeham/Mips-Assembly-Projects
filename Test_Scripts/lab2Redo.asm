
#Write a program that reads (with an appropriate prompt) a sequence of 20  integers and stores them in an array, and then calls the following three  functions and prints the results in a readable format. The three functions are: 
#smallestLargest:  computes the smallest and the largest values in the array. 
#divisible: computes the number of integers in the array, which are divisible by 4. 
#SumProduct” computes the sum and the product of the integers.

	.data
array1:		.space 		20 			#(5 ints)
array2:		.space 		20			#(5ints)
prompt:		.asciiz 	"Enter 5 ints: "
prompt2:	.asciiz 	"Smallest number in array is: "
prompt3:	.asciiz 	"Greatest number in array is: "
prompt4: 	.asciiz		"Numbers divisible by 4 are: "
newLine:	.asciiz 	"\n"
space:		.asciiz 	" "



	.text
main:
	la $t0, array1		#load array
	li $t1, 5		#load counter 
readLoop:
	la $a0, prompt		#load prompt from mem. into register
	li $v0, 4		#print string
	syscall
	li $v0, 5		#read int
	syscall
	move $t2, $v0		#move read int to register
	sw $t2, ($t0)		#store word into array from register
	addi $t0, $t0, 4	#move pointer in array  
	addi $t1, $t1, -1	#decrement counter
	bgtz $t1, readLoop	#branch back if counter != 0
	la $t0, array1		#reload array
	li $t1, 5		#reload counter
	#Jump to function
	jal smallestLargest	#jump to smallestLarget function
	printSmallLarge:
		la $a0, prompt2		#load small number prompt
		li $v0, 4		#print string protocal
		syscall 
		move $a0, $t2		#move smallest int into $a0 register
		li $v0, 1		#protocal for printing int
		syscall
		la $a0, newLine		#move new line command in register
		li $v0, 4		#print string protocal
		syscall
		la $a0, prompt3		#load large number prompt
		li $v0, 4		#print string protocal
		syscall 
		move $a0, $t3		#move larger int into $a0 register
		li $v0, 1		#protocal for printing int
		syscall
		la $a0, newLine		#move new line command in register
		li $v0, 4		#print string protocal
		syscall
		#Reload
		la $a0, array1		#reload array to initial address
		li $t1, 5		#reload counter
	divby4Print:
		#Jump to function
		jal divis		#jump to divisible by 4 function
		la $a0, prompt4		#load div. by 4 prompt
		li $v0, 4		#string print protocal
		syscall
	loopPrint:
		beqz $t4, exit		#if counter is 0, jump to exit
		lw $a0, 0($t2)		#load word from array2 into reg.
		li $v0, 1		#print int protocal
		syscall
		la $a0, space		#load space
		li $v0, 4		#print string protocal
		syscall
		addi $t2, $t2, 4	#shift pointer in array2
		addi $t4, $t4, -1	#decrement counter
		b loopPrint		#branch back to loop
	exit:
		li $v0, 10
		syscall
# t0 - array
# t1 - counter
# t2 - least value
# t3 - greatest value 
# v0 - byte from array 
smallestLargest:
	lw $t2, 0($t0)		#load first word from array into register, (for greatest comparison)
	lw $t3, 0($t0)		#load first word from array into register, (for smallest comparison)
	addi $t0, $t0, 4 	#shift pointer for next int in array
	addi $t1, $t1, -1	#decrease couunter by 1, since we already have first value 
	b check
check:
	beqz $t1, retx			#branch if counter is equal to zero
		lw $v0, 0($t0)		#load from array in mem. to register 
		add $t0, $t0, 4		#shift array pointer
		add $t1, $t1, -1	#decrement counter
		ble $v0, $t2, smaller		#if smallTemp <= array[i]
		bge $v0, $t3, greater		#if greaterTemp >= array[i] 
		b check
retx:
	jr $ra			#jump register $ra

smaller:
	move $t2, $v0		#move contents of $v0 into temp register (smallest)
	b check			#loop back to the check loop
greater:
	move $t3, $v0		#move contents of $v0 into temp register (greatest)	
	b check			#loop back to check the loop
# $t0 - array1
# $t1 - counter (5)
# $t2 - array2
# $t3 - 4, used to divide
# $t4 - new counter for new array
# $v0 - loaded word from array
# $v1 - store high register containing remainder 
divis:
	#reset registers
	and $v0, $v0, $0
	and $t2, $t2, $0
	and $t3, $t3, $0
	
	la $t2, array2		#load address of second array into register
	li $t3, 4		#load constant 4 to use to divide 
	li $t4, 0		#set counter to 0 (for new array)
checkDiv:
	beqz $t1, retd		#if counter reaches 0, branch to return
	lw $v0, 0($t0)		#load word from array1
	div $v0, $t3		#divide by 4
	addi $t0, $t0, 4	#shift pointer of array1
	addi $t1, $t1, -1	#decrement counter
	mfhi $v1		#store remainder
	beqz $v1, storeValue	#if equal to 0, then that means divisible by 4
	b checkDiv
storeValue:
	sw $v0, 0($t2)		#store value in 2nd array
	addi $t2, $t2, 4	#move pointer to next open location
	addi $t4, $t4, 1	#increment counter
	b checkDiv
	
retd:
	jr $ra 			#return
	
	
	
	
	
	
	


		
		
		
		
	
	

	
	
	