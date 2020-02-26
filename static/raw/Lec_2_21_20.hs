module Lec_2_21_20 where

import Prelude hiding (foldl, sum, map, filter)
import Data.Char (toUpper)

incr :: Int -> Int
incr x = x + 1

sum :: [Int] -> Int
sum []     = 0
sum (x:xs) = x + sum xs

-- >>> sumTR [1,2,3,4,5,6] 
-- 21
--



{- 
sumTR [1,2,3,4,5,6] 
==> loop 0    [1,2,3]
==> loop (0+1)  [2,3]
==> loop (0+1+2)  [3]
==> loop (0+1+2+3) []
==> 6
-}

-- >>> cat ["hello", "goodbye", "back"]
-- "hello, goodbye, back, "
--

cat :: [String] -> String
cat [] = ""
cat (x:xs) = x ++ ", " ++ cat xs

-- >>> catTR ["hello", "goodbye", "back"]
-- "hello, goodbye, back, "
--
{- 
catTR ["hello", "goodbye", "back"]
loop "" ["hello", "goodbye", "back"]
==> loop "hello, " ["goodbye", "back"] 
            acc       x
==> loop "hello, goodbye, " ["back"] 
            acc'
==> "hello, goodbye, back, "
-}

catTR xs = foldl (\acc x -> acc ++ x ++ ", ") "" xs

-- catTR xs = loop "" xs 
--   where
--     loop acc []     = acc  
--     loop acc (x:xs) = loop (acc ++ x ++ ", ") xs

sumTR xs = foldl (\acc x -> acc + x)  0 xs 
-- sumTR xs = loop 0 xs
--   where
    -- loop acc []     = acc
    -- loop acc (x:xs) = loop (acc + x) xs 

foldl f b xs = loop b xs  
  where
    loop acc []     = acc
    loop acc (x:xs) = loop (f acc x) xs 


{- 
foldl f b [a1, a2, a3, a4] 
==> loop b [a1, a2, a3, a4] 
==> loop (f b a1) [a2, a3, a4]
==> loop (f (f b a1) a2) [a3, a4]
==> loop (f (f (f b a1) a2) a3) [a4]
==> loop (f (f (f (f b a1) a2) a3) a4) []
==> (f (f (f (f b a1) a2) a3) a4) 
==> ((((b `f` a1) `f` a2) `f` a3) `f` a4) 
-}














{- 
foldl (\acc x -> x : acc) [] [1,2,3]

loop [] [1,2,3] 
==> loop (1:[]) [2,3] 
==> loop (2:1:[]) [3] 
==> loop (3:2:1:[]) [] 
==> (3:2:1:[]) 
==> [3,2,1]
-}