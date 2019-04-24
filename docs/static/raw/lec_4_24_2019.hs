
import Prelude hiding (sum, length, lookup, take)
import Data.Char
import Debug.Trace

add3Tuple :: (Int, Int, Int) -> Int
add3Tuple triple = let (x, y, z) = triple
                   in x + y + z

-- add3Tuple (x, y, z) = x + y + z

add3 :: Int -> (Int -> (Int -> Int))
add3 =  \x  -> (\y  -> (\z  -> x + y + z))
-- add3 x y z = x + y + z

-- LISTS
-- >>> range 0 0
-- []
-- >>> range 1 0
-- []
-- >>> range 0 5
-- [0,1,2,3,4]
--

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


-- take :: Int -> [thing] -> [thing]
take n []     = []
take 0 xs     = []
take n (x:xs) = x : (take (n-1) xs)
  where
    msg       = "trace (n, xs) = " ++ show (n, xs)

goBabyGo :: Int -> [Int]
goBabyGo n = n : goBabyGo (n+1)

-------------------------------------------------------------------------------
-- | How to debug Haskell code
-------------------------------------------------------------------------------

fact :: Int -> Int 
fact n = let res  = if n == 0 then 1 else n * fact (n - 1) 
         in trace ("fact: n = " ++ show n ++ " result = " ++ show res) res


-- >>> shout "like this" 
-- "LIKE THIS" 

shout :: [Char] -> [Char] 
-- shout []        = []
-- shout (c:chars) = toUpper c : shout chars

-- def shout(chars): return [ toUpper(c) for c in chars ]
shout chars = [ toUpper c | c <- chars ] 

fac 0 = 1 
fac n = ({- trace ("n = " ++ show n) -} n) * fac (n-1)