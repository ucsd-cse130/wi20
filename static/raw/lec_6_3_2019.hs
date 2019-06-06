{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleInstances    #-}
{-# LANGUAGE OverlappingInstances #-}

module Lec_6_3_2019 where


thing :: MyNewType
thing = Red 
instance Eq MyNewType where
    (==) Red  Red  = True
    (==) Blue Blue = True
    (==) _    _    = False 

instance Show MyNewType where 
  show Red  = "RedRed"
  show Blue = "BlueBlue"

class JhalaEq a where 
    equal    :: a -> a -> Bool
    notEqual :: a -> a -> Bool
    notEqual x y = not (equal x y)

data MyNewType = Blue | Red 
  deriving (Eq, Ord, Show)

instance JhalaEq MyNewType where 
    equal Red  Red  = True
    equal Blue Blue = True
    equal _    _    = False 

{-
-}

data Env key valu 
  = Default valu 
  | Bind key valu (Env key valu)
  deriving (Show)

lookupEnv :: (Eq k) => k -> Env k v -> v 
lookupEnv key (Default val)   = val
lookupEnv key (Bind k v rest) 
  | key == k  = v
  | otherwise = lookupEnv key rest

insert :: k -> v -> Env k v -> Env k v
insert key val env = Bind key val env



-------------------------------------------------------------------------------

-- mapList :: (a -> b) -> [a] -> [b]

-- mapEnv  :: (a -> b) -> Env k a -> Env k b

-- mapTree :: (a -> b) -> Tree a -> Tree b
data Tree a 
  = Leaf 
  | Node a (Tree a) (Tree a)



data JVal
  = JStr  String
  | JNum  Double
  | JBool Bool
  | JArr  [JVal]
  | JObj  [(String, JVal)]
  deriving (Eq, Ord, Show)

wierd = ("Ranjit", [41.0, 23.1], ["guacamole", "coffee", "burrito"])

class JValuable a where 
  jval :: a -> JVal 

instance JValuable Double where 
  jval n = JNum n

instance JValuable Bool where 
  jval n = JBool n

instance JValuable String where 
  jval n = JStr n

instance (JValuable a) => JValuable [a] where
  jval ns = JArr (map jval ns)

instance (JValuable a, JValuable b) => JValuable (a, b) where 
  jval (x, y) = JObj [ ("fst", jval x), ("snd", jval y)]

instance (JValuable a, JValuable b, JValuable c) => JValuable (a, b, c) where 
  jval (x, y, z) = JObj [ ("fst", jval x), ("snd", jval y), ("thd", jval z)]

instance JValuable a => JValuable [(String, a)] where
  jval kvs = JObj [ (fld, jval v) | (fld, v) <- kvs ]

envList :: Env String a -> [(String, a)]
envList (Default v)  = [("def", v)]
envList (Bind k v r) = (k, v) : envList r

-- A. OK! 
-- B. NO! NO NO NO NO NO NO!


-- A: foo :: [String] -> JVal
-- B: foo :: [Double] -> JVal
-- C: foo :: [Bool]   -> JVal
-- D: foo :: [a]      -> JVal
-- E: foo :: MYSTERY-TYPE-OR-CRASH 











-- STUFF-TO-JVAL