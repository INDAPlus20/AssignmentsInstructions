# DD1338 Week 15

## Data Structures

You think you know lists, but you don't (or maybe you do, who knows?). Prove it, in style.

![Data Propaganda](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.cs.dartmouth.edu%2F~tjp%2Fcs10%2Fbeautiful_code.jpg&f=1&nofb=1)

### Prepare for your assigment

1) Create a repository named `<KTH_ID>-task-15`.
2) Clone your newly created repository and start coding. 

To make your Kattis-experience easier, see `./kattis_template/src/main.rs`. If you're mot all förmodan using Java, make use of [this utility class](https://open.kattis.com/download/Kattio.java?1a0093=) to simplify input-output fast enough to satisfy the judge.

## Assignment

For this week you have two assignments:
1) Solve at least one Kattis problem, and
2) write a balanced tree structure.

### Kattis problems

This week, you're going to learn (or repeat) the basic data structures by solving at least one [Kattis](https://kth.kattis.com) problem. Include a screenshot of your Kattis submission to prove your solution. See `../rust-task-2/minimal_scalar_product` for a Rust Kattis solution example.

Solve at least one of the following problems:
- [Almost Union-Find](https://open.kattis.com/problems/almostunionfind)
- [I Can Guess the Data Structure!](https://open.kattis.com/problems/guessthedatastructure)

_(optional fun)_:
- [Fenwick Tree](https://open.kattis.com/problems/fenwick)
- [Kötid](https://po.kattis.com/problems/kotid)

_(optional challenge)_:
- Try to solve this _DD2350 Algoritmer, datastrukturer och komplexitet_ lab: [Maximalt flöde](https://kth.kattis.com/problems/oldkattis.adkmaxflow). A shorter description of the problem can be found [here](https://hackmd.io/@wlWoSpi1QOKOJMmh8GQ2OA/HkrD6vbGU). The problem forces you to analyse paths in a graph and allows you a taste of the next course level.

### Tree structure

In addition to your Kattis solution(s), you are required to write an implementation of a balanced tree structure. See [wikipedia](https://en.wikipedia.org/wiki/Self-balancing_binary_search_tree) for a list of implementation variations. Trees can be implemented for lots of purposes. It's up to you to decide what kind of tree you want to implement. To prove correctness, write tests for your tree class/structure. 

_(optional fun)_:
- Trees are often implemented for a specific use. For example are there tree representations of strings which are meant to optimise searches and slicing. Write an algoritm which showcases the brilliance of your tree!
- Write a sorting-, a search- or a slice algorithm for your tree.

### Questions

Be prepared to answer the following questions during the next övning.

#### Complexity

What is the time complexity of the insertion, look-up and deletion functions of non-balanced vs. balanced trees? Non-balanced trees have different best and worst case complexities, why?

#### Unusual data structures

Other than stacks, queues, lists and trees, there are graphs, maps, tables and more. Learn about a new (maybe unusual) data structure and its implementations. Be prepared to teach the group about it.
