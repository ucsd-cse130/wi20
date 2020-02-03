module Lec_1_22_20 where



fac :: Int -> Int 
fac 0 = 1
fac n = n * fac (n-1)


incr = (\z -> z + 1)
quiz = ((\f y -> f (f y)) incr) 0

-- =b> (\y -> incr (incr y)) 0 
-- =b> (incr (incr 0)) 
-- =b> (incr 1) 
-- =b> 2 




{- 
A. 0 
B. 1 
C. 2 
D. 3 
E. unspecified angst from haskell/ghci/compiler
 -}


tt   = \x y -> x 
ff   = \x y -> y 
pair x y = (\b -> b x y) 
myfst p  = p tt 
mysnd p  = p ff 

-- foo = \x y z -> blah 
foo x y z = "blah" 

data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun 
           deriving (Eq) 

-- likes Mon ==> 0
-- likes Tue ==> 0
-- likes ... ==> 0
-- likes Fri ==> 10
-- likes Sat ==> 15
-- likes Sun ==> 5

likes Fri = 10
likes Sat = 15
likes Sun = 5

{- Q: What does !!
   
   likes Mon

   evaluate to?

   A. _ 
   B. 10
   C. 15
   D. 5
   E. unspecified angst

-}


{- 
likes = \day -> if day == Fri 
                  then 10 
                  else if day == Sat 
                       then 15  
                       else if day == Sun
                            then 5
                            else 0


likes day =     if day == Fri 
                  then 10 
                  else if day == Sat 
                       then 15  
                       else if day == Sun
                            then 5
                            else 0

---
-- PATTERN
--- 

likes d   = 0
likes Fri = 10
likes Sat = 15
likes Sun = 5  



if likes Thu > 5 then "YES" else "NO"

=> 
-}










-- sum 0 = 0
-- sum 1 = 0 + 1
-- sum 2 = 0 + 1 + 2
-- sum n = 0 + 1 + ... + n

summ 0 = 0
summ n = n + summ (n-1) 


