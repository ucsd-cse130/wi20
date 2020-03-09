module Lec_3_2_20 where

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
           | VFun Id Expr Env
  deriving (Show)

type FunValue = (Id, Expr)

type Env = [(Id, Value)]

{- 
                            -- EA: ENV
let c = 1
in                          -- EB: (c := 1) : ENV 
   let inc = \x -> x + c
   in                       -- EC: (inc := <"x", "x + c", EB>) : (c := 1) : ENV
      let d = 100
      in                    -- ED: (c := 100) : (inc := <code-for-inc>) : (c := 1) : ENV
        inc d 
                            code-for-arg = E2
                            eval env E1 ---> VFun x body frozenEnv
                            eval env E2 ---> v2
                            -- eval ((x := v2) : frozenEnv) body 
                            -- code-for-inc = VFun "x" (x + c) EB

  QUIZ: which is the right env to eval "adityExpr"? 
        (A) EA    (B) EB   (C) EC     (E) other
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
      ( -- ELet "c" (ENum 100) 
          ( EApp (EVar "incr") (EVar "c")
          )
      )
   )

exAdd_10_20 = 
  ELet "add" (ELam "x" (ELam "y" (EBin Add (EVar "x") (EVar "y")))) 
    (
      ELet "add_10" (EApp (EVar "add") (ENum 10))
        (
          ELet "add_20" (EApp (EVar "add") (ENum 20))
            (
              EBin Add (EApp (EVar "add_10")  (ENum 100)) (EApp (EVar "add_20")  (ENum 1000))
            )
        )
    )

-- >>> eval [] exAdd_10_20
-- VInt 1130
--



{- 
                               -- ENV
let add = \x -> (\y -> x + y)
in                             -- ("add" := <"x", "\y -> (x + y)", ENV) : ENV
  add 10
                                  eval ((x:= 10):ENV) BODY


QUIZ
                                    -- ENV
let add = \x -> (\y -> x + y)
in                                  -- ("add" := CLOSURE) : ENV
  let add10 = add 10
  in                                -- ("add_10" := ???) : ("add" := CLOSURE) : ENV
    let add20 = add 20
    in                              -- (add_20 := <"y", (x+y), ((x:= 20):ENV)>) : (add_10 := <"y", (x+y), ((x:= 10):ENV)>) : ENV
      (add 10 100) + (add 20 1000)

-}



-- >>> eval [] exIncrWithC_FLIP
-- VInt 2
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


-- >>> eval [] (ELet "x" (ENum 7) (EApp (EVar "x") (ENum 4)))
-- *** Exception: EVar "x"is not a callable object!
-- CallStack (from HasCallStack):
--   error, called at /Users/rjhala/teaching/130-wi20/static/raw/Lec_3_2_20.hs:134:44 in main:Lec_3_2_20
--









eval :: Env -> Expr -> Value
eval env (ENum n)       = VInt n
eval env (EBin o e1 e2) = evalOp o (eval env e1) (eval env e2)
eval env (EVar x)       = lookup env x 
eval env (ELet x e1 e2) = eval newEnv e2
  where 
    newEnv              = (x, v1) : env
    v1                  = eval env e1 

eval env (ELam x e)     = VFun x e env

eval env (EApp e1 e2)   = case eval env e1 of 
                            VFun x body frozenEnv 
                                        -> let v2 = eval env e2 
                                           in
                                             eval ((x, v2) : frozenEnv) body
                            _           -> error (show e1 ++ "is not a callable object!")

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
