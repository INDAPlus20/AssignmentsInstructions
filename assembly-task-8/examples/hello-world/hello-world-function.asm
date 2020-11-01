##################################################################
#
#   MIPS assembly code example
#   - Hello World as a global function (routine) with subroutine
#
#   Author: Tobias Hansson <tohans@kth.se>, Viola Söderlund <violaso@kth.se>
#
#   Created: 2020-10-23
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Instruction Sheet (https://canvas.kth.se/courses/20007/files/3004941/download?wrap=1)
#
##################################################################

##
# Push value to application stack.
# PARAM: Registry with value.
##
.macro	PUSH (%reg)
	addi	$sp,$sp,-4              # decrement stack pointer (stack builds "downwards" in memory)
	sw	    %reg,0($sp)             # save value to stack
.end_macro

##
# Pop value from application stack.
# PARAM: Registry which to save value to.
##
.macro	POP (%reg)
	lw	    %reg,0($sp)             # load value from stack to given registry
	addi	$sp,$sp,4               # increment stack pointer (stack builds "downwards" in memory)
.end_macro

### Data Declaration Section ###

.data
HW:     .asciiz "Hello World\n"     # define label HW as a constant string "Hello World\n"

### Executable Code Section ###

.text
.globl hello_world                  # define label main as externally accessable 

##
#   Hello World routine
#   - print "Hello World\n" to output stream
##
hello_world:                        # function main starts here
    # manage saved regitries
    PUSH($s1)                       # save parent routine's saved value to stack
    move    $s1, $ra                # save return address

    # call print_hello_world subroutine
    jal		print_hello_world	    # jump to print_hello_world and save position to $ra
    nop

    # manage saved regitries
    POP($s1)                        # restore parent routine's saved value from stack
    move    $ra, $s1                # restore return adress

    # return
    jr      $ra                     # return to where main was called from
    nop

print_hello_world:
    # print HW
    li      $v0, 4                  # set syscall code "print string"
    la      $a0, HW                 # load address of string HW into syscall argument registry
    syscall                         # print "Hello World\n" to standard output stream

    # return
    jr      $ra                     # return to parent routine
    nop

##################################################################
#
#   NOTE:
#       Return address is saved so that subroutines within the 
#       hello_world routine can be called.
#
#       A word has the same size as a memory address, which for MIPS
#       is 4 bytes. Thereby the stack pointer jumps values by 4 bytes.
#
##################################################################
