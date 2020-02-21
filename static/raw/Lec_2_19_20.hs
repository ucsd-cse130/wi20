module Lec_2_19_20 where

import Prelude hiding (map, filter)
import Data.Char (toUpper)

-- >>> shout "hello"
-- "HELLO"
--

-- >>> squares [1..10]
-- [1,4,9,16,25,36,49,64,81,100]
--


shout cs   = map toUpper cs  

squares ns = map (\n -> n * n)     ns

wordLens ws = map length ws

-- >>> wordLens ["I", "am", "happy"]
-- [1,2,5]
--
-- will not cover a conversion from Char -> Int ? 
-- map :: (Char -> Char) -> [Char] -> [Char]
-- map :: (Int -> Int) -> [Int] -> [Int]
-- map :: (a -> a) -> [a] -> [a]
map :: (t -> a) -> [t] -> [a] 
map f []     = []
map f (x:xs) = f x : map f xs

{- Q:  will error be at:   (A) line 15, (B) 17,    (C) 23     (D) 24    (E) no error   -}


quiz = map (\(x, y) -> x + y) [(1,2), (2,3)]









-- >>> zum []
-- 0
--
-- >>> len ["carne","asada","torta"] 
-- 3
--
{- 
foo []     = 0
foo (x:xs) = 1 + foo xs
               --^^^^^^ valueFromTail 
foo []     = 0
foo (x:xs) = x + foo xs
               --^^^^^^ valueFromTail 
foo []     = ""
foo (x:xs) = x ++ foo xs
                --^^^^^^ valueFromTail 

-}

foo base op []     = base
foo base op (x:xs) = op x (foo base op xs) 

len xs = foo 0  (\x v -> 1 +  v) xs
zum xs = foo 0  (\x v -> x +  v) xs  
cat xs = foo "" (\x v -> x ++ v) xs  


{- 

foldr f b []     = b
foldr f b (x:xs) = f x (foldr f b xs)


foldr f b [x1,x2,x3,x4]

==> f x1 (foldr f b [x2,x3,x4]) 

==> f x1 (f x2 (foldr f b [x3,x4])) 

==> f x1 (f x2 (f x3 (foldr f b [x4]))) 

==> f x1 (f x2 (f x3 (f x4 (foldr f b [])))) 

==> f x1 (f x2 (f x3 (f x4 b))) 

==> x1 `f` (x2 `f` (x3 `f` (x4 `f` b))) 

    x1  : x2     : x3   :  x4    : []


zum [x1,x2,x3,x4] = foldr (+) 0 [x1,x2,x3,x4]

    x1 : x2 : x3 : x4 : []
    
    x1 ++ x2 ++ x3 ++ x4 ++ ""

-}




























