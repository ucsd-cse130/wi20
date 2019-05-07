
import Prelude hiding (filter, sum, length, lookup, take)
import Data.Char
import Debug.Trace
import Text.Printf 
import qualified Data.List as L

data Tree a 
  = Leaf a 
  | Node (Tree a) (Tree a) 
  deriving (Show)

tree :: Tree Int
tree = Node 
        (Node (Node (Leaf 1) (Leaf 2)) (Leaf 3))
        (Node (Leaf 4) (Leaf 5))

-- >>> countLeaves tree
-- 5
countLeaves :: Tree a -> Int
countLeaves (Leaf _)   = 1 
countLeaves (Node l r) = countLeaves l + countLeaves r

addLeaves :: Tree Int -> Int
addLeaves (Leaf n)   = n
addLeaves (Node l r) = addLeaves l + addLeaves r 

maxLeaf :: Tree Int -> Int 
maxLeaf (Leaf n)   = n
maxLeaf (Node l r) = max (maxLeaf l) (maxLeaf r) 

height :: Tree a -> Int
height (Leaf _)   = 0
height (Node l r) = 1 + max (height l) (height r)

toList :: Tree a -> [a]
toList (Leaf n)   = [n]
toList (Node l r) = (toList l) ++ (toList r) 


-- >>> evens []
-- []
-- >>> evens [1,2,3,4,5]
-- [2,4]

evens :: [Int] -> [Int] 
evens []      = [] 
evens (x:xs)  
  | isEven x  = x : evens xs
  | otherwise =     evens xs 

days :: [String] -> [String]
days []       = []
days (w:ws)
  | isDay w   = w : days ws
  | otherwise =  days ws 

filter :: (stuff -> Bool)  -> [stuff] -> [stuff] 
filter papa []    = []
filter papa (x:xs)
  | papa x        = x : filter papa xs
  | otherwise     =     filter papa xs 

-- evens = common * 'isEven'  
evens' = filter isEven  

-- days  = common * 'isDay'
days'  = filter isDay

-- d.r.y.  == "don't repeat yourself"




isEven :: Int -> Bool
isEven x = (x `mod` 2) == 0 
 
-- >>> days ["cat", "dog", "monday", "friday", "lunch"]
-- <interactive>:2848:2-5: warning: [-Wdeferred-out-of-scope-variables]
--     Variable not in scope: days :: [[Char]] -> IO a0
-- *** Exception: <interactive>:2848:2-5: error:
--     Variable not in scope: days :: [[Char]] -> IO a0
-- (deferred type error)
--
-- >>> days []
-- []

isDay :: String -> Bool
isDay s = L.isSuffixOf "day" s  



shout :: [Char] -> [Char]
shout []     = []
shout (c:cs) = toUpper c  : shout cs

-- >>> squares [1,2,3,4,5] 

squares' = bar (\x -> x * x)
shout'   = bar toUpper

sq = \x -> x * x


bar f []     = []
bar f (x:xs) = f x : bar f xs

-- >>> squares [1,2,3,4,5] 

squares []     = []
squares (x:xs) = x*x : squares xs 