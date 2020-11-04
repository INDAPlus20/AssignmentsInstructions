Instruktioner är 8 bitar:

    Register type:
        - add target source immidiate:     
            - target = target + source + immidiate

        - sub target source imidiate:      
            - target = target - source - immidiate

        - set target source immidiate:     
            - target = source + immidiate
        
        - jeq  r1 r2 immidiate:              
            - Immidiate väljer om den ska hoppa eller inte, är det falskt gör den motsatta. 1 gör att den hoppar en rad

        3 bitar op
        2 bitar register1
        2 bitar register1
        1 bitar immidiate

    Jump type:
        - j address:                       
            3 bitar op
            5 bitar relativ adress ska kunna vara negativ
            - jumps a relative amount of lines in the code

    Special types:
        - input:                          
            - Kommandot input läser in ett tal till #1

        - print                           
            - Kommandot print printar ett tal från #1

        - exit                            
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