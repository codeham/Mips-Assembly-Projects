# int mySum ( int n, int k )
# if ( n == k )
#  return k;
# return n + mySum( n + 1, k )

.data
.text
main:
	li	$a0,	2
	li	$a1,	4
mySum:
	bne	$a0,	$a1,	recu	# if n != k, -> branch to recursion part
	move 	$v0,	$a1		# set contents of reg. $a1 to return reg.
	jr	$ra			# jump register to return address 
	
recu:
	sub	$sp,	$sp,	8	# allocate 8 bytes from memory stack
	sw	$ra,	0($sp)		# store return addrr. 
	sw	$a0,	4($sp)		# store number
	add	$a0,	$a0,	1	# ( n + 1 )
	jal	mySum			# jump and link to mySum
	lw	$a0,	4($sp)	
	add	$v0,	$v0,	$a0
	lw	$ra	0($sp)			
	add	$sp,	$sp,	8	# deallocate 8 bytes (add it back to memory stack)
	jr	$ra			