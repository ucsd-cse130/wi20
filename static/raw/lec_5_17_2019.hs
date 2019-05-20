

data Binop = Add | Sub | Mul 
  deriving (Show)

type Env = [(Id, Value)]

type Id = String 

data Expr
  = ENum Int               -- ^ n
  | EBin Binop Expr Expr   -- ^ e1 `op` e2
  | EVar Id                -- ^ x, y, z
  | ELet Id Expr Expr      -- ^ let x = e1 in e2
  deriving (Show)

type Value = Int

eval :: Env -> Expr -> Value
eval _   (ENum n)        = n 
eval env (EBin op e1 e2) = evalOp op (eval env e1) (eval env e2) 
eval env (EVar a)        = evalVar env a 
eval env (ELet x e1 e2)  = eval env1  e2 
  where 
    v1                   = eval env e1
    env1                 = addEnv x v1 env

addEnv :: Id -> Value -> Env -> Env
addEnv x v1 env = (x, v1) : env

{-        
                  -- env
let x = 10 + 10       -- eval env (10 + 10) ==> 20
                  -- eval ["x" := 20] (x + 1) ==> 21
in 
  x + 1
-}

-- >>> eval [] ex1 
-- 


ex1 = ELet "x" (EBin Add (ENum 10) (ENum 10)) 
        (
          EBin Add (EVar "x") (ENum 1)
        )

{-                        -- env
   let x = 10 + 10 
   in                     -- "x" := 20 : env 
     let y = 1000 
     in                   -- "y" := 1000 : "x" := 20 : env 
       x + y 

-}

ex2 = ELet "x" (EBin Add (ENum 10) (ENum 10)) 
        (
          ELet "y" (ENum 1000) 
            (
            EBin Add (EVar "x") (EVar "y")
            )
        )



foo = let x = 0 
      in 
        let y = 100
        in 
          x + y

{- 
eval [("x", 10), ("y", 45)] (EBin Add (EVar "x") (EVar "y"))
 ==> evalOp Add (eval env (EVar "x")) (eval env (EVar "y")) 
     where env = [("x", 10), ("y", 45)]
 ==> evalOp Add (evalVar env "x") (evalVar env "y") 
     where env = [("x", 10), ("y", 45)]
 ==> evalOp Add 10 45 
 ==> 10 + 45 
 ==> 55 




-}

-- because 55 is not in the env
-- because '...' is not in env

-- A: crash
-- B: 10 
-- C: 45 
-- D: 55 




evalVar :: Env -> Id -> Value
evalVar env x = case lookup x env of
                  Nothing  -> error ("unbound: " ++ x)
                  Just val -> val 

-- >>> eval [("x", 10), ("y", 45)] (EBin Add (EVar "x") (EVar "y"))
-- 10

-- >>> eval [("x", 10), ("y", 45)] (EVar "y")
-- 45

-- >>> eval [("x", 10), ("y", 45)] (EVar "hello")
-- error "unbound variable: hello"

-- >>> lookup  "x"  [("x", 10), ("y", 45)] 
-- >>> lookup "y"    [("x", 10), ("y", 45)] 
-- >>> lookup "hell" [("x", 10), ("y", 45)] 

-- [(key, value)] -> key -> value


evalOp :: Binop -> Value -> Value -> Value
evalOp Add v1 v2 = v1 + v2 
evalOp Sub v1 v2 = v1 - v2 
evalOp Mul v1 v2 = v1 * v2 

-- >>> eval (ENum 40)

-- >>> eval (EBin Add (ENum 4) (ENum 12))
-- 16
--

-- >>> eval (EBin Sub (EBin Add (ENum 4) (ENum 12)) (ENum 5))
-- 11
--

-- x + 12 
-- >>> eval (EBin Add (EVar "x") (ENum 12))