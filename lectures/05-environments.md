---
title: Environments
date: 2019-05-15
headerImg: books.jpg
---

## Past three weeks

How to *use* essential language constructs?

- Data Types
- Recursion
- Higher-Order Functions

## Next two weeks

How to *implement* language constructs?

- Local variables and scope
- Environments and Closures
- Type Inference

### Interpreter

How do we *represent* and *evaluate* a program?

<!-- 
- How do we *prove properties* about our interpreter
  (e.g. that certain programs never crash)?  
  -->

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Roadmap: The Nano Language

Features of Nano:

1. **Arithmetic**
2. Variables
3. Let-bindings
4. Functions
5. Recursion

![](/static/img/trinity.png){#fig:types .align-center width=60%}

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## 1. Nano: Arithmetic

A "grammar" of arithmetic expressions:

```haskell
e ::= n
    | e1 + e2
    | e1 - e2
    | e1 * e2
```

<br>

| **Expressions** |       | **Values**  |
|:----------------|:------|:------------|
| `4`             | `==>` | 4           |
| `4 + 12`        | `==>` | 16          |
| `(4+12) - 5`    | `==>` | 11          |

<br>
<br>

## Representing Arithmetic Expressions and Values

![](/static/img/trinity.png){#fig:types .align-center width=60%}

Lets *represent* arithmetic expressions as type

```haskell
data Expr
  = ENum Int         -- ^ n
  | EAdd Expr Expr   -- ^ e1 + e2
  | ESub Expr Expr   -- ^ e1 - e2
  | EMul Expr Expr   -- ^ e1 * e2
```

Lets *represent* arithmetic values as a type

```haskell
type Value = Int
```

<br>
<br>
<br>
<br>


## Evaluating Arithmetic Expressions

![](/static/img/trinity.png){#fig:types .align-center width=60%}

We can now write a Haskell function to  *evaluate* an expression:

```haskell
eval :: Expr -> Value
eval (ENum n)     = n
eval (EAdd e1 e2) = eval e1 + eval e2
eval (ESub e1 e2) = eval e1 - eval e2
eval (EMul e1 e2) = eval e1 * eval e2
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Alternative representation

Lets pull the *operators* into a separate type

```haskell
data Binop = Add                  -- ^ `+`
           | Sub                  -- ^ `-`
           | Mul                  -- ^ `*`

data Expr  = ENum Int              -- ^ n
           | EBin Binop Expr Expr  -- ^ e1 `op` e2
```

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

Evaluator for alternative representation

```haskell
eval :: Expr -> Value
eval (ENum n)        = n
eval (EBin op e1 e2) = evalOp op (eval e1) (eval e2)
```

What is a suitable type for `evalOp`?

```haskell
{- 1 -} evalOp :: BinOp -> Value
{- 2 -} evalOp :: BinOp -> Value -> Value -> Value
{- 3 -} evalOp :: BinOp -> Expr -> Expr -> Value
{- 4 -} evalOp :: BinOp -> Expr -> Expr -> Expr
{- 5 -} evalOp :: BinOp -> Expr -> Value
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

## The Nano Language

Features of Nano:

1. Arithmetic *[done]*
2. **Variables**
3. Let-bindings
4. Functions
5. Recursion

![](/static/img/trinity.png){#fig:types .align-center width=60%}

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## 2. Nano: Variables

Let's add variables and `let` bindings!

```haskell
e ::= n                   -- OLD
    | e1 + e2
    | e1 - e2
    | e1 * e2
                          -- NEW
    | x                   -- variables
```

Lets extend our datatype

```haskell
type Id = String

data Expr
  = ENum Int              -- OLD
  | EBin Binop Expr Expr  
                         -- NEW
  | EVar Id              -- variables
```

<br>

## QUIZ 

What should the following expression evaluate to?

```haskell
x + 1
```

**(A)** `0`

**(B)** `1`

**(C)** Error

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Environment

An expression is evaluated in an **environment**

- A **phone book** which maps *variables* to *values*

```haskell
[ "x" := 0, "y" := 12, ...]
```

A type for *environments*

```haskell
type Env = [(Id, Value)]
```

<br>
<br>
<br>
<br>
<br>

## Evaluation in an Environment

We write

```haskell
(eval env expr) ==> value
```

to mean

When `expr` is **evaluated in environment** `env` the result is `value`**

That is, when we have variables, we modify our `eval`uator to take an input 
environment `env` in which `expr` must be evaluated.

```haskell
eval :: Env -> Expr -> Value
eval env expr = ... value-of-expr-in-env...
```

First, lets update the evaluator for the arithmetic cases `ENum` and `EBin`

```haskell
eval :: Env -> Expr -> Value
eval env (ENum n)        = ???
eval env (EBin op e1 e2) = ???
```

<br>
<br>
<br>
<br>
<br>

## QUIZ

What is a suitable `?value` such that

```
eval [ "x" := 0, "y" := 12, ...] (x + 1)  ==>  ?value
```

**(A)** `0`

**(B)** `1`

**(C)** Error

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

What is a suitable `env` such that

```
eval env (x + 1)   ==>   10
```

**(A)** `[]`

**(B)** `[x := 0, y := 9]`

**(C)** `[x := 9, y := 0]`

**(D)** `[x := 9, y := 10, z := 666]`

**(E)** `[y := 10, z := 666, x := 9]`

## Evaluating Variables

Using the above intuition, lets update our evaluator 
to handle variables i.e. the `EVar` case:

```haskell
eval env (EVar x)        = ???
```

<br>
<br>

Lets confirm that our `eval` is ok!

```haskell
envA = []
envB = ["x" := 0 , "y" := 9]
envC = ["x" := 9 , "y" := 0]
envD = ["x" := 9 , "y" := 10 , "z" := 666]
envE = ["y" := 10, "z" := 666, "x" := 9  ]

-- >>> eval envA (EBin Add (EVar "x") (ENum 1))
-- >>> eval envB (EBin Add (EVar "x") (ENum 1))
-- >>> eval envC (EBin Add (EVar "x") (ENum 1))
-- >>> eval envD (EBin Add (EVar "x") (ENum 1))
-- >>> eval envE (EBin Add (EVar "x") (ENum 1))
```

## The Nano Language

Features of Nano:

1. Arithmetic expressions *[done]*
2. Variables              *[done]*
3. **Let-bindings**
4. Functions
5. Recursion

![](/static/img/trinity.png){#fig:types .align-center width=60%}

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## 2. Nano: Variables

Let's add variables and `let` bindings!

```haskell
e ::= n                   -- OLD
    | e1 + e2
    | e1 - e2
    | e1 * e2
    | x
                          -- NEW
    | let x = e1 in e2
```

Lets extend our datatype

```haskell
type Id = String

data Expr
  = ENum Int              -- OLD
  | EBin Binop Expr Expr  
  | EVar Id
                         -- NEW
  | ELet Id Expr Expr
```

How should we extend `eval` ?

<br>

## QUIZ

What *should* the following expression evaluate to?

```haskell
let x = 0
in
  x + 1
```


**(A)** Error

**(B)** `1`

**(C)** `0`

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

What *should* the following expression evaluate to?

```haskell
let x = 0
in
  let y = 100
  in
    x + y
```

**(A)** Error

**(B)** `0`

**(C)** `1`

**(D)** `100`

**(E)** `101`

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

What *should* the following expression evaluate to?

```haskell
let x = 0
in
  let x = 100
  in
    x + 1
```

**(A)** Error

**(B)** `0`

**(C)** `1`

**(D)** `100`

**(E)** `101`

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

What *should* the following expression evaluate to?

```haskell
let x = 0
in
  (let x = 100 in
   in
     x + 1
  )
  +
  x
```

**(A)** Error

**(B)** `1`

**(C)** `101`

**(D)** `102`

**(E)** `2`

## Principle: (Lexical) Static Scoping

Every variable *use* gets its value from a unique *definition*:

- "Nearest" `let`-binder in program *text*

"Static" means you can tell *without running the program*

Great for readability and debugging

1. Define *local* variables
2. Be sure *where* each variable got its value

Don’t have to scratch head to figure where a variable got "assigned"

How to **implement** static scoping?

<br>
<br>
<br>
<br>
<br>
<br>

## QUIZ

Lets re-evaluate the quizzes!

```haskell
              -- env
let x = 0
in            -- ??? what env to use for `x + 1`?
  x + 1
```

**(A)** `env`

**(B)** `[ ]`

**(C)** `[ ("x" := 0) ]`

**(D)** `("x" := 0) : env`

**(E)** `env ++ ["x" := 0]`

<br>
<br>
<br>
<br>
<br>

## QUIZ

```haskell
                  -- env
let x = 0
in                  -- (x := 0) : env
  let y = 100
  in                  -- ??? what env to use for `x + y` ?
    x + y
```

**(A)** `("x" := 0) : env`

**(B)** `("y" := 100) : env`

**(C)** `("y" := 100) : ("x" := 0) : env`

**(D)** `("x" := 0) : ("y" := 100) : env`

**(E)** `[("y" := 100), ("x" := 0)]`

<br>
<br>
<br>
<br>
<br>

## QUIZ

Lets re-evaluate the quizzes!

```haskell
              -- env
let x = 0
in              -- ("x" := 0) : env
  let x = 100
  in              -- ??? what env to use for `x + 1`?
    x + 1
```

**(A)** `("x" := 0) : env`

**(B)** `("x" := 100) : env`

**(C)** `("x" := 100) : ("x" := 0) : env`

**(D)** `("x" := 0) : ("x" := 100) : env`

**(E)** `[("x" := 100)]`

<br>
<br>
<br>
<br>
<br>

## Extending Environments

Lets fill in `eval` for the `let x = e1 in e2` case!

```haskell
eval env (ELet x e1 e2) = ???
```

1. **Evaluate** `e1` in `env` to get a value `v1`
2. **Extend** environment with value for `x` i.e. to `(x := v1) : env`
3. **Evaluate** `e2` using *extended* environment.

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

Lets make sure our tests pass!

## Run-time Errors

Haskell function to *evaluate* an expression:

```haskell
eval :: Env -> Expr -> Value

eval env (Num n)        = n

eval env (Var x)        = lookup x env      -- (A)

eval env (Bin op e1 e2) = evalOp op v1 v2   -- (B)
  where
    v1                  = eval env  e1      -  (C)
    v2                  = eval env  e2      -- (C) 

eval env (Let x e1 e2)  = eval env1 e2
  where
    v1                  = eval env e1
    env1                = extend env x v1   -- (D)
```

## QUIZ

Will `eval env expr` always return a `value` ? Or, can it *crash*?


**(A)** operation at `A` may fail

**(B)** operation at `B` may fail

**(C)** operation at `C` may fail

**(D)** operation at `D` may fail

**(E)** nah, its all good..., always returns a `Value`


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


## Free vs bound variables

How do we make sure `lookup` doesn't cause a run-time error?

In `eval env e`, `env` must contain bindings for *all free variables* of `e`!

- an occurrence of `x` is **free** if it is not **bound**
- an occurrence of `x` is **bound** if it's inside `e2` where `let x = e1 in e2`
- evaluation succeeds when an expression is **closed**!

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

Which variables are free in the expression?

```haskell
let y = (let x = 2 in x) + x in
let x = 3 in
x + y
```    

**(A)** None

**(B)** `x`

**(C)** `y`

**(D)** `x y`

<br>

(I) final

    *Answer:* B
    
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
