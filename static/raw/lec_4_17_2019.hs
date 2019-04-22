
module Lec where
  
import Prelude hiding (fst, snd, sum, length, lookup, take)
import Data.Char


haskellIsAwesome = if 0 < 1 then True else False

fst = \p -> p haskellIsAwesome
snd = \p -> p False
{-
pair = \x y -> \b -> if b then x else y

pair x = \y -> \b -> if b then x else y

pair x y = \b -> if b then x else y
-}
pair x _ True  = x 
pair _ y False = y 

foo :: Bool -> String 
foo False = "false" 
foo _     = "true" 

-- >>> foo True
-- "true"
--

-- >>> foo False
-- "false"
--

------------------------

-- >>> order 10 20 
-- "less than"

-- >>> order 20 20 
-- "equal"
--

-- >>> order 20 100 
-- "less than"
--

-- in1 -> int2 -> res 
order :: Int -> Int -> String
order x y 
  | x <  y  = "less than"
  | x >  y  = "greater than" 
  | x == y  = "equal" 

{- 
order x  y  = if x < y 
                then "less than"
                else if x == y 
                       then "equal"
                       else "greater than"

order 10 20 =  "less than"
order 10 10 = "equal"
order 20 20 = "equal"
order 20 10 = "greater than" 

  -}


-- >>> cmpSquare 10 20
-- "smaller :("
--



cmpSquare x y  
  |  x > y*y   =  "bigger :)"
  |  x == y*y  =  "same :|"
  |  x < y*y   =  "smaller :("
  












{-
sum n = if n == 0 
          then 0 
          else n + sum (n - 1)

sum n 
  | n == 0 = 0 
  | True   = n + sum(n-1) 
 -}

-- >>> silly 3
-- 16
--

-- silly 3 == sum 3 + 1 == 7 

silly :: Int -> Int
silly a = let t2 = 1 + t1
              t1 = sum a 
          in 
              t1 + t2
 
billy :: Int -> Int
billy a = t1 + t2
  where 
    t2  = 1 + t1
    t1  = sum a 
 
              

sum :: Int -> Int
sum 0 = 0 
sum n = let n = sum (n-1) in n + n

-- >>> sum 3

-- == let n = sum 2 in n + n 
-- == sum 2 + sum 2 
-- == (let n = sum 1 in n + n) + (let n = sum 1 in n + n) 
-- == sum 1 + sum 1   + sum 1 + sum 1  
-- == sum 0 + sum 0 + sum 0 + sum 0 + sum 0 + sum 0 + sum 0 + sum 0  
-- == 0 

-- QUIZ: what is the result of 'sum 3' ?

-- A. "go forever"
-- B. 6 
-- C. somehow crash and burn
-- D. 0 
-- E. 37



-- >>> sum 3
-- 15
--



-- sum 3 
-- == 3 + sum 2  
-- == 3 + 2 + sum 1 
-- == 3 + 2 + 1 + sum 0 
-- == 3 + 2 + 1 + 0 
-- == 6



-- >>> otherwise 
-- True
--


-- >>> sum 30              
-- 465
--

-- >>> negait True
-- False
--

negait True  = False
negait False = True 


-- wierd = 0 1 


{- 
message = if haskellIsAwesome
            then "I love CSE 130"
            else "I'm dropping CSE 130"               

factorial :: Integer -> Integer            
factorial n
  | n < 2      = 1
  | otherwise  = n * factorial (n - 1)
  

  
  
  
  
  

myList :: [Int]
myList = [1, 2, 3, 4]

myList' :: String
myList' = "hello"

myList''' :: [[Char]]
myList''' = []

-- | Length of the list
length :: [Int] -> Int
length [] = 0
length (_:xs) = 1 + length xs

lookup :: String -> [(String, Int)] -> Int
lookup _ []   = 0
lookup x ((k,v) : ps)
  | x == k    = v
  | otherwise = lookup x ps

comp1 s = [toUpper c | c <- s]  -- Convert string s to upper case

comp2 = [(i,j) | i <- [1..3],
                 j <- [1..i] ] -- Multiple generators
         
comp3 = [(i,j) | i <- [0..5],
                 j <- [0..5],
                 i + j == 5] -- Guards   


                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
                 
-- | List of integers from n upto m
upto :: Integer -> Integer -> [Integer]
upto n m
  | n > m     = []
  | otherwise = n : (upto (n + 1) m) 

-- | First n elements of the list
take :: Int -> [a] -> [a]
take 0 _      = []
take _ []     = []
take n (x:xs) = x:(take (n - 1) xs)     




-}