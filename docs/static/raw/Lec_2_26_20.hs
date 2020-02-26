module Lec_2_26_20 where

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
  deriving (Show)

type Value = Int

type Env = [(Id, Value)]

eval :: Env -> Expr -> Value
eval env (ENum n)       = n
eval env (EBin o e1 e2) = evalOp o (eval env e1) (eval env e2)
eval env (EVar x)       = lookup env x 
eval env (ELet x e1 e2) = eval newEnv e2
  where 
    newEnv              = (x, v1) : env
    v1                  = eval env e1 


evalOp :: Binop -> Value -> Value -> Value
evalOp Add v1 v2 = v1 + v2 
evalOp Sub v1 v2 = v1 - v2 
evalOp Mul v1 v2 = v1 * v2

lookup :: Env -> Id -> Value 
lookup ((k,val):rest) x 
  | x == k    = val 
  | otherwise = lookup rest x
lookup [] x    = error ("Variable: " ++ x ++ " is not in scope!!!")


-- >>> eval [] (EBin Sub (EBin Add (ENum 4) (ENum 12)) (ENum 5))
-- 11
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
--   error, called at /Users/rjhala/teaching/130-wi20/static/raw/Lec_2_26_20.hs:45:18 in main:Lec_2_26_20
--

free = 
  let y = (let x = 2
           in x      ) + x
  in
    let x = 3
    in
      x + y
  
  
example :: Expr
example = EBin Sub (EBin Add (EVar "x") (EVar "y")) (EVar "z")

exEnv :: Env
exEnv =  [("x", 20), ("y", 12), ("z", 5)]

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