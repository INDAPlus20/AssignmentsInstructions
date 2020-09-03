# DD1337 Week 2

## Getting started

### Install Rust

1) Install [Rustup](https://rustup.rs/).
2) _If you're running Windows_, install [Visual Studio C++ Build Tools](https://visualstudio.microsoft.com/visual-cpp-build-tools/).
3) Install the Rust build tool and package manager [Cargo](https://doc.rust-lang.org/cargo/getting-started/installation.html). Alternativly, _if you're developing in Visual Studio Code_, install the [Rust support extension](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust).

### Set up your repository

Your first assignment is turned in by uploading your code to the repository created for that assignment under the `INDAPlus20` organisation. 

The grade to an assigment is left in the form of an issue with "Pass", "Komplettering", or "Fail" in the title. In case of "Komplettering", read the instructions on what to adjust down in the issue description. Leave a comment on the issue upon reupload of the assignment. "Pass" and "Fail" are self explanatory. 

1) Install [Git](https://git-scm.com/downloads).
2) Creating a repository called `<your_name>-task-2` under the `INDAPlus20` organization.
3) Clone your assigment repository.
`git clone git@github.com:INDAPlus20/<your_name>-task-2.git`

### Prepare for your assigment

Your assinments are sorted into seperate repositories under the `INDAPlus20` organization. Create a repository for this week's assignment named according to the instructions above. In this repository you are going to create several Rust crates (term for applications or libraries).

#### How to create a Rust application (_binary_) crate

1) Navigate in your terminal or command prompt to `<your_name>-task-2`.
2) Create a new directory with an appropriate name.
3) Navigate into your newly created root directory.
4) Initialise your Rust crate.
`cargo init`
5) Build and run your application.
`cargo run`

Your clean build looks like:
```
appropriate_name
|- Cargo.toml
|- src
  |- main.rs
```

Write your source code in `src`, where the `main` function is located in `src/main.rs`. To make it easier, begin by copying the contents of `./kattis_template/src/main.rs` into your `main.rs` file.

## Assignment

### Kattis problems

This week, you're going to learn the basics of Rust by solving [Kattis](https://kth.kattis.com) problems. For each problem, create one Rust crate in `<your_name>-task-1`.

Solve at least two of the following problems:
- [Summera tal](https://kth.kattis.com/problems/kth.javap.sumsort)
- [Avstånd till kanten](https://kth.kattis.com/problems/kth.javap.kant)
- [Cyber-Clara och anmälningslistorna](https://kth.kattis.com/problems/kth.grupdat.anmalningslistorna)

_(optional)_ Solve the following problem:
- [A Different Problem](https://kth.kattis.com/problems/different)

_(optional challenge)_ A example solution to the Kattis problem [Minimal Scalar Product](https://open.kattis.com/problems/minimumscalar) can be found in `./minimal_scalar_product`. This solution runs at 0.06s. See the [statistics](https://open.kattis.com/problems/minimumscalar/statistics) for the Rust language. As you can see, it's possible to solve this problem in much less time. Write your own solution, which may be based on the example solution, and which runs quicker than 0.06s.

### Questions

#### Method chaining

Observe the following code:

```rust
let input = io::stdin();

let mut lines = input
    .lock()
    .lines()
    .map(|_line| _line.ok().unwrap().to_string());

// for every line, assuming input strings with the characters '0' and '1'

let binary_line = lines
    .next().unwrap()
    .split(" ")
    .map(|_title| {
        _title
            .chars()
            .map(|_character| {
                match _character {
                    '0' => false,
                    _ => true
                }
            })
            .collect::<Vec<bool>>()
    })
    .collect::<Vec<Vec<bool>>>();
```

Know the answer of the following question:
- What is the value of `binary_line`?

#### Iterables

Observe the following code:

```rust
use std::collections::{ HashMap, HashSet };

/*...*/

let limit: usize = 10;

let mut index_store: HashMap<usize, usize> = HashMap::with_capacity(limit + 1);
let mut value_store: Vec<HashSet<usize>> = Vec::with_capacity(limit + 1);
        
for _value in 1..(limit + 1) {
    index_store.insert(_value, _value - 1);

    let mut sequence: HashSet<usize> = HashSet::new();
    sequence.insert(_value);

    value_store.push(sequence);
}
```

Know the answer of the following questions:
- What is the value of `index_store`?
- What is the value of `value_store`?
