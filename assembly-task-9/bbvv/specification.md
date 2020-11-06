# Bacon Borde Vara Vegetariskt Language Specification

## Instructions

| **Type** | **Encoding** |
|:---------|:-------------|
| Register | `op<7:5>, rs<4:3>, rt<2:1>, imm<0>` |
| Jump     | `op<7:5>, addr<4:0>` |
| Special  | `op<7:5>` |

### Register Instructions

| **Instruction** | **Description** |
|:----------------|:----------------|
| `add`           | `rt = rt + rs + imm` |
| `sub`           | `rt = rt - rs - imm`  |
| `set`           | `rt = rs + imm` |
| `jeq`           | Jump one line if `(rt == rs && imm) || (rt != rs && !imm)`. |

### Jump Instructions

| **Instruction** | **Description** |
|:----------------|:----------------|
| `j`             | Jump `addr` lines. |

### Special Instructions

| **Instruction** | **Description** |
|:----------------|:----------------|
| `input`         | Get integer value from standard input stream and store in `#1`. |
| `print`         | Write the value of `#1` to the standard output stream. |
| `exit`          | Terminate program. |

## Registers

    There are four registers, all of which can hold 32 bits of 
    data (integers). They are annotated by a so called brädgård (#)

    - #0    // always equals 0
    - #1    // handles I/O
    - #2                                    
    - #3
