import Prelude hiding (fst, snd, sum, length, lookup, take)
import Data.Char

haskellIsAwesome = if 0 < 1 then True else False

pair = \x y -> 
         \b -> if b then x else y
fst = \p -> p haskellIsAwesome
snd = \p -> p False

sum n = if n == 0 
          then 0 
          else n + sum (n - 1)

cmpSquare x y  |  x > y*y   =  "bigger :)"
               |  x == y*y  =  "same :|"
               |  x < y*y   =  "smaller :("
               




               
               
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



