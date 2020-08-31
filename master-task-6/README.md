# Week 6 - A lisp-like calculator
This week we will write a calculator in the syntax of the programming language
lisp. The lisp syntax is selected mainly because it is simple to parse compared
to most other languages.

What will be a bit different this week is that I will expect you come up with
the solution yourselves. I have attached an example project that may serve as
inspiration for your work, I do recommend you read through this as it gives a
brief tutorial how to make a simple interpreter in Haskell.

The actual task description is found in the section `The calculator syntax /
task description`

## Example boolean language parser / interpreter
In this section we are going to learn about the tools that we are going to use
to construct a simple interpreter! In order to do this I have created an example
language and interpreter. The construction of which we will go through step by
step.

In this repo you will find a fully working parser and interpreter for my example
language, I call it `The boolean language`! The boolean language is capable of
evaluating any simple boolean formula consisting of `and`, `or`, `not` and, the
literals `true` and `false`. You can run an interpreter for the boolean language
by building the project using `stack build` and when done run `stack exec
interpreter`. You should now see a screen where you may enter expression such as
`not (true and false)`, `((true or false) and (not false and not false))`.  The
interpreter should hopefully print either the correct boolean value of the
expression or an error message telling you that something went wrong while
parsing the expression.

You may find the source file in the file located here:
[/src/BoolCalc.hs](/src/BoolCalc.hs)

The language itself may be described using the following `Backus–Naur form`
```
<expr> := <literal> | <not> | <and> | <or>
<literal> := "true" | "false"
<not> := "not" <expr>
<and> := ( <expr> "and" <expr> )
<or> := ( <expr> "or" <expr> )
```

Understanding Backus-Naur form is not strictly required for this task. However
if you are interested about the details or find this notation non-intuitive
please see this Wikipedia article
https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form.

In Haskell, we can model this language as a data type representing the abstract
syntax tree like this:

``` haskell
data AST = Literal Bool
         | And AST AST
         | Or AST AST
         | Not AST
```

That is, a representation of the language syntax that is easier for a computer
to process. Using this, you will see that we can define a function that runs the
actual computation quite neatly. In the source file you will find that the
evaluation function looks like this:

``` haskell
eval :: AST -> Bool
eval (Literal b) = b
eval (And l r)   = eval l && eval r
eval (Or l r)    = eval l || eval r
eval (Not b)     = not (eval b)
```

While I would claim that the above part is elegant in itself it is nothing out
of the ordinary. The more tricky part is transforming a string to our AST
format.

A program that reads a string and converts it to something else is usually called
a `parser`, these may come in many shapes and forms. In Haskell, the by far most
common form of these are something called `parser combinators`. The meaning of
this name will be explained by example while explaining the how we parse the
boolean language. But in short: the idea is that complicated parsers can be
constructed from smaller ones.

For this we will use a library named parsec. All documentation of the library
may be found here: https://hackage.haskell.org/package/parsec While I do
recommend that you read through the documentation a bit later on, it may be
better if you start by reading my guide here first.

Initially, ignoring some of the more complicated parts of this concept. Parser
combinators gives us a set of tools to match some structure on strings much like
regular expressions do.

For example, the following expression will determine if a character is a digit.

``` haskell
oneOf ['0'..'9']
```
We may also write expression that checks that a string starts with the word `"potato"` like this

``` haskell
string "potato"
```

To actually run the above parers you may use the `parse` function in ghci. Using
it can look something like this:

```shell
ghci
> :set -package parsec
> import Text.Parec
> parse (string "potato") "" "potato"
Right "potato"
> parse (string "potato") "" "not potato"
Left (line 1, column 1):
unexpected "n"
expecting "potato"
```

The first argument to `parse` is your parser, the second is usually the name of
the source (used only for debugging) and the third argument is the actual string
that you would like to parse.

As you see in the example, the input string `"not potato"` gives an error, this
is simply because the parser parses from left to right expecting an exact match,
if it is unable to match, it returns an error that tells you what it expected to
find and at which position in the input file the error occurred.

