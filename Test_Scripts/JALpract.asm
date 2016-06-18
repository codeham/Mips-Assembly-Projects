	.data
str:	
	.asciiz		"Hello Amgio\n"

	.text
main:
	jal message	# jump and link to message, copies addrr. of next intstruction into $ra
	jal message
	li $v0, 10
	syscall
message:
	la $a0, str
	li $v0, 4
	syscall
	jr $ra		# jumps to the address in register $ra
