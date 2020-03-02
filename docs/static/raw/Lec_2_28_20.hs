module Lec_2_28_20 where

import Prelude hiding (lookup)

incr :: Int -> Int
incr x = x + 1

data Binop = Add                  -- ^ `+`
           | Sub                  -- ^ `-`
           | Mul                  -- ^ `*`
  deriving (Eq, Show)

type Id = String

data Expr  = ENum Int              -- ^ n
           | EVar Id               -- ^ x,y,z,...
           | EBin Binop Expr Expr  -- ^ e1 `op` e2
           | ELet Id    Expr Expr  -- ^ let x = e1 in e2
           | ELam Id    Expr       -- ^ \x -> e 
           | EApp Expr  Expr       -- ^ (e1 e2)
  deriving (Show)

data Value = VInt Int
           | VFun Id Expr
  deriving (Show)

type FunValue = (Id, Expr)

type Env = [(Id, Value)]

{-
                              -- ENV
    let incr = \x -> x + 1 
                              -- ("incr" := < "x", x + 1 > ) : ENV  
    in 
      incr 10
                              -- How to USE  ?Q1 to get back 11 as result?
    
 -}

-- How about "eval" body (x+1) after defining formal "x" to be the argument 10 
-- let x = 10 in x + 1 


-- NEED TO KNOW: incr takes in an "integer" input and increments it

exIncr :: Expr
exIncr = ELet "incr" (ELam "x" (EBin Add (EVar "x") (ENum 1)))  
            (EApp (EVar "incr") (ENum 10)) 

exIncrWithC :: Expr
exIncrWithC = 
  ELet "c" (ENum 1) 
    (ELet "incr" (ELam "x" (EBin Add (EVar "x") (EVar "c")))  
                 (EApp (EVar "incr") (ENum 10)))

exIncrWithC_FLIP :: Expr
exIncrWithC_FLIP = 
  ELet "c" (ENum 1)
   ( ELet "incr" (ELam "x" (EBin Add (EVar "x") (EVar "c")))  
      ( ELet "c" (ENum 100) 
          ( EApp (EVar "incr") (ENum 10)
          )
      )
   )

funky n = n : funky (n + 1)

-- >>> funky 0 
-- funky 0 = 0 : 1 : funky 2 

-- >>> eval [] exIncrWithC_FLIP
-- VInt 110
--

{-
                          -- ENV
let c = 1  
in                        -- (c, 1) : ENV
 let inc = \x -> x + c
 in                        -- (inc, <> ): ("c", 1) : ENV
    let c = 100
    in                     -- ("c", 100) : ("inc", <"x", x + c>) : (c, 1) : ENV
       inc 10


quiz =  
  let inc = \x -> x + c
  in                        -- ("c", 1) : ENV
     let c = 1
     in                     -- ("c", 1) : ("inc", <"x", x + c>) :  ENV
        inc 1

-}

-- >>> eval [] exIncrWithC
-- VInt 11
--

{- 
eval [] (ELet "incr" (ELam "x" (X_PLUS_ONE)) E2)
==> eval [("incr", VFun "x" X_PLUS_ONE]) E2 


-}


-- >>> eval [] exIncr
-- VInt 11
--









eval :: Env -> Expr -> Value
eval env (ENum n)       = VInt n
eval env (EBin o e1 e2) = evalOp o (eval env e1) (eval env e2)
eval env (EVar x)       = lookup env x 
eval env (ELet x e1 e2) = eval newEnv e2
  where 
    newEnv              = (x, v1) : env
    v1                  = eval env e1 

eval env (ELam x e)     = VFun x e

eval env (EApp e1 e2)   = eval env adityaExpr
  where 
    adityaExpr          = ELet x e2 body 
    VFun x body         = eval env e1

evalOp :: Binop -> Value -> Value -> Value
evalOp Add (VInt v1) (VInt v2) = VInt (v1 + v2) 
evalOp Sub (VInt v1) (VInt v2) = VInt (v1 - v2) 
evalOp Mul (VInt v1) (VInt v2) = VInt (v1 * v2)
evalOp _   x         y         = error "Oh no!! type error!" 

lookup :: Env -> Id -> Value 
lookup ((k,val):rest) x 
  | x == k    = val 
  | otherwise = lookup rest x
lookup [] x    = error ("Variable: " ++ x ++ " is not in scope!!!")


-- >>> eval [] (EBin Sub (EBin Add (ENum 4) (ENum 12)) (ENum 5))
-- VInt 11
--

-- let x = 10 in x + 1

-- let yyy = 72 
-- in 
--    let x = y + 10 
--    in 
--       x + y
-- >>> eval [] (ELet "yy" (ENum 72) (ELet "x" (EBin Add (EVar "y") (ENum 10)) (EBin Add (EVar "x") (EVar "y"))))
-- *** Exception: Variable: y is not in scope!!!
-- CallStack (from HasCallStack):
--   error, called at /Users/rjhala/teaching/130-wi20/static/raw/Lec_2_28_20.hs:44:18 in main:Lec_2_28_20
--

example :: Expr
example = EBin Sub (EBin Add (EVar "x") (EVar "y")) (EVar "z")

exEnv :: Env
exEnv =  [("x", VInt 20), ("y", VInt 12), ("z", VInt 5)]

{- EX 1

               <--- [] 
let x = 10 
in             <--- [(x := 10)]
  x + 1



               <--- [] 
let x = 0
in             <--- [(x := 0)]
  let x = 100
  in           <--- [(x := 100), (x := 0)]        [(x:= 100)]             
    x + 1

               <--- []
let x = 0
in             <--- [x=0]
  (let x = 100 
   in          <--- [x=100]
     x + 1
  )
  +
  x

-}

{-
let x = 0 in 
let y = 12 in
let z = x - y in
  (x + y) - z

-}
-- >>> eval exEnv example
-- 7
--

-- >>> eval (EVar "zebra")


-- >>> eval zebra

{-



              -- ENV
let x = 0
in            -- ??? what env to use for `x + 1`?
  x + 1

(C)   ("x" := 0) : ENV





                 -- ENV
   let x = E1 
   in            -- ("x" := eval ENV E1) : ENV ==== NEW_ENV 
     E2










                -- ENV
let x = E1
in              -- ("x" := ???) :  ENV
  (let x = 100
   in           -- ("x" := 100) : ("x" := 0) : ENV
                -- ("x" := 100) :              ENV
    x + 1
  ) 
  + 
  x

  -}