As I previously mentioned, we are able to combine these two parsers to create a
more powerful parser. For example if we want to know if a string starts with the
word `"potato"` followed by one digit we may write an expression like this.

``` haskell
string "potato" >> oneOf ['0'..'9']
```

You should recognize the `>>` operator from previous tasks. Right now you do not
need to know exactly what it does, the important part is that the left part will
be checked before the right part.

We may also write more dynamic parsers. For example, say we want to see if a
string starts with either the string `"potato"` or the string `"pot"` and then
followed by a digit.  For cases like this the parsec library comes equipped with
the `<|>` operator, commonly called the 'alternative operator'. An expression
trying to match `"potato"` or `"pot"` would look like this:

``` haskell
(try (string "potato") <|> string "pot") >> oneOf ['0'..'9']
```

However, we need to use the `try` function as you see in the example above. The
reason for this is that when the parser tries to see if the string `"potato"` is
in the input it actually consumes some input. The `<|>` operator is defined such
that it only tries the other alternative if the left parser fails without
consuming any input. Here is where the `try` comes into play, `try` saves the
current input before running the inner parser. If it fails it will simply
restore the input to the original otherwise it does nothing.

Now we only need to know one more thing before we are ready to understand the
parsing of a language. While the parsers checks that the input matches your
specification it also returns whatever it parsed, you are free change the result
to whatever you desire.

For example let us make a parser that parses the string `"true"` and if it
succeeds it returns the boolean `True`. As well as a parser that parses `"false"`
and if it succeeds returns the boolean `False`.

``` haskell
true = string "true" >> pure True
false = string "false" >> pure False
```

`pure` does exactly the same thing as `return` does, Absolutely nothing!  It
just wraps the results in the datatype of the parser. Whether `pure` and
`return` are synonyms for the same function, any one may be used. Some people
argue that only `pure` should be used because the name `return` may be confusing
for those that are used to imperative languages.

As before, we can easily combine these two parsers to a new parser. In our case
this would be a parser that is capable of parsing any boolean value.

``` haskell
boolean = try true <|> false
```

We have now completed the first step towards the boolean language parser! That
is, parsing the literal boolean values in the language. In the example project
the parser is defined as follows instead:

``` haskell
boolExpr :: Parser AST
boolExpr = Literal <$> (try true <|> false)
  where
    true = (try (string "true") <|> (string "t")) >> pure True
    false = (try (string "false") <|> string "f") >> pure False
```

The `Literal <$>` part of the code may be a bit confusing, for some
people. Remember that `<$>` is simply an infix version of the `fmap` function
defined for functors. What happens is that the `(try true <|> false)` expression
will return a value of the type `Parser Bool` and running `fmap Literal` on a
value like this will convert it to the `Parser AST` type described above.

Before we go on defining the remaining parsers we need to think a little.
Unfortunately all of the other expressions have a recursive structure. This may
be a bit weird a first, however, it becomes easier if we start by assuming we
have a parser `ast` that can parse any expression. I will define this a bit
later, for now assume we have the function. Its type signature simple looks
like this:

``` haskell
ast :: Parser AST
```

So lets start by parsing a 'not' expression as we defined above to look like this:
```
<not> := not <expr>
```

All we need to do is to make sure that we find the string `"not"` and then
recursively call the `ast` function to retrieve whatever it is supposed to
negate.

``` haskell
notExpr :: Parser AST
notExpr = Not <$> (string "not" >> ast)
```

Yet again the infix `<$>` operator is used, remember it simply means `fmap`. In
detail, what will happen is that the inner parser will first make sure that the
string 'not' is found, then give us rest of the expression. This expression will
then simply be applied to the `Not` data constructor. For example, say we give
it the string `"not true"`. It will parse the `"not"` part of the string, the
`ast` parser will be given remaining string `" true"`. If we define `ast`
correctly later, this should give us the value `Literal True` back. We then
apply the returned to the `Not` constructor, yielding the value `Not (Literal
True)`.

