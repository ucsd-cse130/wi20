module Lec_3_9_20 where 

-- inc :: Int -> Int 
inc :: (Num a) => a -> a
inc x = x + 1

bloop = inc 12.2

------------------------------

data Invisible = This | That | Other 

invisibleThings = [This, That, Other]

instance Show Invisible where
    show This  = "*Inv: This*"
    show That  = "*Inv: That*"
    show Other = "*Inv: Other*"

instance Eq Invisible where
    This  == This = True
    That  == That = True
    Other ==  Other = True
    _     ==  _     = False

instance Ord Invisible where
    x <= y = (show x) <= (show y)



data Env k v
  = Def  v              -- default value `v` to be used for "missing" keys
  | Bind k v (Env k v)  -- bind key `k` to the value `v`
  deriving (Show)


add :: (Ord k) => k -> v -> Env k v -> Env k v  
add key val (Bind k v rest) 
  | key < k         = Bind key val (Bind k v rest)
  | otherwise       = Bind k v ( add key val rest )
add key val (Def v) = Bind key val (Def v)

get :: (Eq k) => k -> Env k v -> v  
get key (Bind k val rest) 
  | key == k       = val
  | otherwise      = get key rest 
get key (Def val)  = val

-- >>> add 'a' 50.0 (Def 0.0)
-- Bind 'a' 50.0 (Def 0.0)
--

-- >>> add 'c' 20.0 (Bind 'a' 50.0 (Bind 'b' 15.0 (Def 0.0)))
-- Bind 'a' 50.0 (Bind 'b' 15.0 (Bind 'c' 20.0 (Def 0.0)))
--



env0 = add 'f' 10.0 (add 'c' 20.0 (add 'a' 50.0 (Def 0.0)))

-- >>> get 'b' env0

-- >>> get "dog" env0
-- 20.0
--

-- >>> get "horse" env0

