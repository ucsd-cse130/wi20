module Lec_2_12_20 where

import Prelude hiding (map, filter)

data Tree = Leaf | Node Int Tree Tree 
  deriving (Eq, Show)

node1 = Node 1 node2 node4
node2 = (Node 2 node3 Leaf)
node3 = (Node 3 Leaf  Leaf)
node4 = (Node 4 Leaf  Leaf)

tot :: Tree -> Int
tot Leaf         = 0
tot (Node v l r) = v + tot l + tot r

size :: Tree -> Int
size Leaf         = 1
size (Node v l r) = 1 + size l + size r

sizeN :: Tree -> Int
sizeN Leaf         = 0
sizeN (Node v l r) = 1 + sizeN l + sizeN r

depth :: Tree -> Int
depth Leaf         = 0
depth (Node v l r) = 1 + max (depth l) (depth r)

treeString :: Tree -> String
treeString t = show t

-- >>> filter []
-- []
--
-- >>> fourLetterWords ["i","must","do","work"] 
-- ["must","work"]
--

-- filter :: [String] -> [String]
-- filter []     = [] 
-- filter (x:xs) 
--   | isFourLetter x = x : filter xs
--   | otherwise      =     filter xs 

isFourLetter x = length x == 4

-- >>> evens [] 
-- []
--

-- >>> evens [1..10] 
-- [2,4,6,8,10]
--

-- filter       :: [Int] -> [Int]
-- filter []      = []
-- filter (x:xs) 
--   | isEven x  = x : filter xs
--   | otherwise =     filter xs

evens xs           = filter (\n -> n `mod` 2 == 0) xs
fourLetterWords xs = filter (\w -> length w == 4)  xs 

filter :: (a -> Bool) -> [a] -> [a] 
filter test []      = []
filter test (x:xs) 
  | test x    = x : filter test xs
  | otherwise =     filter test xs

-- >>> isEven 13
-- False
--

isEven :: Int -> Bool
isEven n = (n `mod` 2) == 0 



---------

-- >>> makePaths "/home/rjhala/" ["alice", "bob", "mickeymouse"]
-- ["/home/rjhala/alice","/home/rjhala/bob","/home/rjhala/mickeymouse"]
--

-- makePaths :: String -> [String] -> [String]
-- makePaths base xs = case xs of
--                          []     -> [] 
--                          h:rest -> (base ++ h) : makePaths base rest
--                                   -- prepend BASE

fooFun x = x + 1

-- barFun  = fooFun  
barFun = fooFun


makePaths base users     = map (\h -> base ++ h) users
shiftPoints off students = map (\h -> (fst h, snd h + off)) students

map :: (a -> b) -> [a] -> [b]
map transform xs = case xs of
                        []       -> [] 
                        (h:rest) -> (transform h) : map transform rest



-- shiftPoints :: Int -> [(String, Int)] -> [(String, Int)] 
-- shiftPoints off students = case students of 
--                             []       -> []
--                             (h:rest) -> (fst h, snd h + off) : shiftPoints off rest  
--                                                     -- add OFFSET


-- aka `map` 



-- parameterize how you TRANSFORM each element of list

