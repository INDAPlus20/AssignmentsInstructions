##################################################################
#
#   MIPS assembly code example
#   - Hello World as application 
#
#   Author: Tobias Hansson <tohans@kth.se>
#
#   Created: 2020-10-23
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Instruction Sheet (file:///C:/Users/viola/Downloads/mips-ref-sheet-3.pdf)
#
##################################################################

### Data Declaration Section ###

.data                               
HW:     .asciiz "Hello World\n"     #define label HW as our hello world string

### Executable Code Section ###

.text

li      $v0, 4                      # magic code to print string
la      $a0, HW                     # load address of string HW into $a0
syscall                             # HW now printed

li $v0, 10                          # set system call code to "terminate program"
syscall                             # terminate program

##################################################################
#
#   NOTE:
#       Applications assembled and executed by MARS, or applications which terminate at EOF,
#       don't need the termination call. This termination call is therefore unnessecary.
#
##################################################################