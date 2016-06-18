    .data
array:  .space  20 #5 ints
prompt: .asciiz "Enter 5 numbers: "
newline: .asciiz "\n"
kprompt: .asciiz "Enter number k: "
 
 
    .text
main:   li $t0, 5   		#load counter
    #li $t1, 0  		#holds number k
    la $a1, array 		#load address of array into register
    loopRead:
        la $a0, prompt		#load prompt
        li $v0, 4   		#print string
        syscall
        li $v0, 5   		#reading integer from prompt
        syscall
        sw $v0, 0($a1)  	#store int in array index
        addi $a1, $a1, 4 	#increment pointer
        addi $t0, $t0, -1 	#decrement counter
        bgtz $t0, loopRead
        la $a1, array 		#reload
        li $t0, 5 		#reload counter
    readK:
        la $a0, kprompt 	#load prompt for k int
        li $v0, 4
        syscall
        li $v0, 5
        syscall
        sw $v0, ($a2)
    returnK:
    	addi $t2, $0, 4
    	mul $a2, $a2, $t2
    	add $t3, $a1, $a2 #add to get offset
    	lw  $v0, 0($t3)
        #loopK:
	#CHECK THIS PART
	
        #beqz $t1, endk
           # addi $a1, $a1, 4	 	 #shift pointer
            #addi $t1, $t1, -1		 #decrement count
            #b loopK
        endk:
            jr $ra
