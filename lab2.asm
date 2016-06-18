#Cristian Avina Lopez
#CS 264
		.data
		
array1:		.space		80
array2:		.space		80
Prompt:		.asciiz		"Enter 20 Integers.\n"
Prompt2:	.asciiz		"Enter an Integer: "
Prompt3:	.asciiz		"\nSmallest Number is "
Prompt4:	.asciiz		"Largest Number is "	
Prompt5:	.asciiz		"The number of integers divisible by 4 are:\n" 
space:		.asciiz		" "
line:		.asciiz		"\n"

		.text
		
main:			li  		$v0,	4 		#Display prompt for 20 integers
			la		$a0,	Prompt 		#Prints prompt message
			syscall
			la		$a1, array1		
			la		$a2, array2		
			li		$a3, 20 		#Assign counter to 20
			li		$t0, 20 		#Assign counter to 20
			
loopR:			
			la 		$a0, Prompt2 		#Prompt user to input numbers
			li 		$v0, 4       	
			syscall
			li 		$v0, 5
			syscall
			sw 		$v0, 0($a1)		#Store numbers into $a1
			add 	$t0,	$t0, -1  		#counter to check total 20 numbers
			add 	$a1,	$a1,4
			bgtz 	$t0,	loopR			#Continue to store numbers until 20 numbers are stored
			la		$a1,	array1		#Reset to the address 0 of array
			jal		smallestLargest		#Jump to the smallestlargest function
			move 	$t1,	$v0			#Get the smallest value from $v0
			li		$v0,	4			
			la 		$a0,	Prompt3		#Print prompt msg
			syscall
			li		$v0,	1
			move	$a0,	$t1			#Print the smallest number
			syscall
			li		$v0,	4
			la 		$a0,	line		#Separated by a new line
			syscall
			
			move 	$t2,	$v1			#Get the largest value from $v1
			li		$v0,	4
			la 		$a0,	Prompt4		#Print prompt msg
			syscall
			li		$v0,	1
			move	$a0,	$t2			#Print the largest number
			syscall
			li		$v0,	4
			la 		$a0,	line		#Separated by a new line
			syscall			
			li		$a3,	20		#Reset counter to 20
			la		$a1,	array1		#Reset to the address 0 of array
			jal		divis			#Jump to divisible by 4
			move	$t3		$v0		#Display prompt msg to show integers
			la 		$a0,	Prompt5 	#disvisible by 4
			li 		$v0,	4       	
			syscall
			
			la		$a2,	array2
			
loopP:		beqz	$t3,	finish				#Print Numbers divisible by 4
			lw		$a0,	0($a2)
			li		$v0,	1
			syscall
			li		$v0,	4
			la 		$a0,	space		#Print spaces in between each number
			syscall
			addi	$a2,	$a2,4
			addi	$t3,	$t3,-1
			b 		loopP
			
finish:		li		$v0,	10			#end program
			syscall
			
smallestLargest:
			lw		$v0,	0($a1)		#store 1st value into $v0
			lw		$v1,	0($a1)		#Store 1st value into $v1
			addi	$a1,	$a1,4			#Move to the next value in array
			addi	$a3,	$a3,-1			#Decrease counter to 19
			b		CHK
			
CHK:		beqz	$a3,	retx				#Check if counter is 0 to end
			lw $s1 0($a1)				#Store value from array into s1
			addi	$a1,	$a1,4			#Move onto next value in array
			addi	$a3,	$a3,-1			#Decrease counter down
			blt		$s1,	$v0, smaller 	#go to smaller if $s1 < $v0
			bgt		$s1,	$v1, larger	#go to larger if $s1 > $v1
			b 		CHK
			
smaller:	move	$v0,	$s1				#Make s1 the new smallest value
			b		CHK					#Stored in $v0
			
larger:		move	$v1,	$s1				#Make s1 the new smallest value
			b		CHK			#Stored in $v1
			
retx:		jr		$ra				#Return

divis:
			li		$v0,	0		#Initialize $v0 to 0
			li		$s2,	4		#Initialize $s2 to 4 for dividing
			b		CHKD
			
CHKD:		beqz	$a3,	retd				#Check if counter is equal to 0
			lw		$s3,	0($a1)		#Get value from array to $s3
			div		$s3,	$s2		#Divide value by 4
			addi	$a1,	$a1,4			#Move to next value of the array
			addi	$a3,	$a3,-1			#Decrease the counter
			mfhi	$t1				#Store the remainder into $t1
			beqz	$t1,	storeval		#If $t1 is 0, means it is divisible by 4, move to storeval
			b		CHKD
			
storeval:	
			sw		$s3,	0($a2)		#Store value into 2nd array
			addi	$a2,	$a2,4			#Move to next location of the array
			addi	$v0,	$v0,1			#Increase counter for # of values in array2
			b		CHKD

retd:		jr		$ra					#Return
