#include <stdlib.h>

// Dont think about the above when writing assembly.

int multiply(int a, int b){
    int sum = 0;
    for (size_t i = 0; i < a; i++)
    {
        sum += b;
    }
    return sum;
}

int faculty(int a){
    int sum = 1;
    for (size_t i = 4; i > 0; i--)
    {
        sum *= i;
    } 
}