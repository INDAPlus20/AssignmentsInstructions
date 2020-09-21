/***
 * Example solution to Kattis problem Minimal Scalar Product.
 * See: https://open.kattis.com/problems/minimumscalar
 * Author: Viola Söderlund <violaso@kth.se>
 */

#include <stdio.h>                                              // standard input/output library
#include <stdlib.h>                                             // standard logic library (home to qsort)

/// Comparer function for number sorting.
int cmp_num (const void *a, const void *b) {
    // *(int*)a means cast the generic pointer a into an 
    // integer pointer and then fetch the value of which it 
    // points to.
    return *(int*)a - *(int*)b;                               
}

int main()
{
    int number_of_cases;
    scanf("%d", &number_of_cases);                               // format standard input as integer

    fprintf(stderr, "\nNumber of cases: %d\n", number_of_cases); // Kattis does not read this debug line

    for (int c = 0; c < number_of_cases; c++) {

        // get length of the two following vectors
        int length = 0;
        scanf("%d", &length); 

        int *vector_1 = malloc(length * sizeof(int));            // allocate heap memory for length number of integer elements
        for (int i = 0; i < length; i++) 
            scanf("%d", &vector_1[i]);                           // assign each element
        qsort(&vector_1[0], length, sizeof(int), cmp_num);       // sort the array using quick sort

        int *vector_2 = malloc(length * sizeof(int));                                    
        for (int i = 0; i < length; i++) {
            scanf("%d", &vector_2[i]);                            
            fprintf(stderr, "%d ", vector_2[i]);
        }
        qsort(&vector_2[0], length, sizeof(int), cmp_num);       

        // print vectors
        fprintf(stderr, "\nVector 1: ");
        for (int i = 0; i < length; i++) 
            fprintf(stderr, "%d ", vector_1[i]);
        fprintf(stderr, "\nVector 2: ");
        for (int i = 0; i < length; i++) 
            fprintf(stderr, "%d ", vector_2[i]);
        
        // compute scalar product
        long scalar_product = 0;
        for (int i = 0; i < length; i++)
            scalar_product += (long)vector_1[i] * (long)vector_2[length - 1 - i];

        fprintf(stderr, "\nScalar product: %ld\n", scalar_product);

        printf("Case #%d: %ld\n", c + 1, scalar_product);        // print to standard output

        free(vector_1);                                          // free allocated heap resources !important
        free(vector_2);
    }
}