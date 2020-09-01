/***
 * Example solution to Kattis problem Minimal Scalar Product.
 * See: https://open.kattis.com/problems/minimumscalar
 * Author: Viola Söderlund <violaso@kth.se>
 */

use std::io;
use std::io::prelude::*;

fn main() {
    // get standard input stream
    let input = io::stdin();

    let mut lines = input
        .lock()                                                 // lock stream and produce readable buffer
        .lines()                                                // get vector where each element is a line from input
        .map(|_line| _line.ok().unwrap().to_string());          // for every line, assuming it is returned with no error and is not None, convert to string

    let number_of_cases = lines 
        .next().unwrap()                                        // get first line of input
        .parse::<u32>().unwrap();                               // assuming convertability, convert to unsigned integer

    eprintln!("\nNumber of cases: {}\n", number_of_cases);      // Kattis does not read this debug line

    for _case in 0..number_of_cases {

        // get length of the two following vectors
        let length = lines
            .next().unwrap()
            .parse::<usize>().unwrap();                         // usize = u64, as I am on a 64 bit machine

        let mut vector_1 = lines
            .next().unwrap()
            .split(" ")                                         // get list of vector components
            .map(|component| component.parse::<i64>().unwrap()) // for every component, assuming convertability, convert to signed integer
            .collect::<Vec<i64>>();                             // transform map iterable to vector iterable
        vector_1.sort();                                        // sort lowest to highest

        let mut vector_2 = lines
            .next().unwrap()
            .split(" ")
            .map(|component| component.parse::<i64>().unwrap())
            .collect::<Vec<i64>>();
        vector_2.sort();
        
        eprintln!("\nVector 1: {:?}", vector_1);
        eprintln!("Vector 2: {:?}\n", vector_2);

        // compute scalar product
        let mut scalar_product: i64 = 0;
        for _index in 0..length {
            scalar_product += vector_1[_index] * vector_2[length - 1 - _index];
        }

        eprintln!("Scalar product: {}\n", scalar_product);

        println!("Case #{}: {}", _case + 1, scalar_product);
    }
}