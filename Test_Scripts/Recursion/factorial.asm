.data
	num: .word 5
	ans: .word -1
	intMessage: .asciiz "Factorial Is: " 

.text
	main:
		lw $a0, num		# load number in argument 0
		jal fact		# jump and link to factorial function
		#sw $v0, ans
		move $t0, $v0
		la $a0, intMessage
		li $v0, 4
		syscall
		add $a0, $v0, $t0
		li $v0, 1
		syscall	
		j exit			# jump to exit to leave program
	fact:
		addu $sp, $sp, -8	# make space for two words on the stack ($ra, $s0) 
		# $ra - return addrr.
		# $s0 - local variable
		sw $ra, ($sp)		# store return address in stack (first 4 bytes)
		sw $s0, 4($sp)		# store local variable in stack (second 4 bytes)
		
		li $v0, 1		# store 1 into retun register
		beq $a0, $zero, done	# if argument reaches 0, then we are done
		# if condition above does not give a return or does not branch
		move $s0, $a0		# set the argument into local variable
		addi $a0, $a0, -1	# subtract 1 from argument function(n-1)
		jal fact		# do factorial again
		
		mul $v0, $s0, $v0	# multiply (at the end)
		
	done:
		lw $ra, ($sp)		# load first 4 bytes on the pointer to return addrr,
		lw $s0, 4($sp)		# load next 4 into variable
		addu $sp, $sp, 8	# decrease stack by 8
		jr $ra			# jump back to where we want to go
	exit:
		
	