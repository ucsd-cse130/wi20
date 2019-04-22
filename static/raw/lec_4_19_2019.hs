
import Prelude hiding (fst, snd, sum, length, lookup, take)
import Data.Char

add3 :: Int -> (Int -> (Int -> Int))
add3 =  \x  -> (\y  -> (\z  -> x + y + z))
-- add3 x y z = x + y + z

-- LISTS
-- >>> range 0 0
-- []
-- >>> range 1 0
-- []
-- >>> range 0 1
-- [0]

-- >>> range 0 3
-- [0, 1, 2]

range :: Int -> Int -> [Int] 
range 3 3 =       []
range 2 3 =     2:[]
range 1 3 =   1:2:[]
range 0 3 = 0:1:2:[]

range i j 
  | i >= j    = [] 
  | otherwise = i : range (i+1) j


-- >>> len []
-- 0

-- >>> len [62]
-- 1

-- >>> len [5, 62]
-- 2

len :: [a] -> Int
len []    = 0 
len (h:t) = 1 + len t

-- >>> take 0 [1,2,3,4]
-- []

-- >>> take 1 [1,2,3,4]
-- [1]

-- >>> take 2 [1,2,3,4]
-- [1, 2]

-- >>> take 200 [1,2,3,4]
-- [1,2,3,4]


take :: Int -> [thing] -> [thing]
take n []     = []
take 0 xs     = []
take n (x:xs) = x : take (n-1) xs

goBabyGo :: Int -> [Int]
goBabyGo n = n : goBabyGo (n+1)