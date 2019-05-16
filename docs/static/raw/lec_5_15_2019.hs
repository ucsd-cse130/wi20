

data Binop = Add | Sub | Mul 
  deriving (Show)

type Env = [(Id, Value)]

type Id = String 

data Expr
  = ENum Int               -- ^ n
  | EBin Binop Expr Expr   -- ^ e1 `op` e2
  | EVar Id                -- ^ x, y, z
  deriving (Show)

type Value = Int

eval :: Env -> Expr -> Value
eval env (ENum n)        = n 
eval env (EBin op e1 e2) = evalOp op (eval env e1) (eval env e2) 
eval env (EVar x)        = ???

foo xs = case xs of 
  [] -> e1
  _  -> e2

foo [] = e1
foo xs = e2

evalOp :: Binop -> Value -> Value -> Value
evalOp Add v1 v2 = v1 + v2 
evalOp Sub v1 v2 = v1 - v2 
evalOp Mul v1 v2 = v1 * v2 

-- >>> eval (ENum 4)
-- 4
--

-- >>> eval (EBin Add (ENum 4) (ENum 12))
-- 16
--

-- >>> eval (EBin Sub (EBin Add (ENum 4) (ENum 12)) (ENum 5))
-- 11
--

-- x + 12 
-- >>> eval (EBin Add (EVar "x") (ENum 12))