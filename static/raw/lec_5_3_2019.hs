
import Prelude hiding (sum, length, lookup, take)
import Data.Char
import Debug.Trace
import Text.Printf 

data Tree 
  = Leaf Int 
  | Node Tree Tree 
  deriving (Show)

tree :: Tree
tree = Node 
        (Node (Node (Leaf 1) (Leaf 2)) (Leaf 3))
        (Node (Leaf 4) (Leaf 5))

-- >>> countLeaves tree
-- 5
countLeaves :: Tree -> Int
countLeaves (Leaf _)   = 1 
countLeaves (Node l r) = countLeaves l + countLeaves r

addLeaves :: Tree -> Int
addLeaves (Leaf n)   = n
addLeaves (Node l r) = addLeaves l + addLeaves r 

maxLeaf :: Tree -> Int 
maxLeaf (Leaf n)   = n
maxLeaf (Node l r) = max (maxLeaf l) (maxLeaf r) 

height :: Tree -> Int
height (Leaf _)   = 0
height (Node l r) = 1 + max (height l) (height r)

toList :: Tree -> [Int]
toList (Leaf n)   = [n]
toList (Node l r) = (toList l) ++ (toList r) 

data Expr 
  = ENum Double 
  | EAdd Expr Expr
  | ESub Expr Expr
  | EMul Expr Expr
  deriving (Show)

-- (4.0 + 2.9) * (3.78 - 5.92)
expr0 :: Expr
expr0 = EMul
          (EAdd (ENum 4.0)  (ENum 2.9))
          (ESub (ENum 3.78) (ENum 5.92))

eval :: Expr -> Double
eval (ENum d)     = d 
eval (EAdd e1 e2) = e1 + e2 

-- eval (EAdd e1 e2) = eval e1 + eval e2
-- eval (ESub e1 e2) = eval e1 - eval e2 
-- eval (EMul e1 e2) = eval e1 * eval e2 