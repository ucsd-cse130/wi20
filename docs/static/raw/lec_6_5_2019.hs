{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE DeriveFunctor        #-}

module Lec_6_5_2019 where

import Prelude hiding ((>>=), showList)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- >>> showList [1, 2, 3]

showList        :: [Int] -> [String]
showList []     =  []
showList (x:xs) =  show x : showList xs

-- >>> sqrList' [1, 2, 3, 4, 5]
-- [1,4,9,16,25]

sqrList    :: [Int] -> [Int]
sqrList xs = mapL (\n -> n^2) xs

mapL :: (a -> b) -> [a] -> [b]
mapL op []     = []
mapL op (x:xs) = op x : mapL op xs




showList' :: [Int] -> [String]
showList' xs = mapL (\n -> show n) xs

sqrList' :: [Int] -> [Int]
sqrList'  xs = map (\n -> n ^ 2)  xs

-------------------------------------------------------------------------------
data Tree a
  = Leaf
  | Node a (Tree a) (Tree a)
  deriving (Show, Functor)

-------------------------------------------------------------------------------
{-
               2 
              / \
             1   3  
            / \ / \
           L  L L  L

              "2" 
              / \
            "1" "3"  
            / \ / \
           L  L L  L


           -}
-- >>> showTree (Node 2   (Node 1   Leaf Leaf) (Node 3 Leaf Leaf))
--              (Node "2" (Node "1" Leaf Leaf) (Node "3" Leaf Leaf))


showTree :: Tree Int -> Tree String
showTree = mapTree (\v -> show v)
-- showTree Leaf         = Leaf
-- showTree (Node v l r) = Node (show v) (showTree l) (showTree r)  

sqrTree :: Tree Int -> Tree Int
sqrTree  = mapTree (\v -> v ^ 2)
-- sqrTree Leaf         = Leaf
-- sqrTree (Node v l r) = Node (v^2) (sqrTree l) (sqrTree r)  

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree op Leaf = Leaf
mapTree op (Node v l r) = Node (op v) (mapTree op l) (mapTree op r) 






class Mappable thing where
  gmap :: (a -> b) -> thing a -> thing b

mapList = mapL

instance Mappable [] where
  gmap = mapList 

instance Mappable Tree where
  gmap = mapTree


instance Mappable Result where
  -- gmap :: (a -> b) -> Result a -> Result b
  gmap op (Error msg) = Error msg
  gmap op (Value x)   = Value (op x)


-- >>> sqrTree (Node 2 (Node 1 Leaf Leaf) (Node 3 Leaf Leaf))
-- (Node 4 (Node 1 Leaf Leaf) (Node 9 Leaf Leaf))


-------------------------------------------------------------------------------




-- showTree' t = mapTree (\n -> show n) t

-- sqrTree'  t = mapTree (\n -> n ^ 2)  t


-- mapL :: (a -> b) -> [a] -> [b]

-- mapEnv  :: (a -> b) -> Env k a -> Env k b

-- mapTree :: (a -> b) -> Tree a -> Tree b







-------------------------------------------------------------------------------
data Expr
  = Number Int
  | Plus   Expr Expr
  | Div    Expr Expr
  deriving (Show)

data Result a 
  = Error String 
  | Value a
  deriving (Show, Functor)



(>>=) :: Result a -> (a -> Result b) -> Result b 
(Error msg) >>= _ = Error msg
(Value x)   >>= f = f x



eval :: Expr -> Result Int
eval (Number n)   = Value n
eval (Plus e1 e2) = eval e1 >>= \v1 ->
                      eval e2 >>= \v2 -> 
                        Value (v1 + v2)
eval (Div e1 e2)  = eval e1 >>= \v1 ->
                      eval e2 >>= \v2 -> 
                        if v2 == 0 
                          then Error ("yikes dbz:" ++ show e2)
                          else Value (v1 `div` v2)

foldR :: (a -> b -> b) -> b -> [a] -> b
foldR op b []     = b 
foldR op b (x:xs) = x `op` (foldR op b xs) 

-- map f [x1,x2,x3] = [f x1, f x2, f x3]

-- foldR f b [x1,x2,x3] = x1 `f` (x2 `f` (x3 `f` b))

-- >>> eval (Div (Number 6) (Number 2))