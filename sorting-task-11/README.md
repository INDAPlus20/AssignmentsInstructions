# DD1338 Week 11

## Pretty Sorting

Sorting doesn't have to be boring. Your assignment this week is to implement a handful of sorting algorithms and to visulise them graphically.

The sorting algoritms are _selection sort_, _insertion sort_, _merge sort_ (you may choose whatever merge sort type) and at least one sorting algoritm of your choise. Choose something fun! See [this list](https://www.geeksforgeeks.org/sorting-algorithms/) for inspiration.

### Psudo Code for Least Mandatory Implementations
```
# INSERTION SORT #

i ← 1
while i < length(A)
    x ← A[i]
    j ← i - 1
    while j >= 0 and A[j] > x
        A[j+1] ← A[j]
        j ← j - 1
    end while
    A[j+1] ← x
    i ← i + 1
end while
return A
```
```
# SELECTION SORT #

i ← 0
while i < length(A)-1
    minIndex ← i
    j ← i + 1
    while j < length(A)
        if A[j] < A[minIndex] then
            minIndex ← j
        end if
    end while
    if minIndex != i then
        swap A[i] and A[minIndex]
    end if
    i ← i + 1
end while
return A
```
```
# MERGE SORT (top-down) #

if length(A) <= 1 then
    return A
left ← empty list
right ← empty list
i ← 0
while i < length(A)
    if i < length(A)/2 then
        add A[i] to left
    else
        add A[i] to right
    end if
    i ← i + 1
end while
left ← merge sort left
right ← merge sort right
return concatinate left and right
```

**Note**: You may implemet your solution using any language (this includes Python *_host_ psudokod *_host_ *_host_).

### Prepare Assignment

1) Create a repository named `<KTH_ID>-sorting` under the `INDAPlus20` organisation and clone it. (Or don't, looking at you `@haskellers`!)
2) Navigate into your newly created repository and start writing.

See `./sorting-visualisation` for an example implemetation.

### Grading

Because your solution can be implemented using any language, write in a README file of how to build and run your application. If you're writing your solution using Rust, **_do not_** copy the example solution!