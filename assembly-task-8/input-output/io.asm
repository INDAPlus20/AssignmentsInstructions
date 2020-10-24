##################################################################
#
#   MIPS assembly code example
#   - I/O
#
#   Author: Tobias Hansson <tohans@kth.se>, Viola Söderlund <violaso@kth.se>
#
#   Last updated: 2020-10-24
#
#   See: MARS Syscall Sheet (https://courses.missouristate.edu/KenVollmar/mars/Help/SyscallHelp.html)
#   See: MIPS Instruction Sheet (file:///C:/Users/viola/Downloads/mips-ref-sheet-3.pdf)
#
##################################################################

### Data Declaration Section ###

.data                               

### Executable Code Section ###

.text

# get input
li $v0, 5                           # set system call code to "read integer"
syscall                             # read integer from standard input stream to $v0

# calculate output
mul $a0, $v0, $v0                   # $a0 = $v0 * $v0

# print output
li $v0, 1                           # set system call code to "print integer"
syscall                             # print square of input integer to output stream

li $v0, 10                          # (10 == "Terminate Program")
syscall                             # exit program