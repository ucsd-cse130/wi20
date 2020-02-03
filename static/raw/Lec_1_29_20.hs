module Lec_1_29_20 where

mysum ::  Int -> Int 
mysum 0 = 0
mysum n = n + tmp
  where
    tmp = mysum n1 
    n1  = n - 1

isAwesome :: Bool
isAwesome = True

message :: String 
message = if False 
            then "I love 130" 
            else "I will drop 130"

inc :: Int -> Int 
-- inc = \x -> x + 1
inc x = x + 1

add :: Int -> Int -> Int 
-- add = \x -> \y -> x + y
-- add x = \y -> x + y
add x y = x + y

mystery :: Bool -> Char 
mystery = (\x -> if x then 'a' else 'b')




{- 
A. Bool -> Char 
B. Char -> Bool
C. Char 
D. Bool 
E. Type Error

-}

{- 

Why STATIC?

1. helps catch errors BEFORE you RUN CODE

    - avoid errors due to invalid operations after "changing types"

2. helps to know what kinds of values you are working with / readability  


Why DYNAMIC?

JS   -> TypeScript, Flow
Ruby -> Sorbet 
Py ->

- "faster" don't have to listen to typechecker just run code see if it works?

- less verbose; don't have to write down the type annotations 

- more "forgiving" wrt different "Versions" of language etc.

- much easier to implement - no need to implement a TYPECHECKER!

-}


{- 

  def silly():
    x = 10    
    x(5)

 -}

empty = []
l3 = 3 : empty  -- 3: [] 
l2 = 2 : l3     -- 2: 3:[]
l1 = 1 : l2     -- 1: 2: 3: []


animals :: [String]
animals = ["cat", "dog", "horse"]

ummbers :: [Int]
ummbers = [1,2,3,4]

foo (x:xs) = xs ++ x

{- 
x :: Thing
xs :: [Thing]

Thing === [Thing]
-}