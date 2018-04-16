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




   


