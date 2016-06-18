#Cristian Avina Lopez
#Lab #6
		.data

array:		.space		20

promptA:	.asciiz		"Enter Integer: "

promptB:	.asciiz		"\nThe smallest integer in the array is: "

promptC:	.asciiz		"\nEnter values where n >= r and both n and r >= 0."

promptD:	.asciiz		"\nEnter value for n: "

promptE:	.asciiz 	"Enter value for r: "

promptF:	.asciiz		"\nThe combination value is: "

		.text

		

main:
	li	$t0,	5		#counter for elements
	la	$t1,	array	

storeLoop:
	la	$t0,	promptA
	li	$v0,	4	
	syscall
	li	$v0,	5		#read in integers from user
	syscall
	sw	$v0,	0($t1)		#store user input in array
	addi	$t0,	$t0,	-1	#decrement counter
	addi	$t1,	$t1,	4	#move next 4 bytes of array
	bgtz	$t0,	storeLoop	#keep storing until hits 0
	
	la	$a0,	array		#load array into argument register
	li 	$a1,	0		#load with 0, starting index
	li	$a2, 	4		#load with 4, last index
	
	jal getMin			#call getMin function
	
	move	$a1,	$v0		#store result into reg. $a1
	
	la	$a0,	promptB		#load prompt for smallest value
	li 	$v0, 	4
	syscall
	
	move	$a0,	$a1		#move result into $a0, to be printed
	li	$v0, 	1
	syscall
	
	
	
	
###################################################################################
#---> Recursive function that computes smallest number in a given array	<---
	# getMin($a0, $a1, $a2) 
	# $a0 - int[] A
	# $a1 = 0 - low 
	# $a2 = 4 - high
	
getMin:
	bne	$a1,	$a2,	recu	#if low != high, branch
	li	$t0,	4
	mul	$t1,	$a1, 	$t0	#low * 4 to get correct index
	add	$t1,	$a0, 	$t1	#Get correct location
	lw	$v0,	0($t1)		#Store A[low] value into $v0
	jr		$ra



recu:		
	addiu		$sp,	$sp, -16
	li		$t3,	2			
	sw		$ra,	0($sp)
	sw		$a2,	4($sp)		#push high in stack
	add		$t2,	$a1, $a2	#$t2 = low + high
	div		$t2,	$t2, $t3	#$t2/2 holds mid
	move		$a2,	$t2		#store mid into $a2
	addiu		$t4,	$t2, 1 		#$t4 = mid + 1
	sw		$t4,	8($sp)		#push $t4 in stack
	jal		getMin
	sw		$v0,	12($sp)		#push min1 in stack
mina:		

			lw 		$a1,	8($sp)		#$a1 (low) = mid + 1

			lw 		$a2,	4($sp)		#$a2 (high) = high

			jal		getMin

			lw 		$t1		12($sp)		#$t1 = min1

			bgt		$t1,	$v0, fin	#if min1 < min2, min2 is already in $v0

			move	$v0,	$t1			#if min1 > min2, min1 is moved to $v0

			b 		fin



fin:			lw 		$ra,	0($sp)

			addiu	$sp,	$sp, 16

			jr		$ra

##########################################################################



#recursive function that compute the Comb(n,r) where n >=r and n,r>=0



			#$a0 = n, $a1 = r

getComb:	bne		$a0, 	$a1, chk	#Check if n != r

			li		$v0,	1			#If n = r, $v0 = 1

			jr		$ra

			

chk:		bnez	$a1,	next		#Check if r = 0

			li 		$v0,	1			#if r = 0, $v0 = 1

			jr		$ra



next:		addiu	$sp,	$sp, -16	#Reserver space for stack

			sw		$ra,	0($sp)		

			sw		$a0		4($sp)		#push n in stack

			sw		$a1		8($sp)		#push r in stack

			addi 	$a0,	$a0, -1		#$a0 = n - 1

			jal		getComb

			sw		$v0,	12($sp)		#Store Comb(n-1,r) in stack

			lw 		$a0, 	4($sp)		#Get n

			lw 		$a1,	8($sp)		#Get r

			addi 	$a0,	$a0, -1			#$a0 = n - 1

			addi 	$a1,	$a1, -1			#$a1 = r - 1

			jal		getComb

			lw 		$t1,	12($sp)		#Store Comb(n-1, r) in $t1

			add 	$v0,	$v0, $t1		#Add $t1 with Comb(n-1, r-1)

			lw 		$ra,	0($sp)		

			addiu	$sp,	$sp, 16			#Restore stack

			jr		$ra

	
	
	
		
