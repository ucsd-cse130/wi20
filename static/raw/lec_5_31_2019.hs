module Lec_5_31_2019 where

data MyNewType = Red | Blue

thing :: MyNewType
thing = Red 


data Result a b = Exception a | Value b
  deriving (Show)

type Funky = Result Integer String

funkys :: [Funky]
funkys = [Exception 0, Value "zero"] 

-- evalE [] (1 + 2)         ==> Value (VInt 3)
-- evalE [] (throw (1+2))   ==> Exception (VInt 3) 
-- evalE [] ((throw 1) + 2) ==> Exception (VInt 1)

-- >>> eval' (Plus (Number 1) (Number 2)) 
-- Right 3
--




-- >>> eval' (Throw (Plus (Number 1) (Number 2)))
-- Left 3
--

-- >>> eval' (Plus (Throw (Number 1)) (Number 2)) 
-- Left 1
--

-- >>> eval (Plus (Number 1) (Throw (Number 2)))


-- <interactive>:3849:2-34: error:
--     • No instance for (Show (Result String Int))
--         arising from a use of ‘print’
--     • In a stmt of an interactive GHCi command: print it
-- <BLANKLINE>
-- <interactive>:3850:15-40: error:
--     • Couldn't match type ‘Expr’ with ‘[Char]’
--       Expected type: String
--         Actual type: Expr
--     • In the first argument of ‘Throw’, namely
--         ‘(Plus (Number 1) (Number 2))’
--       In the first argument of ‘eval’, namely
--         ‘(Throw (Plus (Number 1) (Number 2)))’
--       In the expression: eval (Throw (Plus (Number 1) (Number 2)))
-- <BLANKLINE>
-- <interactive>:3851:21-28: error:
--     • Couldn't match type ‘Expr’ with ‘[Char]’
--       Expected type: String
--         Actual type: Expr
--     • In the first argument of ‘Throw’, namely ‘(Number 1)’
--       In the first argument of ‘Plus’, namely ‘(Throw (Number 1))’
--       In the first argument of ‘eval’, namely
--         ‘(Plus (Throw (Number 1)) (Number 2))’
--

type DifficultToShow = Int -> Int

data Expr = Plus Expr Expr | Number Int | Throw Expr
  deriving (Show)

eval :: Expr -> Result Int Int
eval (Number n)   = Value n
eval (Plus e1 e2) = case (eval e1) of
                      Exception ex1 -> Exception ex1
                      Value n1      -> case eval e2 of 
                                         Exception ex2 -> Exception ex2 
                                         Value n2      -> Value (n1 + n2) 
eval (Throw e)    = case (eval e) of 
                      Exception s -> Exception s
                      Value n     -> Exception n


eval' :: Expr -> Either Int Int
eval' (Number n)   = return n
eval' (Plus e1 e2) = do n1 <- eval' e1
                        n2 <- eval' e2
                        return (n1 + n2)
eval' (Throw e)    = do n <- eval' e
                        Left n 





{- 
class JhalaEq a where 
    (===) :: a -> a -> Bool
    (=/=) :: a -> a -> Bool
    (=/=) t1 t2   = not (t1 === t2)

instance JhalaEq MyNewType where 
    (===) Red  Red  = True
    (===) Blue Blue = True
    (===) _    _    = False 

instance Eq MyNewType where
    (==) Red  Red  = True
    (==) Blue Blue = True
    (==) _    _    = False 

instance Show MyNewType where 
  show Red  = "Red"
  show Blue = "Blue"
-}

data Env k v = Default v | Bind k v (Env k v)
  deriving (Show)

-- lookupEnv :: (Eq k) => k -> Env k v -> v 
lookupEnv key (Default val)= val
lookupEnv key (Bind k v rest) 
  | key == k               = v
  | otherwise              = lookupEnv key rest

insert key val env = Bind key val env

