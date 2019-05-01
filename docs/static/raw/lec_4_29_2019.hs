
import Prelude hiding (sum, length, lookup, take)
import Data.Char
import Debug.Trace
import Text.Printf 

{- 

# Notes from 130 

There are two types of languages:

1. Those that people complain about
2. Those that no one uses

-}

data Para 
  = PHead Int String
  | PText String
  | PList Bool [String]


doc :: [Para]
doc = [ PHead 1 "Notes from 130"                        
      , PText "There are two types of languages:"       
      , PList True [ "Those that people complain about" 
                   , "Those that no one uses"
                   ]
      ]

-- >>> toHtml (PHead 1 "Notes from 130")
-- "<h1>Notes from 130</h1>"
--

-- >>> toHtml (PText "There are two types of langs")
-- "<p>There are two tyeps of langs</p>"
--

-- >>> toHtml (PList True ["This", "That"])
-- *** Exception: /Users/rjhala/teaching/130-sp19/static/raw/lec_4_26_2019.hs:(53,1)-(54,58): Non-exhaustive patterns in function toHtml
-- <BLANKLINE>
-- "


toHtml :: Para -> String
{- 
toHtml p = case p of 
            PHead lvl txt     -> printf "<h%d>%s<h%d>" lvl txt lvl 
            PText txt         -> printf "<p>%s</p>"        txt 
            PList True items  -> printf "<ol>%s</ol>"  undefined
            PList False items -> printf "<ul>%s</ul>" undefined
-}
toHtml (PHead lvl txt    ) = printf "<h%d>%s</h%d>" lvl txt lvl 
toHtml (PText txt        ) = printf "<p>%s</p>"        txt 
toHtml (PList True items ) = printf "<ol>%s</ol>"  "tbd"
toHtml (PList False items) = printf "<ul>%s</ul>"  "tbd"

quiz1 = 2 + 2

quiz2 = "hello!"

{-
quiz3 = case "asdasd" of 
            PText str        -> str  
            PHead lvl str    -> True
            PList ord things -> "list"
-}

{-             case exp of 
              C1 _ -> e1 :: T 
              C2 _ -> e2 :: T
-}

-------------------------------------------------------------------------------

data Silly 
  = SillyInt  Int 
  | SillyBool Bool

-- sillyFun :: Silly -> Int
sillyFun s = case s of 
               SillyInt  n     -> n 
               SillyBool True  -> 1
               SillyBool False -> 0


-------------------------------------------------------------------------------

data Day 
  = Sun 
  | Mon 
  | Tue 
  | Wed
  | Thu 
  | Fri 
  | Sat
  deriving (Eq, Show, Ord)

dayInt :: Day -> Int
dayInt d = case d of
  Sun -> 0 
  Mon -> 1 
  Tue -> 2 
  Wed -> 3
  Thu -> 4 
  Fri -> 5 
  Sat -> 6
 
------------------

data Nat
  = Zero 
  | Add1 Nat
  deriving (Eq, Show)


n0 = Zero       --                  Zero 
n1 = Add1 n0    --             Add1 Zero
n2 = Add1 n1    --       Add1 (Add1 Zero) 
n3 = Add1 n2    -- Add1 (Add1 (Add1 Zero)) 

-- >>> toInt Zero
-- 0
-- >>> toInt (Add1 Zero)
-- 1
-- >>> toInt (Add1 (Add1 Zero))
-- 2
-- >>> toInt (Add1 (Add1 (Add1 Zero)))
-- 3

-- toInt :: Nat -> Int 
toInt n = case n of 
  Zero     -> 0
  Add1 bla -> 1 + toInt bla 

intNat :: Int -> Nat 
intNat i 
 | i <= 0    = Zero 
 | otherwise = Add1 (foo (i-1))

quiz = foo 2 

foo 0 = Zero 
foo 1 = Add1 Zero
foo 2 = Add1 (Add1 Zero)

-- A. Syntax error
-- B. Type error 
-- C. 2
-- D. Add1 Zero
-- E. Add1 (Add1 Zero)

-- >>> add Zero Zero
-- Zero

-- >>> add Zero (Add1 Zero)
-- Add1 Zero 

-- >>> add Zero (Add1 (Add1 Zero))
-- Add1 (Add1 Zero)

-- >>> add (Add1 Zero) Zero
-- (Add1 Zero) 

-- >>> add (Add1 Zero) (Add1 Zero)
-- Add1 (Add1 Zero)

-- >>> add (Add1 Zero) (Add1 (Add1 Zero))
-- Add1 (Add1 (Add1 Zero))

add :: Nat -> Nat -> Nat 
add Zero     m = m 
add (Add1 n) m = add n (Add1 m)