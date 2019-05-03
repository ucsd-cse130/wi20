
import Prelude hiding (sum, length, lookup, take)
import Data.Char
import Debug.Trace
import Text.Printf 

data Nat
  = Zero 
  | Succ Nat
  deriving (Eq, Show)


n0 = Zero       --                  Zero 
n1 = Succ n0    --             Succ Zero
n2 = Succ n1    --       Succ (Succ Zero) 
n3 = Succ n2    -- Succ (Succ (Succ Zero)) 

-- >>> toInt Zero
-- 0
--
-- >>> toInt (Succ Zero)
-- 1
-- >>> toInt (Succ (Succ (Succ Zero)))
-- 2
-- >>> toInt (Succ (Succ (Succ Zero)))
-- 3

-- toInt :: Nat -> Int 
toInt n = case n of 
  Zero   -> 0
  Succ m -> 1 + toInt m 

toInt' :: Nat -> Int 
toInt' Zero     = 0
toInt' (Succ n) = 1 + toInt' n

-- >>> intNat 4 
-- Succ (Succ (Succ (Succ Zero)))
--

intNat :: Int -> Nat 
intNat 0 = Zero 
intNat n = Succ (intNat (n-1))


-- A. Syntax error
-- B. Type error 
-- C. 2
-- D. Succ Zero
-- E. Succ (Succ Zero)

-- >>> add Zero Zero
-- Zero

-- >>> add Zero (Succ Zero)
-- Succ Zero 

-- >>> add Zero (Succ (Succ Zero))
-- Succ (Succ Zero)

-- >>> add (Succ Zero) Zero
-- (Succ Zero) 

-- >>> add (Succ Zero) (Succ Zero)
-- Succ (Succ Zero)

-- >>> addI (Succ Zero) (Succ (Succ Zero))
-- Succ (Succ (Succ Zero))
--

add :: Nat -> Nat -> Nat 
add Zero     m = m
add (Succ n) m = Succ (add n m)

addI :: Nat -> Nat -> Nat 
addI Zero     m = m
addI (Succ n) m = addI n (Succ m) 

-- >>> sub (Succ (Succ Zero)) ((Succ Zero))
-- Succ Zero
--

sub :: Nat -> Nat -> Nat
sub Zero     _        = Zero 
sub n        Zero     = n
sub (Succ n) (Succ m) = sub n m 

data List a 
  = Nil 
  | Cons a (List a) 
  deriving (Show)

l_1_3 :: List Int
l_1_3 = Cons 1 (Cons 2 (Cons 3 Nil))

l_4_6 :: List Int
l_4_6 = Cons 4 (Cons 5 (Cons 6 Nil))

l_1_6 :: List Int
l_1_6 = Cons 1 (Cons 2 (Cons 3 (Cons 4 (Cons 5 (Cons 6 Nil))) ))

append :: List a -> List a -> List a
append Nil         ys = ys
append (Cons x xs) ys = Cons x (append xs ys)

append                   Nil   ys =                ys    
append           (Cons x2 xs)  ys =         Cons x2 (append xs ys) 
append ((Cons 2 (Cons 3 Nil)) ys                    = Cons 2 (Cons 3 ys)

len :: List a -> Int
len Nil         = 0
len (Cons x xs) = 1 + len xs