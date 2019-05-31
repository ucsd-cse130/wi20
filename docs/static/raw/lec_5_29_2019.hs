module Lec_5_29_2019 where

-- TODO

foo :: Int -> Int
foo x = x + 1

bar :: Int -> Int
bar x = x + 1

data MyNewType = Red | Blue


thing :: MyNewType
thing = Red 

class JhalaEq a where 
    (===) :: a -> a -> Bool
    (=/=) :: a -> a -> Bool
    (=/=) t1   t2   = not (t1 === t2)

instance JhalaEq MyNewType where 
    (===) Red  Red  = True
    (===) Blue Blue = True
    (===) _    _    = False 

instance Eq MyNewType where
    (==) Red  Red  = True
    (==) Blue Blue = True
    (==) _    _    = False 

instance Show MyNewType where 
  show Red  = "Red!#$@#$@#$"
  show Blue = "Blueeueueueu"

{-
    class Show a where
        showsPrec :: Int -> a -> ShowS
        show      :: a -> String
        showList  :: [a] -> ShowS
        {-# MINIMAL showsPrec | show #-}
-}
-- Show, Eq, Ord, 


{- 
class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    {-# MINIMAL (==) | (/=) #-}
-}