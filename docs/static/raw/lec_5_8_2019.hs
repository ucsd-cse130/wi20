
import Prelude hiding (map, foldr, filter, sum, length, lookup, take)
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
--
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
-- >>> evens [22, 1,2,3,4,5]
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

map :: (a -> b) -> [a] -> [b]
map op []     = []
map op (x:xs) = op x : map op xs

-- >>> squares' [0..10]
-- [0,1,4,9,16,25,36,49,64,81,100]
--

squares' = map (\x -> x * x)
shout'   = map toUpper

-- >>> sizes ["this", "is", "a", "sentence"]
-- [4,2,1,8]
--

sizes :: [String] -> [Int]
sizes = map L.length



sq = \x -> x * x


-- >>> squares [1,2,3,4,5] 
-- [1,4,9,16,25]

squares :: [Int] -> [Int]
squares []     = []
squares (x:xs) = x*x : squares xs 

tt :: Tree Int
tt = Node (Node (Leaf 1) (Leaf 2))
          (Node (Leaf 3) (Leaf 4))

tt10 = tmap (* 10) tt

tmap :: (a -> b) -> Tree a -> Tree b
tmap op (Leaf x)    = Leaf (op x) 
tmap op (Node l r)  = Node (tmap op l) (tmap op r)










sum :: [Int] -> Int
sum []     = 0
sum (x:xs) = x + sum xs 

sumTR :: Int -> [Int] -> Int
sumTR acc []      = acc 
sumTR acc (x:xs)  = sumTR (acc + x) xs 


-- >>> sumTR 0 [0..10]
-- <interactive>:4928:2-6: warning: [-Wdeferred-out-of-scope-variables]
--     Variable not in scope: sumTR :: Integer -> [Integer] -> IO a0
-- *** Exception: <interactive>:4928:2-6: error:
--     Variable not in scope: sumTR :: Integer -> [Integer] -> IO a0
-- (deferred type error)
--

cat :: [String] -> String 
cat []     = "" 
cat (x:xs) = x ++ cat xs   



len :: [a] -> Int
len []     = 0
len (x:xs) = 1 + len xs


foldr op b []     = b
foldr op b (x:xs) = x `op` (foldr op b xs)

{- 
foldr op b (x1:x2:x3:[])
 ==>  x1 `op` (foldr op b (x2:x3:[]))
 ==>  x1 `op` (x2 `op` foldr op b (x3:[]))
 ==>  x1 `op` (x2 `op` (x3 `op` (foldr op b [])))
 ==>  x1 `op` (x2 `op` (x3 `op` b))

 op == :
 b  == []
 ==>  x1 : (x2 : (x3 : []))

-}


len' = foldr (\_ n -> 1 + n) 0 

-- >>> len' "september"
-- 9
--




cat' = foldr (++) ""
sum' = foldr (+)  0 


-- >>> cat' ["this", "is", "the"]
-- "thisisthe"
--
-- >>> sum' [0..10]
-- 55
--


-- >>> cat ["this", "is", "the", "end"]
-- "thisistheend"
--



