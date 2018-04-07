---
title: Lambda Calculus
headerImg: sea.jpg
---

## Your Favorite Language

Probably has lots of features:

* Assignment (`x = x + 1`)
* Booleans, integers, characters, strings, ...
* Conditionals
* Loops
* `return`, `break`, `continue`
* Functions
* Recursion
* References / pointers
* Objects and classes
* Inheritance
* ...

Which ones can we do without?

What is the **smallest universal language**?

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
<br>
<br>
<br>
<br>

## What is computable?

### Before 1930s

Informal notion of an **effectively calculable** function:

![can be computed by a human with pen and paper, following an algorithm](https://oercommons.s3.amazonaws.com/media/courseware/assets/G06/06-math-math-06-9780328761197-math-9780328761197-ah-studio-images-ip3-mth-6-2-8-2-1_mw-4x3_dividehandwritten-ip3.png){#fig:pen-and-paper .align-center width=40%}


<br>
<br>
<br>
<br>

### 1936: formalization

![Alan Turing](https://upload.wikimedia.org/wikipedia/commons/a/a1/Alan_Turing_Aged_16.jpg){#fig:turing .align-center width=40%}
 
![Alonzo Church](https://upload.wikimedia.org/wikipedia/en/a/a6/Alonzo_Church.jpg){#fig:church .align-center width=40%}

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

## The Next 700 Languages

![Peter Landin](https://upload.wikimedia.org/wikipedia/en/f/f9/Peter_Landin.png){#fig:landin .align-center width=40%}

> Whatever the next 700 languages
> turn out to be,
> they will surely be
> variants of lambda calculus.

Peter Landin, 1966


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
<br>

## The Lambda Calculus

Has one feature:

* Functions

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

No, really:

* ~~Assignment (`x = x + 1`)~~
* ~~Booleans, integers, characters, strings, ...~~
* ~~Conditionals~~
* ~~Loops~~
* ~~`return`, `break`, `continue`~~
* Functions
* ~~Recursion~~
* ~~References / pointers~~
* ~~Objects and classes~~
* ~~Inheritance~~
* ~~Reflection~~

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

## Describing a Programming Language

* _Syntax:_ what do programs look like?
* _Semantics:_ what do programs mean?
    * _operational semantics_: how do programs execute step-by-step?

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

## Syntax: What Programs _Look Like_

<br>

```haskell
e ::= x
    | \x -> e 
    | e1 e2

```

<br>

Programs are **expressions** `e` (also called **$\lambda$-terms**)
of one of three kinds:

- **Variable**
    - `x`, `y`, `z`
- **Abstraction** (aka _nameless_ function definition)
    - `\x -> e`
    - `x` is the _formal_, `e` is the _body_ 
    - "for any `x` compute `e`"
- **Application** (aka function call)
    - `e1 e2`
    - `e1` is the _function_, `e2` is the _argument_
    - in your favorite language: `e1(e2)`



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

## Examples

```haskell
\x -> x             -- The identity function
                    -- ("for any x compute x")

\x -> (\y -> y)     -- A function that returns the identity function
 
\f -> f (\x -> x)   -- A function that applies its argument 
                    -- to the identity function
```


<br>
<br>

How do I write a function with two arguments?

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

```haskell
\x -> (\y -> y)     -- A function that returns the identity function
                    -- OR: a function that takes two arguments
                    -- and returns the second one!
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

## QUIZ

Which of the following terms are syntactically **incorrect**?

**A.**  `\(\x -> x) -> y`

**B.**  `\x -> x x`

**C.**  `\x -> x (y x)`

**D.**  A and C

**E.**  all of the above

<br>

(I) final

    _Correct answer:_ **A**

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




## Syntactic Sugar

<br>
<br>

instead of                |  we write
:-------------------------|:-------------------------
`(((e1 e2) e3) e4)`       |  `e1 e2 e3 e4`
`\x -> (\y -> (\z -> e))` | `\x -> \y -> \z -> e`
`\x -> \y -> \z -> e`     | `\x y z -> e`

<br>
<br>

```haskell
\x y -> y     -- A function that returns the identity function
              -- OR: a function that takes two arguments
              -- and returns the second one!
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

## Semantics : What Programs _Mean_

<br>

How do I "run" / "execute" a $\lambda$-term?

<br>

Think of middle-school algebra:

```haskell
-- Simplify expression:

  (x + 2)*(3*x - 1)
 =
  ???
```

<br>

**Execute** = rewrite step-by-step following simple rules,
until no more rules apply

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

## Rewrite Rules of Lambda Calculus

<br>

1. $\alpha$-step  (aka _renaming formals_)
2. $\beta$-step   (aka _function call_)

<br>

But first we have to talk about **scope**

<br>
<br>
<br>
<br>
<br>
<br>

## Semantics: Scope of a Variable

The part of a program where a **variable is visible**

In the expression `\x -> e`

- `x` is the newly introduced variable

- `e` is **the scope** of `x`

- `x` is **bound** inside `e`

<br>

```
  \x -> x          -- x is bound
  \x -> (\y -> x)  -- x is bound
```

<br>
<br>

An occurence of `x` in `e` is **free** if it's _not bound_ by an enclosing abstraction

<br>

```
  x y        -- x is free  
  \y -> x y  -- x is free
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

## QUIZ

In the expression `(\x -> x) x`,
is `x` _bound_ or _free_?

**A.**  bound

**B.**  free

**C.**  first occurence is bound, second is free

**D.**  first occurence is bound, second and third are free

**E.**  first two occurrences are bound, third is free

<br>

(I) final
    
    _Correct answer:_ **C**

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


## Free Variables

We can formally define the set of _all free variables_ in a term like so:

(I) lecture

    ```haskell
    FV(x)       = ???
    FV(\x -> e) = ???
    FV(e1 e2)   = ???
    ```

(I) final

    ```haskell
    FV(x)       = {x}
    FV(\x -> e) = FV(e) \ {x}
    FV(e1 e2)   = FV(e1) + FV(e2)
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


## Closed Expressions

If `e` has _no free variables_ it is said to be **closed**

- Closed expressions are also called **combinators**

<br>
<br>

What is the shortest closed expression?

_Answer:_ `\x -> x`

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

## Rewrite Rules of Lambda Calculus

<br>

1. $\alpha$-step  (aka _renaming formals_)
2. $\beta$-step   (aka _function call_)

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

## Semantics: $\beta$-Reduction

<br>

```
  (\x -> e1) e2   =b>   e1[x := e2]
```
<br>
where `e1[x := e2]` means
"`e1` with all _free_ occurrences of `x` replaced with `e2`"

<br>
<br>

Computation by _search-and-replace_:

- If you see an _abstraction_ applied to an _argument_,
take the _body_ of the abstraction and
replace all free occurrences of the _formal_ by that _argument_

- We say that `(\x -> e1) e2` $\beta$-steps to `e1[x := e2]`



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

## Examples

<br>

```haskell
(\x -> x) apple     
=b> apple
```

Is this right? Ask [Elsa](http://goto.ucsd.edu:8095/index.html#?demo=blank.lc)!

<br>
<br>

(I) lecture

    ```haskell
    (\f -> f (\x -> x)) (give apple)
    =b> ???
    ```

(I) final

    ```haskell
    (\f -> f (\x -> x)) (give apple)
    =b> give apple (\x -> x)
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

## QUIZ

<br>

```haskell
(\x -> (\y -> y)) apple
=b> ???
```

**A.** `apple`

**B.** `\y -> apple`

**C.** `\x -> apple`

**D.** `\y -> y`

**E.** `\x -> y`


<br>

(I) final

    _Correct answer:_ **D.**

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

## QUIZ

<br>

```haskell
(\x -> x (\x -> x)) apple
=b> ???
```

**A.** `apple (\x -> x)`

**B.** `apple (\apple -> apple)`

**C.** `apple (\x -> apple)`

**D.** `apple`

**E.** `\x -> x`


<br>

(I) final

    _Correct answer:_ **A.**
    
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

## A Tricky One

<br>

```haskell
(\x -> (\y -> x)) y
=b> \y -> y
```

Is this right?

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

## Something is Fishy

<br>

```haskell
(\x -> (\y -> x)) y
=b> \y -> y
```

Is this right?

**Problem**: the _free_ `y` in the argument has been **captured** by `\y`!

**Solution**: make sure that all _free variables_ of the argument
are different from the binders in the body. 

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

## Capture-Avoiding Substitution

We have to fix our definition of $\beta$-reduction:

```
  (\x -> e1) e2   =b>   e1[x := e2]
```
<br>
where `e1[x := e2]` means
~~"`e1` with all _free_ occurrences of `x` replaced with `e2`"~~

  - `e1` with all _free_ occurrences of `x` replaced with `e2`,
   **as long as** no free variables of `e2` get captured
  - undefined otherwise

<br>  

Formally:

```haskell
x[x := e]            = e
y[x := e]            = y            -- assuming x /= y
(e1 e2)[x := e]      = (e1[x := e]) (e2[x := e])
(\x -> e1)[x := e]   = \x -> e1     -- why do we leave `e1` alone?
(\y -> e1)[x := e] 
  | not (y in FV(e)) = \y -> e1[x := e]
  | otherise         = undefined    -- wait, but what do we do then???

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



## Rewrite Rules of Lambda Calculus

<br>

1. $\alpha$-step  (aka _renaming formals_)
2. $\beta$-step   (aka _function call_)

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

## Semantics: $\alpha$-Renaming

<br>

```haskell
  \x -> e   =a>   \y -> e[x := y]
    where not (y in FV(e))
```
<br>

- We can rename a formal parameter and replace all its occurrences in the body

- We say that `\x -> e` $\alpha$-steps to `\y -> e[x := y]`

<br>
<br>

Example:

```haskell
\x -> x   =a>   \y -> y   =a>    \z -> z
```

All these expressions are **$\alpha$-equivalent**

<br>
<br>
<br>

What's wrong with these?

```haskell
\f -> f x    =a>   \x -> x x


(\x -> \y -> y) y   =a>   (\x -> \z -> z) z


\x -> \y -> x y   =a>    \apple -> \orange -> apple orange
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


## The Tricky One

<br>

```haskell
(\x -> (\y -> x)) y
=a> ???
```

<br>
Try this at home!

<br>
<br>
To avoid getting confused, you can always rename formals, so that different variables have different names!

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




## Normal Forms

A **redex** is a $\lambda$-term of the form

`(\x -> e1) e2`

A $\lambda$-term is in **normal form** if it contains no redexes.


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

## QUIZ

Which of the following term are **not** in _normal form_ ?

**A.** `x`

**B.** `x y`

**C.** `(\x -> x) y`

**D.** `x (\y -> y)`

**E.** C and D

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



## Semantics: Evaluation

A $\lambda$-term `e` **evaluates to** `e'` if

1. There is a sequence of steps

```haskell
e =?> e_1 =?> ... =?> e_N =?> e'
```

where each `=?>` is either `=a>` or `=b>`

2. `e'` is in _normal form_


<br>
<br>
<br>
<br>
<br>
<br>


## Examples of Evaluation

```haskell
(\x -> x) apple
  =b> apple
```

```haskell
(\f -> f (\x -> x)) (\x -> x)
  =?> ???
```

```haskell
(\x -> x x) (???)
  =?> ???
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

## Non-Terminating Evaluation

```haskell
(\x -> x x) (\x -> x x)
  =b> (\x -> x x) (\x -> x x)
```

Oops, we can write programs that loop back to themselves...

and never reduce to a normal form!


<br>
<br>
<br>
<br>
<br>
<br>


