# DD1337 Week 8

## Getting started with MIPS

### Install MARS

1) Install Java, if you havn't done it already. Make sure that you have at least **Java 9**. 
2) [Download MARS](https://courses.missouristate.edu/KenVollmar/MARS/MARS_4_5_Aug2014/Mars4_5.jar) as a `.jar` file. This is the same application as you will use during *IS1500 Datorteknik och komponenter* next year.
3) Open MARS by running the `.jar` file, i.e. double click it.

### Prepare for your assigment

1) Create a repository named `<KTH_ID>-task-8`.
2) Clone your newly created repository.

## Assignments

This week you're going to complete two subassignments. The first assignment is to translate a program written in C to MIPS assembly, and the second one is to write a specified application in MIPS assembly.

See `./examples` for MIPS code examples.

### Higher level => Lower level

Learn what it means to be a compiler by translating C to MIPS assembly instructions. Your task is to write a file `./high-to-low/multiplication.asm`, which contains the same algorithms and logic as in `./high-to-low/multiplication.c`. To clarify: you may only use the `add` instruction, not `mul` (or similar).

### [Inbyggda System-mastern](https://www.kth.se/student/kurser/program/TEBSM/20212/arskurs1), här kommer jag!

Show that no one can write single-chip logic as royally as you do! Write an application, which takes one integer `1 < n <= 1000` as input and prints all prime numbers up to that integer. The prime number search algoritm must be an implementation of [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes). 

Place your solution file(s) inside the `./sieve` directory.

For help with code setup, begin by reviewing the contents of `./sieve/template.asm`.

### Questions

#### Constant declarations

With reference to `./sieve/template.asm`,

Know the answer to the following questions:
- Why do array declarations in fast languages, like Rust and C, require the given length to be of constant value?
- A single programming language can define strings in many different ways. For example, Rust has string literals and a String structure. What are the advantages of having both low- and high-level representations of strings? 

#### CPU optimisations

Observe the following pieces of code:
```
main:
    #...

    # exit program
    li $v0, 10                      # set system call code to "terminate program"
    syscall                         # terminate program

    #...
```
```
main:
    #...

    # exit program
    j  exit_program                 # jump to exit_program
    nop

#...

exit_program:
    # EOF
```

Know the answer to the following question:
- Which method of program termination is to prefer and why?
