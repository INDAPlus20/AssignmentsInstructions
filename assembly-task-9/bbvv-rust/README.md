# Bacon Borde Vara Vegetariskt Compiler

Language specifications are found in `../specifications.md`.

In addition, file sections `.text` and `.define` and define macros has been added to extend the language further. The intructions `input`, `print` and `exit` has been replaced by `cal`. See example program in `./multiply.bbvv`.

### `cal` - System Call

System call instructions have the encoding `op<7:5>,syscode<4:0>`. The function of this instruction is decided by the kernel of the implementing system in question, or in this case the emulator. 

However, the following should be implemented:
| **Code** | **Function** |
|:---------|:-------------|
| `1`      | Get integer value from standard input stream and store in `#1`. |
| `2`      | Write the value of `#1` to the standard output stream. |
| `3`      | Terminate program. |

### Define Macros

Define macros are declared in a BBVV file's define section (under `.define`). Macros are a way to define constant instructions in your files.