Except for the `ast` parser, we only have two parts left, an and-expression
parser and an or-expression parser. It turns out that they are kind of similar,
but lets focus on the and-expressions first:

```
<and> := ( <expr> and <expr> )
```

By the definition above we need to first look for a left parenthesis, then parse
some expression, find the string `"and"` and then find another expression
followed by a right parenthesis.

To cut to the chase this could be written like this:

``` haskell
andExpr :: Parser AST
andExpr = do
  char '('
  l <- ast
  spaces
  string "and"
  r <- ast
  char ')'
  pure $ And l r
```

By now, the presence of the do notation should tell you that something about
monads is involved in the background. However, for our purposes we can safely
ignore this. The only important thing to know is that the computations will
happen sequentially from top to bottom, if something fails on the way, the
parser will stop and give us the error.

What we should care about is the fact that the 'and' and 'or' parsers will most
probably look the same except for what string we parse and what we do to the
left and right values. As most coders agree on, we probably do not want to
duplicate code! We can therefore start splitting this code up into smaller
parts, utility functions if you will. Lets start with the parenthesis, we could
create a utility function that takes some parser and simply makes sure there is
a pair of parenthesis around it. In the source code you may find the function
defined as follows:

``` haskell
betweenParens :: Parser a -> Parser a
betweenParens parser = do
  char '('
  a <- parser
  char ')'
  pure a
```

This method takes a parser as an argument, makes sure there is a left
parenthesis before it. Runs the inner parser and keeps the result, makes sure
there is a right parenthesis and finally gives us the result.

Once we have this, we are ready to define a function that parses any infix
operator with parenthesis around it! We only have to ask ourselves what defines
operators like this. Well, we know that every infix operator in our language
starts and ends with a parenthesis. They have a left expression, a right
expression that are separated by some symbol that probably can be parsed with
some parser that we can define later. And we wish that the returned value is
constructed using the left and right values. in code it could look like this:

``` haskell
infixExpr :: Parser a -> (AST -> AST -> AST) ->  Parser AST
infixExpr op constr = betweenParens $ do
  l <- ast
  spaces
  op
  r <- ast
  pure $ constr l r
```

The `spaces` function seen here simply makes sure that any space characters are
ignored.

Using this function we can now define the `andExpr` and `orExpr` like this:

``` haskell
andExpr :: Parser AST
andExpr = infixExpr (string "and") And

orExpr :: Parser AST
orExpr = infixExpr (string "or") Or
```

We are now ready to tie the knot and actually define the `ast` parser we have
used so much!

``` haskell
ast :: Parser AST
ast = do
  spaces
  choice [ try notExpr
         , try boolExpr
         , try andExpr
         , orExpr
         ]
```

That is an `AST` is either a not-expression, a bool-expression, and-expression
or an or-expression. The `choice` function defined in the library does exactly
what we need. This function simply takes a list of parsers and tries to apply
them from start to end giving the first one that successfully parses something!

In fact the choice function is defined like this in the standard library. The
`mzero` is a parser that always fails.

``` haskell
choice parsers = foldr (<|>) mzero parsers
```

The final step of writing an interpreter is now to put everything together. In
the example project there is a `interpret` function that takes a string and
returns a string like this.

``` haskell
interpret :: String -> String
interpret str =
  case eval <$> parseAst (map Char.toLower str) of
    Left err -> "Error when parsing: " <> show err
    Right True -> "true"
    Right False -> "false"
```

Before we are ready to start writing parsers for more complex languages I would
like to highlight the following parser defined in the parsec library:

``` haskell
many :: ParsecT s u m a -> ParsecT s u m [a]
```

The many parser takes another parser a an argument and tries to parse the same
thing many times. The succeeding parses are returned in a list.

``` haskell
> parse (try $ many bool) "" "true false true"
Right [True False True]
> parse (try $ many bool) "" ""
Right []
```

