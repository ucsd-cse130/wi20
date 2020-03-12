{-# LANGUAGE DeriveFunctor #-}

module Lec_3_11_20 where 

import Prelude hiding (showList)

-- inc :: Int -> Int 
inc :: (Num a) => a -> a
inc x = x + 1

bloop = inc 12.2

-- >>> showList [1, 2, 3]
-- ["1","2","3"]
--

showList :: [Int] -> [String]
showList = mapList show

-- showList        :: [Int] -> [String]
-- showList []     =  []
-- showList (n:ns) =  show n : showList ns

-- >>> sqrList [1, 2, 3]
-- [1,4,9]
--

sqrList :: [Int] -> [Int]
sqrList = mapList (\n -> n ^ 2)
-- sqrList        :: [Int] -> [Int]
-- sqrList []     =  []
-- sqrList (n:ns) =  n^2 : sqrList ns

----
data Tree a
  = Leaf
  | Node a (Tree a) (Tree a)
  deriving (Show, Functor)

{- 
      2 
    /  \
    1  3
   / \ /\ 
   L L L L 

-}

showTree :: Tree Int -> Tree String
showTree Leaf         = Leaf 
showTree (Node x l r) = Node x' l' r' 
  where 
    x' = (show x) 
    l' = (showTree l) 
    r' = (showTree r)

sqrTree :: Tree Int -> Tree Int
sqrTree Leaf         = Leaf 
sqrTree (Node x l r) = Node x' l' r' 
  where 
    x' = (x^2) 
    l' = (sqrTree l) 
    r' = (sqrTree r)



mapList :: (a -> b) -> [a] -> [b]
mapList f []     = [] 
mapList f (x:xs) = f x : mapList f xs

mapTree :: (a -> b) -> Tree a -> Tree b 
mapTree f Leaf         = Leaf 
mapTree f (Node x l r) = Node x' l' r' 
  where 
    x' = (f x) 
    l' = (mapTree f l) 
    r' = (mapTree f r)


-- mapList :: (a -> b) -> List a -> List b

-- mapTree :: (a -> b) -> Tree a -> Tree b 

class Mappable thing where
  mapper :: (a -> b) -> thing a -> thing b  

{-
class Functor thing where
  fmap :: (a -> b) -> thing a -> thing b  
 -}


instance Mappable [] where 
  mapper = mapList 

instance Mappable Tree where 
  mapper = mapTree

-- Functor 

showThing :: (Functor thing) => thing Int -> thing String
showThing t = fmap show t

sqrThing :: (Functor thing) => thing Int -> thing Int
sqrThing t = fmap (\n -> n ^ 2) t



-- >>> showThing [1, 2, 3]
-- ["1","2","3"]
--

-- >>> showThing (Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf))
-- Node "2" (Node "1" Leaf Leaf) (Node "3" Leaf Leaf)
--

-- >>> sqrThing [1,2,3,4]
-- [1,4,9,16]
--


-- >>> sqrThing (Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf))
-- Node 4 (Node 1 Leaf Leaf) (Node 9 Leaf Leaf)
--


----

data Expr
  = Number Int
  | Plus   Expr Expr
  | Div    Expr Expr
  deriving (Show)

data Result v 
  = ErrorMsg String 
  | Value v  
  deriving (Show)

eval :: Expr -> Result Int
eval (Number n)   = Value n
eval (Plus e1 e2) = do n1 <- eval e1
                       n2 <- eval e2
                       Value (n1 + n2)

eval (Div  e1 e2) = do n1 <- eval e1
                       n2 <- eval e2
                       if n2 == 0 
                          then ErrorMsg ("YIX: dbz due to " ++ show e2)  
                          else Value (n1 `div` n2)

instance Functor Result where
  fmap _ (ErrorMsg e) = ErrorMsg e
  fmap f (Value v)    = Value (f v)

instance Applicative Result where
  pure x = Value x

instance Monad Result where 
  (>>=) = foo


{- 

e1 >>= \n1 -> 
  e2 >>= \n2 -> 
    e3 >>= \n3 -> 
      STUFF

do n1 <- e1
   n2 <- e2
   n3 <- e3
   STUFF



-}


foo :: (Result a) -> (a -> Result b) -> Result b
foo e f =  
  case e of 
    ErrorMsg err -> ErrorMsg err
    Value val    -> f val 


-- >>> eval (Div (Number 6) (Number 2))
-- Value 3
--

-- >>> eval (Div (Number 6) (Number 0))
-- ErrorMsg "YIX: dbz due to Number 0"
--

