/***
 * Template to a Kattis solution.
 * See: https://open.kattis.com/help/c
 * Author: Viola Söderlund <violaso@kth.se>
 */

#include <stdio.h>                  // standard input/output library

/// Kattis calls main function to run your solution
int main()
{
    int x;
    float y; 
    char text[15];
    
    /**
     * Assuming a numeric or character format type:
     * 
     * Reads data from standard input until hitting a whitespace character
     * (whitespace, tab, line break, page break, etc), and then tries to
     * convert it to the specified type.
     * 
     * Parsing error will produce a garbage result. Welcome to C.
     * 
     * see: https://www.dummies.com/programming/c/basics-of-the-scanf-function-in-c-programming/
     */
    scanf("%d", &x);                // parse input as integer

    // Equal to `scanf("%d %f", &x, &y);`.
    scanf("%d%f", &x, &y);          // parse input as an integer followed by a floating point value

    // Reads as many characters as the string can hold. And yes, character arrays are the strings of C.
    scanf("%s", text);              // parse input as a character array (string)

    /**
     * fprintf writes to specified stream, in this case to standard error output.
     * 
     * see: https://www.tutorialspoint.com/c_standard_library/c_function_fprintf.htm
     */
    fprintf(stderr, "%d\n", x);     // Kattis does not read this

    /**
     * Print to standard output. Don't forget to add a line break when needed.
     */
    printf("%d\n", x);              // Kattis does read this
}
