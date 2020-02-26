module Lec_2_24_20 where

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
  deriving (Show)

type Value = Int

type Env = [(Id, Value)]


eval :: Env -> Expr -> Value
eval env (ENum n)       = n
eval env (EBin o e1 e2) = evalOp o (eval env e1) (eval env e2)
eval env (EVar x)       = lookup env x 

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




