# DD1338 Week 10

To kick _DD1338 Algiritmer och Datastrukturer_ off, let's write in a language that doesn't treat algorithms as a series of calculations, but as an iterative loop through a tree data structure -- hence algoritms and data structures.

## Getting started with Prolog

### SWI-Prolog

1) Install [SWI-Prolog](https://www.swi-prolog.org/). _As a pleb (Windows user), you are entitled to the SWI-prolog-command-prompt profile to add to your Windows Terminal settings. You're welcome._
```json
{
    "acrylicOpacity": 0.75,
    "closeOnExit": true,
    "commandline": "cmd.exe /c \"swipl\"",
    "guid": "{1597a4d0-b666-4b1f-a7d3-79af62638679}",
    "icon": "C:\\Program Files\\swipl\\swipl.ico",
    "name": "SWI-Prolog",
    "useAcrylic": true
}
```
2) Make sure that your environmental variable is set.

Congrats dear programmer. You can now compile and run your Prolog files by entering the following command.

_In your terminal/powershell_:
```
swipl path/to/my-file.pl
```
_In your SWI-Prolog environment_:
```prolog
['path/to/my-file.pl'].
```

### Prepare for your assigment

1) Create a repository named `<KTH_ID>-task-10`.
2) Clone your newly created repository.
3) Create one `.pl` file for the entire assignment.

For help with code setup, begin by copying the contents of `./template.pl` into your `.pl` file.

## Assignment

The following are prologified versions of the original subassignments.

### Populating Lists

Create the query `sequence(From, To, List)`, which finds the value of `List` to be a list of numbers of given range.

_i.e_:
```
1 ?- sequence(0, 5, List).
List = [0, 1, 2, 3, 4] .
```

### Shuffling Lists

Create the query `shuffled(InList, OutList)`, which finds the value of `OutList` to be a shuffled version of `InList`.

_i.e_:
```
1 ?- shuffled([0, 1, 2, 3], List).
List = [3, 0, 2, 1] .
```

_Suggestion_: Use [Fisher-Yates shuffle algorithm](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle).

### Summing Lists

Create the query `sum(List, Sum)`, which finds the value of `Sum` to be the sum of the numeric elements of a given list.

_i.e_:
```
1 ?- sum([2, 5, 3, 5], Sum).
Sum = 15 .
```

### _(optional)_ Sublists

Create the query `sublist(InList, OutList, Length)`, which finds the value of `OutList` to be a sublist of the input list of given length (given that `Length` is less than or equal to the length of `InList`). Observe that if `Length` is less than the length of `InList`, `OutList` will have more than one value.

_i.e_:
```
1 ?- sublist([2, 5, 3, 5], List, 2).
List = [2, 5] ;
List = [5, 3] ;
List = [3, 5] .
```

### _(optional)_ Sublists of index range

Create the query `sublist(InList, OutList, From, To)`, which finds the value of `OutList` to be a sublist of the input list of range `[From, To)`. 

_i.e_:
```
1 ?- sublist([2, 5, 3, 5], List, 1, 3).
List = [5, 3, 5] .
```

### _(optional)_ Subsets

Create the query `subset(InList, OutList, Length)`, which finds the value of `OutList` to be a subset of the input list of given length (given that `Length` is less than or equal to the length of `InList`). Observe that if `Length` is less than the length of `InList`, `OutList` will have more than one value.

_i.e_:
```
1 ?- subset([2, 5, 3], List, 2).
List = [2, 5] ;
List = [2, 3] ;
List = [5, 5] .
```

### Questions

#### Data control

Observe the following code:

```prolog
calc_line(add(T2), T1, Res) :-
    Res is T1+T2.
calc_line(sub(T2), T1, Res) :-
    Res is T1-T2.

calculate([Line], Arg, Res) :- 
    calc_line(Line, Arg, Res), !.
calculate([Line|Lines], Arg, Res) :- 
    calc_line(Line, Arg, Res),
    calculate(Lines, Res, _).
```

Know the answer of the following questions:
- Which values do the predicates declare?
- How does the query tree look?