module Lec_5_31_2019 where

data MyNewType = Red | Blue

thing :: MyNewType
thing = Red 

class JhalaEq a where 
    (===) :: a -> a -> Bool
    (=/=) :: a -> a -> Bool
    (=/=) t1 t2   = not (t1 === t2)

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

