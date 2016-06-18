#Cristian Avina Lopez
#Lab 3 Pt. 1
# --> Character Frequency <--

		.data
		
mystring: 		.space		100
upperCase:		.space 		104
lowerCase:		.space 		104
Prompt:			.asciiz 	"Please enter a string: "
frequency:		.asciiz		"\n\tFrequency:\nLower Case:\t\tUpper Case:\n"	
Spacecount:		.asciiz		"\nThe number of spaces are: "
colons:			.asciiz		": "
tab:			.asciiz		"\t\t"
line:			.asciiz		"\n"
		
		.text
				
main:			
			la		$a0,	Prompt			#Prints prompt for string
			li 		$v0,	4
			syscall
			la 		$a0,	mystring		#read_string mem. address of string input buffer
			li 		$v0,	8			#Read string system protocal
			li 		$a1,	40			#Preserved space for mystring (40 char limit)
			syscall
			la		$a2, 	upperCase		
			la		$a3, 	lowerCase		
			li		$s0, 	65			# Hold the ascii decimal of A
			li		$s1, 	90			# Hold the ascii decimal of Z
			li		$s2, 	97			# Hold the ascii decimal of a
			li		$s3, 	122			# Hold the ascii decimal of z 
			li		$s4, 	32			# Hold the ascii decimal of space 
			li		$s5, 	4			# location identifier of the alphabet
			li  	$t0,	0				# Number of spaces
			
loopR:			
			lb		$t1,	0($a0)			#Loads byte from argument register
			addi 	$a0,	$a0, 1				#Shift pointer by one byte(one char)			
			beqz	$t1,	loopP				#if the loop hits an empty position '/0', branch 
			beq		$t1,	$s4, spacecase		#Check if it's a space character
			blt		$t1,	$s0, loopR		#Ignore if less than A
			ble		$t1,	$s1, upcase		#Branch to upcase if less than Z
			blt		$t1,	$s2, loopR		#Ignore if less than a
			ble		$t1,	$s3, lowcase		#Branch to lowcase if less than z
			b		loopR				#Branch to keep looping
			
spacecase:		
			addi	$t0,	$t0, 1				#Increment the count of spaces
			b		loopR				#Loop back branch

upcase:			
			sub		$t2,	$t1, $s0		#Get index of the letter
			mul		$t2,	$t2, $s5		#Get the correct byte value
			add		$a2,	$a2, $t2		#Move to the correct byte location
			lw		$t3,	0($a2)			#Get the current frequency of its letter
			addi	$t3,	$t3, 1				#Increment the frequency by 1
			sw 		$t3,	0($a2)			#Store back into the list
			la		$a2,	upperCase		#Reset the address to 0
			b		loopR				#Loop back branch

lowcase:		sub		$t2,	$t1, $s2		#Get index of the letter
			mul		$t2,	$t2, $s5		#Get the correct byte value
			add		$a3,	$a3, $t2		#Move to the correct byte location
			lw		$t3,	0($a3)			#Get the current frequency of its letter
			addi	$t3,	$t3, 1				#Increment the frequency by 1
			sw 		$t3,	0($a3)			#Store back into the list
			la		$a3,	lowerCase		#Reset the address to 0
			b		loopR				#Loop back branch
			
loopP:		
			la		$a0,	frequency		#Prints the frequency prompt
			li		$v0,	4			#Print string system protocal
			syscall
			li		$t4,	26			#Set counter for printing
			b		printing			#Branch to printing
			
printing:	
			beqz	$t4,	finish				#when counter hits 0 (from 26), branch to finish
			move	$a0,	$s2				#Prints lower case letter
			li		$v0,	11			#Print char system protocal
			syscall
			la		$a0,	colons			#Prints colons
			li		$v0,	4			#Print string system protocal
			syscall
			lw		$a0,	0($a3)			#Prints its frequency
			li		$v0,	1			#Print int system protocal
			syscall
			la		$a0,	tab			#Prints tab
			li		$v0,	4			#Print string system protocal
			syscall
			move	$a0,	$s0				#Prints upper case letter
			li		$v0,	11			#Print char system protocal
			syscall
			la		$a0,	colons			#Prints colons
			li		$v0,	4			#Print string system protocal
			syscall
			lw		$a0,	0($a2)			#Prints its frequency
			li		$v0,	1			#Print int system protocal 
			syscall
			la		$a0,	line			#Prints new line
			li		$v0,	4			#Print string system protocal
			syscall
			
			addi	$s2,	$s2, 1				#Move to next lowercase character
			addi	$a3,	$a3, 4				#Move to next frequency of lowercase
			addi	$s0,	$s0, 1				#Move to next uppercase character
			addi	$a2,	$a2, 4				#Move to next frequency of uppercase
			addi	$t4,	$t4,-1				#Decrease the counter
			b 		printing
			
finish:		
			la		$a0,	Spacecount		#Prints space prompt
			li		$v0,	4			#Print string system protocal
			syscall
			move	$a0,	$t0				#Prints # of spaces
			li		$v0,	1			#Print int system protocal
			syscall
			li		$v0,	10			#end program
			syscall

