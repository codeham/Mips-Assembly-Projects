#Cristian Avina Lopez
#Lab 3 Pt. 2
#-->Palindrome Checker<--

		.data
mystring:		.space	100
prompt: 		.asciiz	"Enter a string: "
colons:			.asciiz	": "
isPalinmsg: 	.asciiz "Is a palindrome"
notPalinmsg:	.asciiz "Not a palindrome"

		.text
main:
		la $a0, prompt			#load prompt from memory into $a0
		li $v0, 4				#protocal for printing string
		syscall				
		la $a0, mystring		#address of mystring loaded (memory->temp.)
		li $v0, 8				#read string protocal
		li $a1, 40				#size of input coming in (40 char limit)
		syscall
		la, $t1, mystring		#load string A into register
		la ,$t2, mystring 		#load string B into register
lengthLoop:
		lb, $t3, ($t2)			#load the byte at B into register 
		beqz, $t3, endLoop		#when register reaches 0, branch to endloop
		addi	$t2, $t2, 1		#otherwise increment pointer 
		b lengthLoop			#branch to loop back
endLoop:
		subi $t2, $t2, 2		#decrement B by two, to skip over /n, and $zero
testLoop:
		bge $t1, $t2, isPalin	#if A >= B, -> It's a palindrome
		lb $t3, ($t1)			#load byte at addr A into $t3
		lb $t4, ($t2)			#load byte at addr B into $t4
		bne $t3, $t4, notPalin	#if $t3 != $t4, not a palindrome
		addi $t1, $t1, 1		#increment A by 1
		subi $t2, $t2, 1		#decrement B by 1
		b testLoop				#branch to repeat loop
isPalin:
		la $a0, isPalinmsg		#print palindrome message and exit
		li $v0, 4				#print string protocal
		syscall
		b exit					#branch to exit
notPalin:
		la $a0, notPalinmsg		#print != Palindrome message and exit
		li $v0, 4				#print string protocal
		syscall
		b exit					#branch to exit
exit:
		li $v0, 10				#exit protocal
		syscall
