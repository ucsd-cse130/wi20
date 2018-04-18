---
title: A crash course in Haskell
date: 2016-09-26
headerImg: books.jpg
---

## What is Haskell?

<br>

A **typed**, **lazy**, **purely functional** programming language

<br>

Haskell = $\lambda$-calculus + 

  + better syntax
  + types
  + built-in features
    - booleans, numbers, characters
    - records (tuples)
    - lists
    - recursion
    - ...
    
<br>
<br>
<br>
<br>
<br>
<br>    
    
## Why Haskell?

Haskell programs tend to be *simple* and *correct*   

### QuickSort in Haskell

```haskell
sort []     = []
sort (x:xs) = sort ls ++ [x] ++ sort rs
  where
    ls      = [ l | l <- xs, l <= x ]
    rs      = [ r | r <- xs, x <  r ]
```

### Goals for this week

1. Understand the code above
2. Understand what **typed**, **lazy**, and **purely functional** means (and why it's cool)

<br>
<br>
<br>
<br>
<br>
<br>

## Haskell vs $\lambda$-calculus: similarities

### (1) Programs

A program is an **expression** (*not* a sequence of statements)

It **evaluates** to a value (it *does not* perform actions)

  * **$\lambda$**:

    ```
    (\x -> x) apple     -- =~> apple
    ```

  * **Haskell**:
  
    ```
    (\x -> x) "apple"   -- =~> "apple"
    ```

### (2) Functions    
      
Functions are *first-class values*:

* can be *passed as arguments* to other functions
* can be *returned as results* from other functions
* can be *partially applied* (arguments passed *one at a time*)
   
```haskell
(\x -> (\y -> x (x y))) (\z -> z + 1) 0   -- =~> ???
```

*But:* unlike $\lambda$-calculus, not everything is a function!

     
### (3) Top-level bindings

Like in Elsa, we can *name* terms to use them later
 
**Elsa**:

```haskell
let T    = \x y -> x
let F    = \x y -> y

let PAIR = \x y -> \b -> ITE b x y
let FST  = \p -> p T
let SND  = \p -> p F

eval fst:
 FST (PAIR apple orange)
 =~> apple
```

**Haskell**:

```haskell
haskellIsAwesome = True

pair = \x y -> \b -> if b then x else y
fst = \p -> p haskellIsAwesome
snd = \p -> p False

-- In GHCi:
> fst (pair "apple" "orange")   -- "apple"
```   
    
The names are called **top-level variables**

Their definitions are called **top-level bindings**

<br>
<br>
<br>
<br>
<br>
<br>
    
## Better Syntax: Equations and Patterns

You can define function bidings using **equations**:

```haskell
pair x y b = if b then x else y
fst p      = p True
snd p      = p False
```
<br>
<br>
<br>

Can define multiple equations with different **patterns**:

```haskell
pair x y True  = x  -- If 3rd arg matches True,
                    -- use this equation;
pair x y False = y  -- Otherwise, if 3rd arg matches False,
                    -- use this equation.
```

Same as:

```haskell
pair x y True  = x  -- If 3rd arg matches True,
                    -- use this equation;
pair x y b     = y  -- Otherwise, use this equation.
```

Same as:

```haskell
pair x y True  = x
pair x y _     = y
```

<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

Which of the following definitions of `pair` is **incorrect**?

**A.** `pair x y = \b -> if b then x else y`

**B.** `pair x = \y b -> if b then x else y`

**C.**
```haskell
pair x _ True  = x
pair _ y _     = y
```

**D.**
```haskell
pair x y b     = x
pair x y False = y
```

**E.**  all of the above

<br>
<br>
<br>
<br>
<br>
<br>

## Equations with guards

An equation can have multiple guards (Boolean expressions):

```haskell
cmpSquare x y  |  x > y*y   =  "bigger :)"
               |  x == y*y  =  "same :|"
               |  x < y*y   =  "smaller :("
```

Same as:

```haskell
cmpSquare x y  |  x > y*y   =  "bigger :)"
               |  x == y*y  =  "same :|"
               |  otherwise =  "smaller :("
```

<br>
<br>
<br>
<br>
<br>
<br>

## Recusion

Recursion is built-in, so you can write:

```haskell
sum 0 = 0
sum n = n + sum (n - 1)
```

<br>
<br>
<br>
<br>
<br>

## The scope of variables

Top-level variable have **global** scope,
so you can write:

```haskell
message = if haskellIsAwesome          -- this var defined below
            then "I love CSE 130"
            else "I'm dropping CSE 130"
            
haskellIsAwesome = True
```

<br>
<br>

Or you can write:

```haskell
-- What does f compute?
f 0 = True
f n = g (n - 1) -- mutual recursion!

g 0 = False
g n = f (n - 1) -- mutual recursion!
```

<br>
<br>
<br>

Is this allowed?

```haskell
haskellIsAwesome = True

haskellIsAwesome = False -- changed my mind
```

<br>
<br>
<br>
<br>

### Local variables

You can introduce a *new* (local) scope using a `let`-expression:

```haskell
sum 0 = 0
sum n = let n' = n - 1          
        in n + sum n'  -- the scope of n' is the term after in
```

<br>
<br>
<br>

Syntactic sugar for nested `let`-expressions:

```haskell
sum 0 = 0
sum n = let 
          n'   = n - 1
          sum' = sum n'
        in n + sum'
```

<br>
<br>
<br>

If you need a variable whose scope is an equation, use the `where` clause instead:

```haskell
cmpSquare x y  |  x > z   =  "bigger :)"
               |  x == z  =  "same :|"
               |  x < z   =  "smaller :("
  where z = y*y
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Types

<br>
<br>
<br>
<br>

What would *Elsa* say?

```haskell
let WEIRDO = ONE ZERO
```

<br>
<br>
<br>
<br>

What would *Python* say?

```python
def weirdo():
  return 0(1)
```

<br>
<br>
<br>
<br>

What would *Java* say?

```java
void weirdo() {
  int zero;
  zero(1);
}
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>

Is *Haskell* every expression has a **type**
and ill-typed expressions are rejected **statically**
(at compile-time, before executing them)

  * like in Java
  * unlike $\lambda$-calculus, Python, or JavaScript

```haskell
weirdo = 1 0     -- rejected by GHC
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Type annotations

You can annotate your bindings with their types using `::`, like so:

```haskell
-- | This is a Boolean:
haskellIsAwesome :: Bool            
haskellIsAwesome = True

-- | This is a string
message :: String
message = if haskellIsAwesome
            then "I love CSE 130"
            else "I'm dropping CSE 130"
            
-- | This is a word-size integer
rating :: Int
rating = if haskellIsAwesome then 10 else 0

-- | This is an arbitrary precision integer
bigNumber :: Integer
bigNumber = factorial 100
```

If you omit annotations, GHC will infer them for you

  * Inspect types in GHCi using `:t`
  * You should annotate all top-level bindings anyway! (Why?)

<br>
<br>
<br>
<br>
<br>
<br>

## Function Types

Functions have **arrow types**:

* `\x -> e` has type `A -> B`
* if `e` has type `B` assuming `x` has type `A`

For example:

```haskell
> :t (\x -> if x then `a` else `b`)  -- ???
```

<br>
<br>
<br>
<br>

You should annotate your function bindings:

```haskell
sum :: Int -> Int
sum 0 = 0
sum n = n + sum (n - 1)
```

With multiple arguments:

```haskell
pair :: String -> (String -> (Bool -> String))
pair x y b = if b then x else y
```

Same as:

```haskell
pair :: String -> String -> Bool -> String
pair x y b = if b then x else y
```

<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

With `pair :: String -> String -> Bool -> String`,
what would GHCi say to 

```haskell
>:t pair "apple" "orage"
```

**A.** Syntax error

**B.** The term is ill-typed

**C.** `String`

**D.** `Bool -> String`

**E.** `String -> String -> Bool -> String`

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Lists

A list is

  * either an *empty list*
    
    `[]       -- pronounced "nil"`
    
  * or a *head element* attached to a *tail list* 
  
    `x:xs     -- pronounced "x cons xs"`
    
<br>
<br>    
  
Examples:

```haskell
[]                -- A list with zero elements

1:[]              -- A list with one element: 1

(:) 1 []          -- Same thing: for any infix op, 
                  -- (op) is a regular function!

1:(2:(3:(4:[])))  -- A list with four elements: 1, 2, 3, 4

1:2:3:4:[]        -- Same thing (: is right associative)

[1,2,3,4]         -- Same thing (syntactic sugar)
```  

<br>
<br>

### Terminology: constructors and values

`[]` and `(:)` are called the list **constructors**

We've seen constructors before:

  * `True` and `False` are `Bool` constructors
  * `0`, `1`, `2` are... well, it's complicated, but you can think of them as `Int` constructors
  * these constructions didn't take any parameters, so we just called them *values*

In general, a **value** is a constructor applied to *other values*

  * examples above are list values

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## The Type of a List

A list has type `[A]` if each one of its elements has type `A`

Examples:

```haskell
myList :: [Int]
myList = [1,2,3,4]


-- myList' :: ??
myList' = ['h', 'e', 'l', 'l', 'o']


-- myList'' :: ???
myList'' = [1, 'h']

-- myList''' :: ???
myList''' = []
```  

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
  
## Functions on lists: range

```haksell
-- | List of integers from n upto (m - 1)
upto :: Int -> Int -> [Int]
upto n m = ???
```

<br>
<br>
<br>
<br>
<br>

There's also syntactic sugar for this!

```haksell
[1..7]    -- [1,2,3,4,5,6,7]
[1,3..7]  -- [1,3,5,7]
```


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Functions on lists: length

```haskell
-- | Length of the list
length :: ???
length xs = ???
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Pattern matching on lists

```haskell
-- | Length of the list
length :: [Int] -> Int
length []     = 0
length (_:xs) = 1 + length xs
```

<br>
<br>

~~A pattern is either a *variable* (incl. `_`) or a *value*~~

A pattern is 

  * either a *variable* (incl. `_`)
  * or a *constructor* applied to other *patterns*
  
<br>
<br>  

**Pattern mathching** attempts to match *values* against *patterns* and, 
if desired, *bind* variables to successful matches.
  
  
<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

Which of the following is **not** a pattern?

**A.** `(1:xs)`

**B.** `(_:_:_)`

**C.** `[x]`

**D.** `[1+2,x,y]`

**E.**  all of the above

<br>
<br>
<br>
<br>
<br>
<br>  


## Some useful library functions

```haskell
-- | Is the list empty?
null :: [Int] -> Bool

-- | Head of the list
head :: [Int] -> Int

-- | Tail of the list
tail :: [Int] -> [Int]

-- | Length of the list
length :: [Int] -> Int

-- | Append two lists
(++) :: [Int] -> [Int] -> [Int]

-- | Are two lists equal?
(==) :: [Int] -> [Int] -> Bool
```


   


