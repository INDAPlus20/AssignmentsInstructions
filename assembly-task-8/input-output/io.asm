##################################################################
#
#   MIPS assembly code example
#   - I/O
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

### Executable Code Section ###

.text

# read integer
li $v0, 5                           # magic code to read integer
syscall                             # double is now in $f12

# calculate square of given double and place in a0
mul $a0, $v0, $v0                   # output = input * input

# print output
li $v0, 1                           # magic code to print integer
syscall                             # $a0 now printed

li $v0, 10                          # (10 == "Terminate Program")
syscall                             # exit program