import pathlib
import List

registers = [0, 0, 0, 0]

instructions = []

def read_instruction(file: pathlib.Path) -> [str]:
    return file.read_text().split("\n")

def read_input():
    registers[1] = int(input())

def println():
    print(f"{registers[1]}\n")

def parse_instructions(instructions: [str]):
    index = 0
    while(1):
        current_inst = instructions[index].split(" ")
        instruction = current_inst[0]
        if instruction == "input":
            read_input
        elif instruction == "exit":
            continue
        index += 1