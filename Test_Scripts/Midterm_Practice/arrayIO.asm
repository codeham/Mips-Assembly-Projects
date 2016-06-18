    .data
array:  .space  20 #5 ints
prompt: .asciiz "Enter 5 numbers: "
newline: .asciiz "\n"
 
 
    .text
main:   li $t0, 5   		#load counter
    la $a1, array 		#load address of array into register
    loopRead:
        la $a0, prompt 		#load prompt
        li $v0, 4   		#print string
        syscall
        li $v0, 5   		#reading integer from prompt
        syscall
        sw $v0, 0($a1)  	#store int in array index
        addi $a1, $a1, 4 	#increment pointer
        addi $t0, $t0, -1 	#decrement counter
        bgtz $t0, loopRead
        la $a1, array #reload
        li $t0, 5 #reload counter
    loopPrint:
        beqz $t0, function
        lw $a0, 0($a1)
        li $v0, 1
        syscall
        la $a0, newline
        li $v0, 4
        syscall
        addi $a1, $a1, 4
        addi $t0, $t0, -1
        b loopPrint
next:
    li $v0, 10
    syscall