There is also a similar parser named `many1` which requires the parser to
succeed at least once.

The type signature of the `many` function may give you a hint that there are
some other advanced features of the Parsers hidden from you. In fact these more
features are rarely needed but may come in handy in certain situations. The
parser data type signature looks like this `ParsecT s u m a`. The `s` is simply
the datatype that it take as input. In our case the naive `String` data type is
just fine. But for better performance more efficient data type may be used
instead, such as `Bytestring`. Furthermore, the parsers can contain some state
`u` this can be used to remember something about what we parsed for further down
the chain. And `m` is any inner monad. This is could enable adding more advanced
monadic behavior to the parser, however this is not needed in our use-case.

To simplify things the `Parser` type is instead defined as like this:

``` haskell
type Parser = Parsec String ()
```

This simply gives us a parser that does not store anything extra and works on
strings. For the purposes of the exercise this should be enough.

The part of the program that runs the REPL comes from a Haskell library by the
name of `repline`. This library defines a simple REPL framework. In our case the
Main.hs file is a slightly modified version of the [Simple.hs example
file](https://github.com/sdiehl/repline/blob/master/Simple.hs) found in the
project git repository.

## The calculator syntax / task description

In this task the calculator will be written in what is called an
[s-expression](https://en.wikipedia.org/wiki/S-expression). This is the basic
syntax of a all lisp-like languages. In this task we will only be using a subset
of this for this task as the idea is not to create a full programming
language.

Side note:

As always, if you wish to make something more advanced, for example parse full
s-expressions you do of course have my encouragement! However, it is absolutely
not a requirement!

The subset we will be working with may be described using the following BNF
(Bachus-Naur form):

```
<s-exp> := <literal> | <symbol> | ( <s-exp>* )
<symbol> := "+" | "-" | "*" | "/" | "int-div"
<literal> := <integer> | <float>
<integer> := <digit> | <integer> <digit>
<float> := <integer> "." | "." <integer> | <integer> "." <integer>
<digit> := "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
```

Our goal is to describe standard arithmetic expressions. In lisp addition
usually looks like `(+ 1 2)` which should evaluate to `3`. Subtraction looks
like `(- 1 2)` which should result in `-1`.  The first thing you should notice
is that the function that should be called is put directly after the parenthesis
and the arguments to the function follows subsequently. Another common property
of lisp expressions is that the number of arguments are not fixed, that is we
have the possibility to input a many arguments as we wish. for example
`(+ 1 2 3 4 5)` results in `15`. Furthermore, we may write sub expressions anywhere a
literal may be, for example, `(+ 1 2 3 4 (- 10 5))` also evaluates to `15`.

Ideally your interpreter should be able to handle arithmetic errors in a well
mannered way. For example, make sure that `(/ 0 0)` does not crash the program
but instead gives an error, I leave the details up to you.

You may notice that there are both floats and integers into the definition. It
is expected that you are able to handle computations on both of these values and
convert the values where you see fit. For example, floating point division
performed on two integers should result in a floating point value. E.g `(/ 1 2)`
should give `0.5`. If you want to create a more scientifically correct
calculator you may wish to have a look at rational numbers. Defined
[here](https://hackage.haskell.org/package/protolude-0.2.3/docs/Protolude.html#t:Ratio).

In the definition there is also a `int-div` function. The idea is that this
function performs exactly what it says, integer division. For example `(int-div
5 2)` should evaluate to `2`. If a non-integer value is passed to this function
it should result in an error.

Finally, you may have noticed that the syntax does not specify any negative
numbers, if you want to include these in your syntax, you may do so. However it
is usually enough to specify that for example `(- 0.5)` to evaluate to `-0.5`.

This is all you should need to get started, remember that you are expected you to
come up with the structure and solutions to various problems you find on your
own. You are of course allowed to discuss the task with friends and foes
alike. But remember that the code you write should be your own.
