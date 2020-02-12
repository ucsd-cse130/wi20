module Lec_2_5_20 where

import Text.Printf

doc = [ (PHeader 1 "Notes from 130")                  -- Header
      , (PText "There are two types of languages")   -- RawText
      , (PList True [ "those people complain about" 
                    , "those people use!"  
                    ])
      ]


doc2Html :: [Para] -> String 
doc2Html []     = ""
doc2Html (p:ps) = (para2Html p) ++ "\n" ++ (doc2Html ps) 

para2Html :: Para -> String
para2Html p = case p of 
                (PHeader lvl str)      -> printf "<h%d>%s</h%d>" lvl str lvl 
                (PText   str)          -> printf "<p>%s</p>" str 
                (PList   ord things)   -> printf "<%s>%s</%s>" tag (unlines (things2Html things)) tag
                                          where 
                                              tag = if ord then "ol" else "ul"

things2Html :: [String] -> [String] 
things2Html []       = [] 
things2Html (t:rest) = (printf "<li>%s</li>" t) : (things2Html rest) 


blub = unlines ["<li>foo</li>",
                "<li>bar</li>",
                "<li>baz</li>"]

{- 
 PHeader 1 "Notes from 130"  --->    <h1>Notes from 130</h1>
 <p>There are two types of languages</p>
 <ol>
    <li> those people complain about </li> 
    <li> "those people use! </li>
 </ol>
 -}

quiz = case (PText "hey!") of
          PHeader lev _ -> lev
          PText str     -> 10 -- str
          PList ord _   -> 1000 -- ord

rev :: [a] -> [a]
-- rev []    = []
-- rev (h:t) = (rev t) ++ [h]
rev xs           = helper [] xs

helper acc []    = acc 
helper acc (h:t) = helper (h:acc) t

{-
rev [1,2,3]

==> helper [] [1,2,3] 
==> helper [1]  [2,3] 
==> helper [2,1]  [3] 
==> helper [3,2,1] [] 

-}
data Para 
  = PHeader Int     String  
  | PText   String 
  | PList   Bool    [String] 
  deriving (Eq, Show)


{- Represent "natural" numbers (non-negative)


   0  --->  Zero
   1  --->  (Plus1 Zero)   
   2  --->  Plus1 (Plus1 Zero)   
   3  --->  Plus1 (Plus1 (Plus1 Zero)) 
   4  --->  Plus1 (Plus1 (Plus1 (Plus1 Zero))) 

 -}


data Nat = Zero 
         | Plus1 Nat
         deriving (Eq, Show)

-- >>> toInt Zero
-- 0

-- >>> toInt (Plus1 Zero) 
-- 1

-- >>> toInt (Plus1 (Plus1 Zero))  
-- 2

-- >>> toInt (Plus1 (Plus1 (Plus1 Zero)))
-- 3
--

toInt :: Nat -> Int 
toInt Zero                 = 0
toInt (Plus1 n)            = 1 + toInt n

-- toNat :: Int -> Nat
-- toNat n 
--   | n <= 0    = Zero 
--   | otherwise = Plus1 (toNat (n-1))

--  foo 2 
--  ==> if 2 <= 0 then Zero else Plus1 (foo (2-1))
--  ==> Plus1 (foo (2-1))
--  ==> Plus1 (foo 1)
--  ==> Plus1 (Plus1 (foo 0)) 
--  ==> Plus1 (Plus1 (Zero)) 



-- >>> add Zero Zero
-- Zero

-- >>> add Zero (Plus1 Zero)
-- (Plus1 Zero)

-- >>> add (Plus1 Zero) Zero
-- (Plus1 Zero)

-- >>> add (Plus1 (Plus1 Zero)) (Plus1 Zero)
-- Plus1 (Plus1 (Plus1 Zero))
--

-- add n1 n2 = toNat ((toInt n1) + (toInt n2))


-- add Zero        (Plus1 (Plus1 Zero))      ===> PLus1 (Plus1 Zero)
-- add Zero         m   ===> m 
-- add (Plus1 Zero) m   ===> Plus1 (add Zero m) ==> Plus1 m 
-- add (Plus1 (Plus1 Zero)) m   
--  ==> Plus1 (add (Plus1 Zero) m) 
--  ==> Plus1 (Plus1 (add Zero m))
--  ==> Plus1 (Plus1 m)

-- add Zero n2 = n2 
add :: Nat -> Nat -> Nat
add Zero       m = m 
add (Plus1 n)  m = Plus1 (add n m)

data Expr = ENum Double | EAdd Expr Expr | EMul Expr Expr
  deriving (Show)

-- 2.9 + 4.5   ==> EAdd (ENum 2.9) (ENum 4.5)
-- 3.1 * 4.2   ==> EMul  (ENum 3.1) (ENum 4.2)


-- >>> eval (ENum 2.9)
-- 2.9
--

-- >>> eval (EAdd (ENum 2.9) (ENum 4.5))
-- 7.4
--

-- >>> eval (EAdd (ENum 3.1) (ENum 4.2))
-- 7.300000000000001
--


eval :: Expr -> Double
eval (ENum n)     = n
eval (EAdd e1 e2) = eval e1 + eval e2
eval (EMul e1 e2) = eval e1 * eval e2

quiz = let p = PText "hey" 
       in
         case p of
           PText _ -> 1