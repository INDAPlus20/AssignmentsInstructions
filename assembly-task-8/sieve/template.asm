##################################################################
#
#   Template for subassinment "Inbyggda System-mastern, h�r kommer jag!"
#
#   Author: Viola Söderlund <violaso@kth.se>
#
#   Created: 2020-10-24
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Instruction Sheet (https://www.kth.se/social/files/563c63c9f276547044e8695f/mips-ref-sheet.pdf)
#   See: Sieve of Eratosthenes (https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes)
#
##################################################################

### Data Declaration Section ###

.data

primes:		.space  1000	    # reserves a block of 1000 bytes in application memory
err_msg:	.asciiz "Invalid input! Expected integer n, where 1 < n < 1001.\n"

### Executable Code Section ###

.text

main:
    # get input
    li      $v0,5                   # set system call code to "read integer"
    syscall                         # read integer from standard input stream to $v0

    # validate input
    li 	    $t0,1001
    slt	    $t1,$v0,$t0		        # $t1 = input < 1001
    beq     $t1,$zero,invalid_input # if !(input < 1001), jump to invalid_input
    li	    $t0,1
    slt     $t2,$t0,$t0		        # $t1 = 1 < input
    beq     $t1,$zero,invalid_input # if !(1 < input), jump to invalid_input
    
    # initialise primes array
    la	    $t0,primes              # $s1 = address of the first element in the array
    li 	    $t1,999
    li 	    $t2,0
    li	    $t3,1
init_loop:
    sb	    $t3,($s1)               # primes[i] = 1
    addi    $t0,$t0,1               # increment pointer
    addi    $t2,$t2,1               # increment counter
    bne	    $t2,$t1,init_loop       # loop if counter != 999
    
    ### Continue implementation of Sieve of Eratosthenes ###

    ### Print nicely to output stream ###
    
    # exit program
    j       exit_program

invalid_input:
    # print error message
    li      $v0,4                   # set system call code "print string"
    la      $a0,err_msg             # load address of string err_msg into the system call argument registry
    syscall                         # print the message to standard output stream

exit_program:
    # exit program
    li $v0,10                       # set system call code to "terminate program"
    syscall                         # exit program