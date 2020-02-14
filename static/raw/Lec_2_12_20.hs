module Lec_2_12_20 where


{- 
                Builtin vs Ours

 name of type   []       List
 name of empty  []       Null
 name of "cons" :        Cons
         "app"  ++       append      
  

 -}

-- "datatype polymorphism"
-- "generics"

data List t 
  = Nul  
  | Cons t (List t) 
  deriving (Eq, Show)

hed :: List Int -> Int
hed l = case l of
          Cons x _ -> x
          Nul      -> 0

data ListInt 
  = NulI
  | ConsI Int ListInt
  deriving (Eq, Show)

len :: List t -> Int
len Nul = 0 
len (Cons h t) = 1 + len t 


-- >>> append (Cons 1 (Cons 2 (Nul))) (Cons 4 (Cons 5 (Nul))) 
-- Cons 1 (Cons 2 (Cons 4 (Cons 5 Nul)))
--

-- >>> append (Cons 1 (Cons 2 Nul)) Nul
-- Cons 1 (Cons 2 Nul)
--

-- >>> append Nul (Cons 4 (Cons 5 Nul))
-- Cons 4 (Cons 5 Nul)
--

{- 


-}


-- []
emp = Nul

ex_3 = 3 `Cons` Nul 
hs_3 = 3 : []

ex_2_3 = Cons 2 (Cons 3 Nul) 
ex_1_2_3 = Cons 1 (Cons 2 (Cons 3 Nul)) 

ex_animals = Cons "cat" (Cons "dog" (Cons "hpippo" Nul)) 





plus x y = x + y

foo = plus 10 20
bar = 10 `plus` 20


hundred :: [Int] 
hundred = [1..100]

fav = 101

fav_hundred = fav : hundred

hundred_fav = hundred ++ [fav]
{-
fav : [1..100]

([1..100]  ++ [fav] 
 ==> 1 : (2...100) ++ [fav]
 ==> 1 : 2 : (3..100) ++ [fav] 
 ==> 1 : 2 : 3 : ... : 100 : ([] ++ [fav])
 ==> 1 : 2 : 3 : ... : 100 : [fav]
)

-}
append :: List t -> List t -> List t
append Nul l2           = l2
append (Cons h1 t1) l2  = Cons h1 (append t1 l2) 

data Tree = Leaf | Node Int Tree Tree 
  deriving (Eq,Show)

node1 = Node 1 node2 node4
node2 = (Node 2 node3 Leaf)
node3 = (Node 3 Leaf  Leaf)
node4 = (Node 4 Leaf  Leaf)

tot :: Tree -> Int
tot Leaf         = 0
tot (Node v l r) = v + tot l + tot r

size :: Tree -> Int
size Leaf         = 1
size (Node v l r) = 1 + size l + size r

sizeN :: Tree -> Int
sizeN Leaf         = 0
sizeN (Node v l r) = 1 + sizeN l + sizeN r

depth :: Tree -> Int
depth Leaf         = 0
depth (Node v l r) = 1 + max (depth l) (depth r)
