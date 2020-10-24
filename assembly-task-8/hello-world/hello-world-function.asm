##################################################################
#
#   MIPS assembly code example
#   - Hello World as global function
#
#   Author: Tobias Hansson <tohans@kth.se>, Viola Söderlund <violaso@kth.se>
#
#   Created: 2020-10-23
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Instruction Sheet (file:///C:/Users/viola/Downloads/mips-ref-sheet-3.pdf)
#
##################################################################

### Data Declaration Section ###

.data
HW:     .asciiz "Hello World\n"     # define label HW as a constant string "Hello World\n"

### Executable Code Section ###

.text
.globl hello_world                  # define label main as externally accessable 

hello_world:                        # function main starts here
    move    $s7, $ra                # save return address

    li      $v0, 4                  # set syscall code "print string"
    la      $a0, HW                 # load address of string HW into syscall argument registry
    syscall                         # print "Hello World\n" to standard output stream

    move    $ra, $s7                # restore return adress
    jr      $ra                     # return to where main was called from

##################################################################
#
#   NOTE:
#       Return address are saved, so that subroutines within the 
#       hello_world routine can be called. Since no jump instructions
#       are called within the hello_world routine, this is unnessecary.
#
##################################################################