Lösa två problem:

    - multiplicera tal
    - räkna fakultet


Instruktioner är 8 bitar:

    Register type:
        - add target source immidiate       // 000
            - target = target + source + immidiate

        - sub target source imidiate        // 001
            - target = target - source - immidiate

        - set target source immidiate       // 010
            - target = source + immidiate

            3 bitar op
            2 bitar register1
            2 bitar register1
            1 bitar immidiate

    Jump type:
        - j address                         // 011
            3 bitar op
            5 bitar relativ adress ska kunna vara negativ
            - jumps a relative amount of lines in the code

    Compare type:
        - jeq  r1 r2 avstånd                // 100
            3 bitar op
            2 bitar reg1
            2 bitar reg2
            1 bit avstånd:
                0 => 0 rader
                1 => 1 rad
            - Immidiate väljer om den ska hoppa eller inte, är det falskt gör den motsatta.

    Special types:
        - input:                            // 101
            - Kommandot input läser in ett tal till #1

        - print                             // 110
            - Kommandot print printar ett tal från #1

        - exit                              // 111
            - terminate program.


Registers:

    There are four registers, all of which can hold 32 bits of 
    data (integer) and they are annotated by a so called brädgård (#)

    - #0                                    // Always contains 0
    - #1                                    // Handles I/O
    - #2                                    
    - #3


Immidiate värden:

    - 0                                    // Add 0
    - 1                                    // Add 1