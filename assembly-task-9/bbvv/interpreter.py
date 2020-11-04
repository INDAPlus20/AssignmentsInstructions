"""
    This code is of a basic interpreter for the made up language
    bbvv, which is a simple 8-bit version of assembly

    Author: Tobias Hansson <Tohanss@kth.se>
"""
import pathlib
import sys
import collections

# Our assembly language has 4 registers
registers = [0, 0, 0, 0]

# 3 lists containing the different types of instructions we allow
r_type = ["add", "sub", "set", "jeq"]
j_type = ["j"]
spec_type = ["input", "print", "exit"]

"""
    Parses a file containing code formatted as
    a single string into instructions and remove comments

    Args:
        file: The relative path to a code file
    Returns:
        A list of strings where each string is a processor instruction
"""
def read_instruction(file: pathlib.Path) -> [str]:
    # Create a list with one element for each line of code
    lines = file.read_text().split("\n")
    instructions = []
    # For each line, remove comments and trailing whitespace
    for line in lines:
        end_index = len(line) if line.find("//") == -1 else line.find("//")
        instructions.append(line[0:end_index].strip())
    return instructions


# Read from stdio into #1, per specification
def read_input():
    registers[1] = int(input())


# Print content of register #1, per specification
def println():
    print(f"{registers[1]}\n")


"""
    Reads a r_type instruction and gives usefull values,
    reduces code duplication

    Args:
        current_inst: The current instruction as a formatted string
    Returns:
        reg1: the integer value representing register #1
        reg2: the integer value representing register #2
        imm:: the immidiate value 0 or 1
"""
def parse_r_type(current_inst):
    reg1 = int(current_inst[1].strip("#"))
    reg2 = int(current_inst[2].strip("#"))
    imm = int(current_inst[3])
    return reg1, reg2, imm


"""
    Confirms that the code does not contain any syntax errors.

    Args:
        instructions: A list of instructions represented
            as properly formatted strings
    Returns:
        1 if instructions are valid, else 0 if valid.
"""
def valid_instructions(instructions: [str]):
    error = 0
    for index, line in enumerate(instructions, 1):
        parts = line.split(" ")
        if parts[0] in r_type:
            if len(parts) != 4:
                print(
                    f"\tError on line {index}: Incorrect instruction of length {len(parts)}"
                )
                error = 1
            else:
                for x in [1, 2]:
                    if parts[x][0] not in "#":
                        print(
                            f"\tError on line {index}: Missing '#' to mark register register"
                        )
                        error = 1
                if parts[1][1] not in ["1", "2", "3"]:
                    print(
                        f"\tError on line {index}: {parts[1][1]} cannot be used as first register argument for r_type instructions"
                    )
                    error = 1
                if parts[3] not in ["0", "1"]:
                    print(
                        f"\tError on line {index}: invalid immidiate. Can only be a 1 bit value"
                    )
                    error = 1
        elif parts[0] in j_type:
            if len(parts) != 2:
                print(
                    f"\tError on line {index}: Incorrect instruction of length {len(parts)}"
                )
                error = 1
            if int(parts[1]) > 15 or int(parts[1]) < -16:
                print(
                    f"\tError on line {index}: {parts[1]} does not fit in a 5 bit (signed) value"
                )
                error = 1
        elif parts[0] in spec_type:
            if len(parts) != 1:
                print(
                    f"\tError on line {index}: Incorrect instruction of length {len(parts)}"
                )
                error = 1
        else:
            if parts[0] != "":
                print(f"\tError on line {index}: unknown command: {parts[0]}")
                error = 1
    return error


"""
    The acutal parsing algorithm. Does something for each line of code.

    Args:
        instructions: List of properly formatted cpu instructions
"""
def parse_instructions(instructions: [str]):
    index = 0
    while index < len(instructions):
        current_inst = instructions[index].split(" ")
        instruction = current_inst[0]
        if instruction == "input":
            read_input()
        elif instruction == "exit":
            break
        elif instruction == "print":
            println()
        elif instruction == "add":
            reg1, reg2, imm = parse_r_type(current_inst)
            registers[reg1] = registers[reg1] + registers[reg2] + imm
        elif instruction == "sub":
            reg1, reg2, imm = parse_r_type(current_inst)
            registers[reg1] = registers[reg1] - registers[reg2] - imm
        elif instruction == "set":
            reg1, reg2, imm = parse_r_type(current_inst)
            registers[reg1] = registers[reg2] + imm
        elif instruction == "j":
            index += int(current_inst[1])
        elif instruction == "jeq":
            reg1, reg2, imm = parse_r_type(current_inst)
            # jeq increments the PC by imm if the compared registers are equal
            # otherwise it increment the the PC with ~PC, i.e it does the opposite.
            if registers[reg1] == registers[reg2]:
                index += imm
            else:
                index += 1 if imm == 0 else 0
        # Always increment PC after each instruction (even if a jump is made)
        index += 1


def main():
    # Check that the proper amount of Command Line Arguments (CLA) are given
    if len(sys.argv) != 2:
        print(
            "\tIncorrect arguemts, command should be\n\t'python3 interpreter.py <filename>'"
        )
    else:
        file = pathlib.Path(str(sys.argv[1]))
        # Make sure the the given file path is a file that exists
        if file.is_file():
            # Make sure the file has the proper prefix.
            if file.suffix != ".bbvv":
                print(f"\tGiven file is not of type .bbvv")
            else:
                instructions = read_instruction(file)
                if not valid_instructions(instructions):
                    parse_instructions(instructions)
        else:
            print(f"\tFile: {file} does not exist")


# Python stuff.
if __name__ == "__main__":
    main()
