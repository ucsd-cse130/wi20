import Prelude hiding (fst, snd, sum, length, lookup, take)
import Data.Char


ex0 = (\x -> x) "apple" 

-- ex1 = (\x -> (\y -> x (x y))) (\z -> z + 1) 0
incr = \z -> z + 1 
ex1  = (\f y -> f (f y)) incr 0
      -- incr (incr 0)
      -- 2














haskellIsAwesome = True 

-- pair x y b = if b then x else y

-- pair       = \x y b -> if b then x else y
-- pair x y   = \b -> if b then x else y
-- pair x     = \y -> \b -> if b then x else y
-- pair       = \x -> \y -> \b -> if b then x else y

pair x _ True  = x 
pair _ y False = y 

fst  p         = p True
snd  p         = p False

-- >>> p1 
-- "this"
--
p1 = fst (pair "this" "that")
      -- pair "this" "that" True
      -- "this"

-- >>> p2
-- "that"
--

p2 = snd (pair "this" "that")
     -- pair "this" "that" False

ex2  = snd (pair "crapple" "orange")
        -- pair "crapple" "orange" False
        -- "orange"

-- >>> ex2
-- "orange"
--
