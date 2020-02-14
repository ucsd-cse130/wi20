module Lec_2_12_20 where


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
