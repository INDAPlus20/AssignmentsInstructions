# DD1338 Week 18

## Concordance

Did you know that files are technically a data structure. Some of you called for it, therefore MORE ADK!!!!

Us after DD1338:

![](https://images-ext-2.discordapp.net/external/2Rs7TXoJ8cowULh0GOIIo89c9kNqNwNnI51nD4YtZpg/https/pics.me.me/thumb_algorithms-a1-machine-learning-data-structures-maths-what-is-64436671.png)

### Prepare for your assigment

1) Create a repository named `<KTH_ID>-task-18` (not haskellers).
2) Clone your newly created repository and start coding. 

## Assignment
This week, like last week, you may choose between two different assignments:

- Solve LAB1 from _DD2350 Algoritmer, Datastrukturer och Komplexitet_ (We going backwards peeps)
- (or easier) Solve Kattis problems.

Of course, you can also do the regular Java assignment.

### ADK LAB1
ADK can be quite stressful (as some of you might now know), but enjoyfull! We really recommend solving this, as it is a really fun assignment and it will help you in a few years :). 

#### Specification
[Here](https://kth.instructure.com/courses/21037/assignments/124041) you will have access to preparatory questions for the lab. On the same page you will find "[Labblydelsen](https://kth.instructure.com/courses/21037/assignments/124027)", which is where you want to head to find the instructions for the lab istself.

The main idea for this lab is that you want to find every occurence of a word inside a large text file, which is a slow process! Instead we want to create smaller help files, that lets us look up these words much faster. For the sake of this assignment, we will tell you what files you need!

File relations:
`Korpus -> Token -> IndexFile (optional) -> MagicFile*`

* Korpus
  * This file is the large text file, the full text file. Lab instructions tell you how to get this from AFS. One of you is going to have to take one for the team to get this file xD

* Token
  * This file is given to you. Unzip `token.zip` to find `token.txt`. This file consists of every word in Korpus paired with the byte-index of that word. This list is sorted so that the words are first in alphabetical order, and then duplicate words are in order of appearance, as you can see below with the first 5 words in this text.
    ```
    a 10000368
    a 10017347
    a 10047993
    a 10058693
    a 10067117
    [...]
    EOF
    ```
* _(optional)_ IndexFile
  * This file is simple so it can be skipped as long as you account for the change in your MagicFile (Having this file will be easier though!) All you want for this file is to not have duplicate words to make searching easier! The above words will instead look like this:
    ```
    a 10000368 10017347 10047993 10058693 10067117 [...] \n
    ```

* MagicFile
  * Why is it called MagicFile? Well i can't tell you that of course! That's a Secret (capital S). The IndexFile is still slow to look through linearly so we want to find a way to go to the "word" that we want in O(1) time. A word starting with `aaa` should be as easy to find as `zzz`. That is why we in this file want to figure out a way to decide the byte-index for a word depending on the letters in that word *Hint Hint*.


#### Output
Like in the ADK lab, we want you to be able to provide all occurences of a word to show that the code is fast enough. If you have implemented your datastructure correctly, it should be _almost_ instant to provide all the words. Its okay if you skip the part where you ask the user if they are OK with seeing more than 25 occurences.

### Kattis
If the above ADK problem is too difficult, we have provided you an alternative!

- Solve
    - at least one of the following:
      - [String Multimatching](https://kth.kattis.com/problems/stringmultimatching)
      - [Chasing Subs](https://open.kattis.com/problems/chasingsubs)
    - and at least one of the following:
      - [Clock Picture](https://open.kattis.com/problems/clockpictures)
      - [Radio Transmission](https://open.kattis.com/problems/radiotransmission)
      - [Power Strings](https://open.kattis.com/problems/powerstrings)



### Grading
For the ADK problem, we do not have a Kattis judge, but we do however have the Korpus and Token file, so all you need to do is provide information for how we are to create your IndexFile and/or MagicFile and then run your code. 

Include screenshots of Kattis to prove solution.
