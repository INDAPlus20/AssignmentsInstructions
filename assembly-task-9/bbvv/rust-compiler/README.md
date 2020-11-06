# Bacon Borde Vara Vegetariskt Compiler

Language specifications are found in `../specifications.md`. **Note** that changes has been made to the language in relation to this compiler.

File sections `.text` and `.define` and define macros has been added to extend the language further. The special intructions `input`, `print` and `exit` has been replaced by `cal`. See example program in `./multiply.bbvv`.

### `cal` - System Call

The system call instruction is of type jump instruction. The function of this instruction is decided by the kernel of the implementing system in question, or in this case by the emulator. 

However, at least the following should be implemented by the emulator:
| **Code** | **Function** |
|:---------|:-------------|
| `1`      | Get integer value from standard input stream and store in `#1`. |
| `2`      | Write the value of `#1` to the standard output stream. |
| `3`      | Terminate program. |

### Define Macros

Define macros are declared in a BBVV file's define section (under `.define`). Macros are a way to define constant instructions in your files. See example program.